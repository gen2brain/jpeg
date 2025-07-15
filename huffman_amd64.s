//go:build amd64 && !noasm

#include "textflag.h"

// Constants for code lengths 1 to 8 (low group).
DATA ·k_values_low+0(SB)/4, $1
DATA ·k_values_low+4(SB)/4, $2
DATA ·k_values_low+8(SB)/4, $3
DATA ·k_values_low+12(SB)/4, $4
DATA ·k_values_low+16(SB)/4, $5
DATA ·k_values_low+20(SB)/4, $6
DATA ·k_values_low+24(SB)/4, $7
DATA ·k_values_low+28(SB)/4, $8
GLOBL ·k_values_low(SB), RODATA, $32

// Constants for code lengths 9 to 16 (high group).
DATA ·k_values_high+0(SB)/4, $9
DATA ·k_values_high+4(SB)/4, $10
DATA ·k_values_high+8(SB)/4, $11
DATA ·k_values_high+12(SB)/4, $12
DATA ·k_values_high+16(SB)/4, $13
DATA ·k_values_high+20(SB)/4, $14
DATA ·k_values_high+24(SB)/4, $15
DATA ·k_values_high+28(SB)/4, $16
GLOBL ·k_values_high(SB), RODATA, $32

// Masks for code lengths 1 to 8.
DATA ·masks_low+0(SB)/4, $1
DATA ·masks_low+4(SB)/4, $3
DATA ·masks_low+8(SB)/4, $7
DATA ·masks_low+12(SB)/4, $15
DATA ·masks_low+16(SB)/4, $31
DATA ·masks_low+20(SB)/4, $63
DATA ·masks_low+24(SB)/4, $127
DATA ·masks_low+28(SB)/4, $255
GLOBL ·masks_low(SB), RODATA, $32

// Masks for code lengths 9 to 16.
DATA ·masks_high+0(SB)/4, $511
DATA ·masks_high+4(SB)/4, $1023
DATA ·masks_high+8(SB)/4, $2047
DATA ·masks_high+12(SB)/4, $4095
DATA ·masks_high+16(SB)/4, $8191
DATA ·masks_high+20(SB)/4, $16383
DATA ·masks_high+24(SB)/4, $32767
DATA ·masks_high+28(SB)/4, $65535
GLOBL ·masks_high(SB), RODATA, $32

// func decodeHuffmanAVX2(d *decoder, h *huffman) (uint8, int)
TEXT ·decodeHuffmanAVX2(SB), NOSPLIT, $0-32
	// Load decoder pointer into DI. DI holds the pointer to the decoder struct.
	MOVQ d+0(FP), DI

	// Load huffman pointer into SI. SI holds the pointer to the huffman struct.
	MOVQ h+8(FP), SI

	// Check if DI (decoder) is nil; if so, jump to nil_pointer handler.
	TESTQ DI, DI
	JZ    nil_pointer

	// Check if SI (huffman) is nil; if so, jump to nil_pointer handler.
	TESTQ SI, SI
	JZ    nil_pointer

	// Load h.nCodes (int32 at offset 0) into AX. If zero, table uninitialized.
	MOVL  0(SI), AX
	TESTL AX, AX
	JZ    uninitialized

fast_path:
	// Fast path using LUT for codes <= 8 bits.
	// Load bits.a (uint32 at offset 16 in decoder) into BX. BX now holds the accumulator bits.
	MOVL 16(DI), BX

	// Load bits.n (int32 at offset 24 in decoder) into AX. AX holds the number of valid bits in the accumulator.
	MOVL 24(DI), AX

	// Compute shift: CX = bits.n - 8 to align top 8 bits. CX is the shift amount to get the next 8 bits.
	MOVL AX, CX
	SUBL $8, CX

	// Shift BX right by CX to get the next 8 bits in low byte. After shift, BX holds the 8-bit code in its low byte.
	SHRL CL, BX

	// Mask BX to 0xff for LUT index. Ensure BX is only the 8-bit index.
	ANDL $0xff, BX

	// Multiply index by 2 (uint16 entries). Since LUT entries are 2 bytes each.
	SHLL $1, BX

	// Load LUT entry (uint16) from h.lut (offset 4) into DX. DX holds the LUT value: high 8 bits symbol, low 8 bits length+1 or 0.
	MOVW 4(SI)(BX*1), DX

	// Extract symbol: R8 = DX >> 8. R8 holds the symbol (uint8, but in register).
	MOVL DX, R8
	SHRL $8, R8

	// Extract length +1: DX &= 0xff. DX now holds the length+1 or 0.
	ANDL $0xff, DX

	// If DX == 0, code >8 bits or invalid; go to slow path.
	TESTL DX, DX
	JZ    slow_path_entry

	// Actual length: DX -=1. DX now holds the actual code length (1-8).
	SUBL $1, DX

	// Update bits.n -= length. Subtract the length from bits.n in the decoder struct.
	MOVL 24(DI), AX
	SUBL DX, AX
	MOVL AX, 24(DI)

	// Update bits.m >>= length. Shift the mask right by the length.
	MOVL 20(DI), AX
	MOVL DX, CX
	SHRL CL, AX
	MOVL AX, 20(DI)

	// Return symbol (R8 low byte) and 0 (success). Store the symbol and error code 0.
	MOVB R8B, ret0+16(FP)
	MOVQ $0, ret1+24(FP)
	JMP  done

slow_path_entry:
	// Slow path: Use AVX2 to check lengths 9-16 in parallel, since fast path missed, implying length >8.
	// Y15 = all -1s (0xffffffff in each dword) for mask inversion.
	// Use VPCMPEQD to set all bits to 1 by comparing a register to itself. Y15 now holds all -1s in each 32-bit lane.
	VPCMPEQD Y15, Y15, Y15

	// Y14 = all 0s for clamping and comparisons. Clear Y14 to all zeros.
	VPXOR Y14, Y14, Y14

	// Broadcast bits.n to all dwords in Y5. Y5 holds bits.n replicated in all 8 32-bit lanes.
	VPBROADCASTD 24(DI), Y5

	// Broadcast bits.a to all dwords in Y0. Y0 holds bits.a replicated in all 8 32-bit lanes.
	VPBROADCASTD 16(DI), Y0

	// ---- High group (lengths 9-16) only, since fast path handles <=8 ----
	// Load lengths [9,10,11,12,13,14,15,16] into Y6. Y6 holds the code lengths for the high group.
	VMOVDQU ·k_values_high(SB), Y6

	// Shifts: Y4 = n - k. Compute shift amounts for each length (bits.n - length).
	VPSUBD Y6, Y5, Y4

	// Clamp >=0: max(Y4, 0). Ensure shifts are non-negative using VPMAXSD.
	VPMAXSD Y14, Y4, Y4

	// Codes: Y3 = a >> shifts. Variable shift right for each lane to extract codes.
	VPSRLVD Y4, Y0, Y3

	// Masks for 9-16 into Y1. Load masks for high group.
	VMOVDQU ·masks_high(SB), Y1

	// Apply masks: Y3 &= Y1. Mask the codes to the appropriate bit length.
	VPAND Y3, Y1, Y3

	// Validity: k > n ? -1 : 0. Compare if length > bits.n for each lane.
	VPCMPGTD Y5, Y6, Y13

	// Invert: k <= n ? -1 : 0. XOR with all -1s to invert the mask.
	VPXOR Y15, Y13, Y13

	// minCodes[8:16] into Y10. Load minCodes for lengths 9-16 (offset 772 + 32 = 804).
	VMOVDQU 804(SI), Y10

	// maxCodes[8:16] into Y11. Load maxCodes for lengths 9-16 (offset 836 + 32 = 868).
	VMOVDQU 868(SI), Y11

	// min > code: Y12 = (Y10 > Y3) ? -1 : 0. Check if code < min.
	VPCMPGTD Y3, Y10, Y12

	// code >= min: invert. XOR to get >= min mask.
	VPXOR Y15, Y12, Y12

	// code > max: Y2 = (Y3 > Y11) ? -1 : 0. Check if code > max.
	VPCMPGTD Y11, Y3, Y2

	// code <= max: invert. XOR to get <= max mask.
	VPXOR Y15, Y2, Y2

	// >= min && <= max. AND the two masks.
	VPAND Y12, Y2, Y12

	// && valid. AND with validity mask to get final match mask for high group.
	VPAND Y12, Y13, Y2 // High match mask in Y2.

	// Get MSB mask from high (Y2) into AX. VPMOVMSKB extracts MSBs into AX (32-bit mask, 4 bits per dword since 256/32=8, but MSBs only).
	VPMOVMSKB Y2, AX

	// If AX !=0, match in high.
	TESTL AX, AX
	JNZ   found_match

	// No matches.
	// Load bits.n into AX.
	MOVL 24(DI), AX

	// If n >=16, bad code.
	CMPL AX, $16
	JGE  bad_code

	// Else, need more bits; return 7.
	MOVB $0, ret0+16(FP)
	MOVQ $7, ret1+24(FP)
	JMP  done

found_match:
	// Match in high group (lengths 9-16).
	// Find position of first 1 bit in mask (TZCNT returns count of trailing zeros). BX holds the bit position (0-31).
	TZCNTL AX, BX

	// Group index 0-7. Divide by 4 since each dword's MSB is every 4 bits.
	SHRL $2, BX

	// R12 = index +8 (8-15 for high group lengths 9-16).
	MOVL BX, R12
	ADDL $8, R12

extract_symbol:
	// Extract code from Y3 at dword BX (0-7). Y3 holds the computed codes for the 8 lengths.
	// Copy BX to R9 for lane check. R9 used to determine if high or low 128-bit lane.
	MOVQ BX, R9

	// If BX >=4, extract upper 128-bit lane.
	CMPL R9, $4
	JAE  extract_high_lane

	// Low lane: extract lower 128 bits of Y3 to X3. X3 now holds the lower 4 dwords.
	VEXTRACTI128 $0, Y3, X3

	// Branch on R9 (0-3) to select VPEXTRD index. Depending on the index, extract the dword to R13.
	CMPL R9, $0
	JE   ex_0
	CMPL R9, $1
	JE   ex_1
	CMPL R9, $2
	JE   ex_2

	// Index 3: Extract the 3rd dword (index 3) from X3 to R13. R13 holds the code value.
	VPEXTRD $3, X3, R13
	JMP     extract_done

ex_0:
	// Index 0: Extract the 0th dword from X3 to R13.
	VPEXTRD $0, X3, R13
	JMP     extract_done

ex_1:
	// Index 1: Extract the 1st dword from X3 to R13.
	VPEXTRD $1, X3, R13
	JMP     extract_done

ex_2:
	// Index 2: Extract the 2nd dword from X3 to R13.
	VPEXTRD $2, X3, R13
	JMP     extract_done

extract_high_lane:
	// High lane: extract upper 128 bits to X3. X3 now holds the upper 4 dwords (indices 4-7).
	VEXTRACTI128 $1, Y3, X3

	// Adjust R9 -=4 (now 0-3 for lane). Adjust index for the lane.
	SUBL $4, R9

	// Branch on adjusted R9.
	CMPL R9, $0
	JE   ex_0h
	CMPL R9, $1
	JE   ex_1h
	CMPL R9, $2
	JE   ex_2h

	// Index 3.
	VPEXTRD $3, X3, R13
	JMP     extract_done

ex_0h:
	VPEXTRD $0, X3, R13
	JMP     extract_done

ex_1h:
	VPEXTRD $1, X3, R13
	JMP     extract_done

ex_2h:
	VPEXTRD $2, X3, R13
	JMP     extract_done

extract_done:
	// R13 = code (int32). R13 holds the extracted code value.
	// CX = length index (R12, 8-15 for high).
	MOVL R12, CX

	// Load minCodes[CX] into AX. AX = minCodes[length-1].
	MOVL 772(SI)(CX*4), AX

	// code -= min: R13 -= AX. Subtract minCode to get the offset.
	SUBL AX, R13

	// Load valsIndices[CX] into DX. DX = valsIndices[length-1].
	MOVL 900(SI)(CX*4), DX

	// Offset: R13 += DX. Add the vals index to get the final index in vals.
	ADDL DX, R13

	// Load symbol: vals[offset] (uint8) into R8 (zero-extend). R8 holds the decoded symbol.
	MOVBQZX 516(SI)(R13*1), R8

	// Length = index +1. R12 = actual length (9-16).
	ADDL $1, R12

	// Update bits.n -= length. Subtract length from bits.n.
	MOVL 24(DI), AX
	SUBL R12, AX
	MOVL AX, 24(DI)

	// Update bits.m >>= length. Shift mask right by length.
	MOVL 20(DI), AX
	MOVL R12, CX
	SHRL CL, AX
	MOVL AX, 20(DI)

	// Return symbol and 0.
	MOVB R8B, ret0+16(FP)
	MOVQ $0, ret1+24(FP)
	JMP  done

nil_pointer:
	// Return 0,1 for nil pointer.
	MOVB $0, ret0+16(FP)
	MOVQ $1, ret1+24(FP)
	JMP  done

uninitialized:
	// Return 0,2 for uninitialized.
	MOVB $0, ret0+16(FP)
	MOVQ $2, ret1+24(FP)
	JMP  done

bad_code:
	// Return 0,3 for bad code.
	MOVB $0, ret0+16(FP)
	MOVQ $3, ret1+24(FP)
	JMP  done

done:
	// Clear upper YMM to avoid AVX-SSE penalty. VZEROUPPER clears the upper 128 bits of all YMM registers.
	VZEROUPPER
	RET

