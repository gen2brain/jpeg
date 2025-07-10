//go:build amd64 && !noasm

#include "go_asm.h"
#include "funcdata.h"
#include "textflag.h"

// FDCT Constants (13-bit fixed point, constBits=13)
DATA ·fix_0_298631336<>(SB)/4, $2446
DATA ·fix_0_298631336<>+4(SB)/4, $2446
DATA ·fix_0_298631336<>+8(SB)/4, $2446
DATA ·fix_0_298631336<>+12(SB)/4, $2446
DATA ·fix_0_298631336<>+16(SB)/4, $2446
DATA ·fix_0_298631336<>+20(SB)/4, $2446
DATA ·fix_0_298631336<>+24(SB)/4, $2446
DATA ·fix_0_298631336<>+28(SB)/4, $2446
GLOBL ·fix_0_298631336<>(SB), RODATA, $32

DATA ·fix_0_390180644<>(SB)/4, $3196
DATA ·fix_0_390180644<>+4(SB)/4, $3196
DATA ·fix_0_390180644<>+8(SB)/4, $3196
DATA ·fix_0_390180644<>+12(SB)/4, $3196
DATA ·fix_0_390180644<>+16(SB)/4, $3196
DATA ·fix_0_390180644<>+20(SB)/4, $3196
DATA ·fix_0_390180644<>+24(SB)/4, $3196
DATA ·fix_0_390180644<>+28(SB)/4, $3196
GLOBL ·fix_0_390180644<>(SB), RODATA, $32

DATA ·fix_0_541196100<>(SB)/4, $4433
DATA ·fix_0_541196100<>+4(SB)/4, $4433
DATA ·fix_0_541196100<>+8(SB)/4, $4433
DATA ·fix_0_541196100<>+12(SB)/4, $4433
DATA ·fix_0_541196100<>+16(SB)/4, $4433
DATA ·fix_0_541196100<>+20(SB)/4, $4433
DATA ·fix_0_541196100<>+24(SB)/4, $4433
DATA ·fix_0_541196100<>+28(SB)/4, $4433
GLOBL ·fix_0_541196100<>(SB), RODATA, $32

DATA ·fix_0_765366865<>(SB)/4, $6270
DATA ·fix_0_765366865<>+4(SB)/4, $6270
DATA ·fix_0_765366865<>+8(SB)/4, $6270
DATA ·fix_0_765366865<>+12(SB)/4, $6270
DATA ·fix_0_765366865<>+16(SB)/4, $6270
DATA ·fix_0_765366865<>+20(SB)/4, $6270
DATA ·fix_0_765366865<>+24(SB)/4, $6270
DATA ·fix_0_765366865<>+28(SB)/4, $6270
GLOBL ·fix_0_765366865<>(SB), RODATA, $32

DATA ·fix_0_899976223<>(SB)/4, $7373
DATA ·fix_0_899976223<>+4(SB)/4, $7373
DATA ·fix_0_899976223<>+8(SB)/4, $7373
DATA ·fix_0_899976223<>+12(SB)/4, $7373
DATA ·fix_0_899976223<>+16(SB)/4, $7373
DATA ·fix_0_899976223<>+20(SB)/4, $7373
DATA ·fix_0_899976223<>+24(SB)/4, $7373
DATA ·fix_0_899976223<>+28(SB)/4, $7373
GLOBL ·fix_0_899976223<>(SB), RODATA, $32

DATA ·fix_1_175875602<>(SB)/4, $9633
DATA ·fix_1_175875602<>+4(SB)/4, $9633
DATA ·fix_1_175875602<>+8(SB)/4, $9633
DATA ·fix_1_175875602<>+12(SB)/4, $9633
DATA ·fix_1_175875602<>+16(SB)/4, $9633
DATA ·fix_1_175875602<>+20(SB)/4, $9633
DATA ·fix_1_175875602<>+24(SB)/4, $9633
DATA ·fix_1_175875602<>+28(SB)/4, $9633
GLOBL ·fix_1_175875602<>(SB), RODATA, $32

DATA ·fix_1_501321110<>(SB)/4, $12299
DATA ·fix_1_501321110<>+4(SB)/4, $12299
DATA ·fix_1_501321110<>+8(SB)/4, $12299
DATA ·fix_1_501321110<>+12(SB)/4, $12299
DATA ·fix_1_501321110<>+16(SB)/4, $12299
DATA ·fix_1_501321110<>+20(SB)/4, $12299
DATA ·fix_1_501321110<>+24(SB)/4, $12299
DATA ·fix_1_501321110<>+28(SB)/4, $12299
GLOBL ·fix_1_501321110<>(SB), RODATA, $32

DATA ·fix_1_847759065<>(SB)/4, $15137
DATA ·fix_1_847759065<>+4(SB)/4, $15137
DATA ·fix_1_847759065<>+8(SB)/4, $15137
DATA ·fix_1_847759065<>+12(SB)/4, $15137
DATA ·fix_1_847759065<>+16(SB)/4, $15137
DATA ·fix_1_847759065<>+20(SB)/4, $15137
DATA ·fix_1_847759065<>+24(SB)/4, $15137
DATA ·fix_1_847759065<>+28(SB)/4, $15137
GLOBL ·fix_1_847759065<>(SB), RODATA, $32

DATA ·fix_1_961570560<>(SB)/4, $16069
DATA ·fix_1_961570560<>+4(SB)/4, $16069
DATA ·fix_1_961570560<>+8(SB)/4, $16069
DATA ·fix_1_961570560<>+12(SB)/4, $16069
DATA ·fix_1_961570560<>+16(SB)/4, $16069
DATA ·fix_1_961570560<>+20(SB)/4, $16069
DATA ·fix_1_961570560<>+24(SB)/4, $16069
DATA ·fix_1_961570560<>+28(SB)/4, $16069
GLOBL ·fix_1_961570560<>(SB), RODATA, $32

DATA ·fix_2_053119869<>(SB)/4, $16819
DATA ·fix_2_053119869<>+4(SB)/4, $16819
DATA ·fix_2_053119869<>+8(SB)/4, $16819
DATA ·fix_2_053119869<>+12(SB)/4, $16819
DATA ·fix_2_053119869<>+16(SB)/4, $16819
DATA ·fix_2_053119869<>+20(SB)/4, $16819
DATA ·fix_2_053119869<>+24(SB)/4, $16819
DATA ·fix_2_053119869<>+28(SB)/4, $16819
GLOBL ·fix_2_053119869<>(SB), RODATA, $32

DATA ·fix_2_562915447<>(SB)/4, $20995
DATA ·fix_2_562915447<>+4(SB)/4, $20995
DATA ·fix_2_562915447<>+8(SB)/4, $20995
DATA ·fix_2_562915447<>+12(SB)/4, $20995
DATA ·fix_2_562915447<>+16(SB)/4, $20995
DATA ·fix_2_562915447<>+20(SB)/4, $20995
DATA ·fix_2_562915447<>+24(SB)/4, $20995
DATA ·fix_2_562915447<>+28(SB)/4, $20995
GLOBL ·fix_2_562915447<>(SB), RODATA, $32

DATA ·fix_3_072711026<>(SB)/4, $25172
DATA ·fix_3_072711026<>+4(SB)/4, $25172
DATA ·fix_3_072711026<>+8(SB)/4, $25172
DATA ·fix_3_072711026<>+12(SB)/4, $25172
DATA ·fix_3_072711026<>+16(SB)/4, $25172
DATA ·fix_3_072711026<>+20(SB)/4, $25172
DATA ·fix_3_072711026<>+24(SB)/4, $25172
DATA ·fix_3_072711026<>+28(SB)/4, $25172
GLOBL ·fix_3_072711026<>(SB), RODATA, $32

DATA ·fix_neg_0_390180644<>(SB)/4, $-3196
DATA ·fix_neg_0_390180644<>+4(SB)/4, $-3196
DATA ·fix_neg_0_390180644<>+8(SB)/4, $-3196
DATA ·fix_neg_0_390180644<>+12(SB)/4, $-3196
DATA ·fix_neg_0_390180644<>+16(SB)/4, $-3196
DATA ·fix_neg_0_390180644<>+20(SB)/4, $-3196
DATA ·fix_neg_0_390180644<>+24(SB)/4, $-3196
DATA ·fix_neg_0_390180644<>+28(SB)/4, $-3196
GLOBL ·fix_neg_0_390180644<>(SB), RODATA, $32

DATA ·fix_neg_0_899976223<>(SB)/4, $-7373
DATA ·fix_neg_0_899976223<>+4(SB)/4, $-7373
DATA ·fix_neg_0_899976223<>+8(SB)/4, $-7373
DATA ·fix_neg_0_899976223<>+12(SB)/4, $-7373
DATA ·fix_neg_0_899976223<>+16(SB)/4, $-7373
DATA ·fix_neg_0_899976223<>+20(SB)/4, $-7373
DATA ·fix_neg_0_899976223<>+24(SB)/4, $-7373
DATA ·fix_neg_0_899976223<>+28(SB)/4, $-7373
GLOBL ·fix_neg_0_899976223<>(SB), RODATA, $32

DATA ·fix_neg_1_961570560<>(SB)/4, $-16069
DATA ·fix_neg_1_961570560<>+4(SB)/4, $-16069
DATA ·fix_neg_1_961570560<>+8(SB)/4, $-16069
DATA ·fix_neg_1_961570560<>+12(SB)/4, $-16069
DATA ·fix_neg_1_961570560<>+16(SB)/4, $-16069
DATA ·fix_neg_1_961570560<>+20(SB)/4, $-16069
DATA ·fix_neg_1_961570560<>+24(SB)/4, $-16069
DATA ·fix_neg_1_961570560<>+28(SB)/4, $-16069
GLOBL ·fix_neg_1_961570560<>(SB), RODATA, $32

DATA ·fix_neg_2_562915447<>(SB)/4, $-20995
DATA ·fix_neg_2_562915447<>+4(SB)/4, $-20995
DATA ·fix_neg_2_562915447<>+8(SB)/4, $-20995
DATA ·fix_neg_2_562915447<>+12(SB)/4, $-20995
DATA ·fix_neg_2_562915447<>+16(SB)/4, $-20995
DATA ·fix_neg_2_562915447<>+20(SB)/4, $-20995
DATA ·fix_neg_2_562915447<>+24(SB)/4, $-20995
DATA ·fix_neg_2_562915447<>+28(SB)/4, $-20995
GLOBL ·fix_neg_2_562915447<>(SB), RODATA, $32

// IDCT Constants (11-bit fixed point)
DATA ·w1<>(SB)/4, $2841
DATA ·w1<>+4(SB)/4, $2841
DATA ·w1<>+8(SB)/4, $2841
DATA ·w1<>+12(SB)/4, $2841
DATA ·w1<>+16(SB)/4, $2841
DATA ·w1<>+20(SB)/4, $2841
DATA ·w1<>+24(SB)/4, $2841
DATA ·w1<>+28(SB)/4, $2841
GLOBL ·w1<>(SB), RODATA, $32

DATA ·w2<>(SB)/4, $2676
DATA ·w2<>+4(SB)/4, $2676
DATA ·w2<>+8(SB)/4, $2676
DATA ·w2<>+12(SB)/4, $2676
DATA ·w2<>+16(SB)/4, $2676
DATA ·w2<>+20(SB)/4, $2676
DATA ·w2<>+24(SB)/4, $2676
DATA ·w2<>+28(SB)/4, $2676
GLOBL ·w2<>(SB), RODATA, $32

DATA ·w3<>(SB)/4, $2408
DATA ·w3<>+4(SB)/4, $2408
DATA ·w3<>+8(SB)/4, $2408
DATA ·w3<>+12(SB)/4, $2408
DATA ·w3<>+16(SB)/4, $2408
DATA ·w3<>+20(SB)/4, $2408
DATA ·w3<>+24(SB)/4, $2408
DATA ·w3<>+28(SB)/4, $2408
GLOBL ·w3<>(SB), RODATA, $32

DATA ·w5<>(SB)/4, $1609
DATA ·w5<>+4(SB)/4, $1609
DATA ·w5<>+8(SB)/4, $1609
DATA ·w5<>+12(SB)/4, $1609
DATA ·w5<>+16(SB)/4, $1609
DATA ·w5<>+20(SB)/4, $1609
DATA ·w5<>+24(SB)/4, $1609
DATA ·w5<>+28(SB)/4, $1609
GLOBL ·w5<>(SB), RODATA, $32

DATA ·w6<>(SB)/4, $1108
DATA ·w6<>+4(SB)/4, $1108
DATA ·w6<>+8(SB)/4, $1108
DATA ·w6<>+12(SB)/4, $1108
DATA ·w6<>+16(SB)/4, $1108
DATA ·w6<>+20(SB)/4, $1108
DATA ·w6<>+24(SB)/4, $1108
DATA ·w6<>+28(SB)/4, $1108
GLOBL ·w6<>(SB), RODATA, $32

DATA ·w7<>(SB)/4, $565
DATA ·w7<>+4(SB)/4, $565
DATA ·w7<>+8(SB)/4, $565
DATA ·w7<>+12(SB)/4, $565
DATA ·w7<>+16(SB)/4, $565
DATA ·w7<>+20(SB)/4, $565
DATA ·w7<>+24(SB)/4, $565
DATA ·w7<>+28(SB)/4, $565
GLOBL ·w7<>(SB), RODATA, $32

DATA ·w1_plus_w7<>(SB)/4, $3406
DATA ·w1_plus_w7<>+4(SB)/4, $3406
DATA ·w1_plus_w7<>+8(SB)/4, $3406
DATA ·w1_plus_w7<>+12(SB)/4, $3406
DATA ·w1_plus_w7<>+16(SB)/4, $3406
DATA ·w1_plus_w7<>+20(SB)/4, $3406
DATA ·w1_plus_w7<>+24(SB)/4, $3406
DATA ·w1_plus_w7<>+28(SB)/4, $3406
GLOBL ·w1_plus_w7<>(SB), RODATA, $32

DATA ·w1_minus_w7<>(SB)/4, $2276
DATA ·w1_minus_w7<>+4(SB)/4, $2276
DATA ·w1_minus_w7<>+8(SB)/4, $2276
DATA ·w1_minus_w7<>+12(SB)/4, $2276
DATA ·w1_minus_w7<>+16(SB)/4, $2276
DATA ·w1_minus_w7<>+20(SB)/4, $2276
DATA ·w1_minus_w7<>+24(SB)/4, $2276
DATA ·w1_minus_w7<>+28(SB)/4, $2276
GLOBL ·w1_minus_w7<>(SB), RODATA, $32

DATA ·w2_plus_w6<>(SB)/4, $3784
DATA ·w2_plus_w6<>+4(SB)/4, $3784
DATA ·w2_plus_w6<>+8(SB)/4, $3784
DATA ·w2_plus_w6<>+12(SB)/4, $3784
DATA ·w2_plus_w6<>+16(SB)/4, $3784
DATA ·w2_plus_w6<>+20(SB)/4, $3784
DATA ·w2_plus_w6<>+24(SB)/4, $3784
DATA ·w2_plus_w6<>+28(SB)/4, $3784
GLOBL ·w2_plus_w6<>(SB), RODATA, $32

DATA ·w2_minus_w6<>(SB)/4, $1568
DATA ·w2_minus_w6<>+4(SB)/4, $1568
DATA ·w2_minus_w6<>+8(SB)/4, $1568
DATA ·w2_minus_w6<>+12(SB)/4, $1568
DATA ·w2_minus_w6<>+16(SB)/4, $1568
DATA ·w2_minus_w6<>+20(SB)/4, $1568
DATA ·w2_minus_w6<>+24(SB)/4, $1568
DATA ·w2_minus_w6<>+28(SB)/4, $1568
GLOBL ·w2_minus_w6<>(SB), RODATA, $32

DATA ·w3_plus_w5<>(SB)/4, $4017
DATA ·w3_plus_w5<>+4(SB)/4, $4017
DATA ·w3_plus_w5<>+8(SB)/4, $4017
DATA ·w3_plus_w5<>+12(SB)/4, $4017
DATA ·w3_plus_w5<>+16(SB)/4, $4017
DATA ·w3_plus_w5<>+20(SB)/4, $4017
DATA ·w3_plus_w5<>+24(SB)/4, $4017
DATA ·w3_plus_w5<>+28(SB)/4, $4017
GLOBL ·w3_plus_w5<>(SB), RODATA, $32

DATA ·w3_minus_w5<>(SB)/4, $799
DATA ·w3_minus_w5<>+4(SB)/4, $799
DATA ·w3_minus_w5<>+8(SB)/4, $799
DATA ·w3_minus_w5<>+12(SB)/4, $799
DATA ·w3_minus_w5<>+16(SB)/4, $799
DATA ·w3_minus_w5<>+20(SB)/4, $799
DATA ·w3_minus_w5<>+24(SB)/4, $799
DATA ·w3_minus_w5<>+28(SB)/4, $799
GLOBL ·w3_minus_w5<>(SB), RODATA, $32

DATA ·r2<>(SB)/4, $181
DATA ·r2<>+4(SB)/4, $181
DATA ·r2<>+8(SB)/4, $181
DATA ·r2<>+12(SB)/4, $181
DATA ·r2<>+16(SB)/4, $181
DATA ·r2<>+20(SB)/4, $181
DATA ·r2<>+24(SB)/4, $181
DATA ·r2<>+28(SB)/4, $181
GLOBL ·r2<>(SB), RODATA, $32

// Common Constants
DATA ·const_2<>(SB)/4, $2
DATA ·const_2<>+4(SB)/4, $2
DATA ·const_2<>+8(SB)/4, $2
DATA ·const_2<>+12(SB)/4, $2
DATA ·const_2<>+16(SB)/4, $2
DATA ·const_2<>+20(SB)/4, $2
DATA ·const_2<>+24(SB)/4, $2
DATA ·const_2<>+28(SB)/4, $2
GLOBL ·const_2<>(SB), RODATA, $32

DATA ·const_4<>(SB)/4, $4
DATA ·const_4<>+4(SB)/4, $4
DATA ·const_4<>+8(SB)/4, $4
DATA ·const_4<>+12(SB)/4, $4
DATA ·const_4<>+16(SB)/4, $4
DATA ·const_4<>+20(SB)/4, $4
DATA ·const_4<>+24(SB)/4, $4
DATA ·const_4<>+28(SB)/4, $4
GLOBL ·const_4<>(SB), RODATA, $32

DATA ·const_128<>(SB)/4, $128
DATA ·const_128<>+4(SB)/4, $128
DATA ·const_128<>+8(SB)/4, $128
DATA ·const_128<>+12(SB)/4, $128
DATA ·const_128<>+16(SB)/4, $128
DATA ·const_128<>+20(SB)/4, $128
DATA ·const_128<>+24(SB)/4, $128
DATA ·const_128<>+28(SB)/4, $128
GLOBL ·const_128<>(SB), RODATA, $32

DATA ·const_1024<>(SB)/4, $1024
DATA ·const_1024<>+4(SB)/4, $1024
DATA ·const_1024<>+8(SB)/4, $1024
DATA ·const_1024<>+12(SB)/4, $1024
DATA ·const_1024<>+16(SB)/4, $1024
DATA ·const_1024<>+20(SB)/4, $1024
DATA ·const_1024<>+24(SB)/4, $1024
DATA ·const_1024<>+28(SB)/4, $1024
GLOBL ·const_1024<>(SB), RODATA, $32

DATA ·const_8192<>(SB)/4, $8192
DATA ·const_8192<>+4(SB)/4, $8192
DATA ·const_8192<>+8(SB)/4, $8192
DATA ·const_8192<>+12(SB)/4, $8192
DATA ·const_8192<>+16(SB)/4, $8192
DATA ·const_8192<>+20(SB)/4, $8192
DATA ·const_8192<>+24(SB)/4, $8192
DATA ·const_8192<>+28(SB)/4, $8192
GLOBL ·const_8192<>(SB), RODATA, $32

DATA ·const_16384<>(SB)/4, $16384
DATA ·const_16384<>+4(SB)/4, $16384
DATA ·const_16384<>+8(SB)/4, $16384
DATA ·const_16384<>+12(SB)/4, $16384
DATA ·const_16384<>+16(SB)/4, $16384
DATA ·const_16384<>+20(SB)/4, $16384
DATA ·const_16384<>+24(SB)/4, $16384
DATA ·const_16384<>+28(SB)/4, $16384
GLOBL ·const_16384<>(SB), RODATA, $32

DATA ·zero<>(SB)/4, $0
DATA ·zero<>+4(SB)/4, $0
DATA ·zero<>+8(SB)/4, $0
DATA ·zero<>+12(SB)/4, $0
DATA ·zero<>+16(SB)/4, $0
DATA ·zero<>+20(SB)/4, $0
DATA ·zero<>+24(SB)/4, $0
DATA ·zero<>+28(SB)/4, $0
GLOBL ·zero<>(SB), RODATA, $32

// Transpose 8x8 block in memory at DI
TEXT ·transpose8x8AVX2(SB), NOSPLIT, $0
	VMOVDQU 0(DI), Y0   // Row 0
	VMOVDQU 32(DI), Y1  // Row 1
	VMOVDQU 64(DI), Y2  // Row 2
	VMOVDQU 96(DI), Y3  // Row 3
	VMOVDQU 128(DI), Y4 // Row 4
	VMOVDQU 160(DI), Y5 // Row 5
	VMOVDQU 192(DI), Y6 // Row 6
	VMOVDQU 224(DI), Y7 // Row 7

	VPUNPCKLDQ Y1, Y0, Y8
	VPUNPCKHDQ Y1, Y0, Y9
	VPUNPCKLDQ Y3, Y2, Y10
	VPUNPCKHDQ Y3, Y2, Y11
	VPUNPCKLDQ Y5, Y4, Y12
	VPUNPCKHDQ Y5, Y4, Y13
	VPUNPCKLDQ Y7, Y6, Y14
	VPUNPCKHDQ Y7, Y6, Y15

	VPUNPCKLQDQ Y10, Y8, Y0
	VPUNPCKHQDQ Y10, Y8, Y1
	VPUNPCKLQDQ Y11, Y9, Y2
	VPUNPCKHQDQ Y11, Y9, Y3
	VPUNPCKLQDQ Y14, Y12, Y4
	VPUNPCKHQDQ Y14, Y12, Y5
	VPUNPCKLQDQ Y15, Y13, Y6
	VPUNPCKHQDQ Y15, Y13, Y7

	VPERM2I128 $0x20, Y4, Y0, Y8
	VPERM2I128 $0x20, Y5, Y1, Y9
	VPERM2I128 $0x20, Y6, Y2, Y10
	VPERM2I128 $0x20, Y7, Y3, Y11
	VPERM2I128 $0x31, Y4, Y0, Y12
	VPERM2I128 $0x31, Y5, Y1, Y13
	VPERM2I128 $0x31, Y6, Y2, Y14
	VPERM2I128 $0x31, Y7, Y3, Y15

	VMOVDQU Y8, 0(DI)
	VMOVDQU Y9, 32(DI)
	VMOVDQU Y10, 64(DI)
	VMOVDQU Y11, 96(DI)
	VMOVDQU Y12, 128(DI)
	VMOVDQU Y13, 160(DI)
	VMOVDQU Y14, 192(DI)
	VMOVDQU Y15, 224(DI)
	RET

// 1D FDCT core for rows (input in Y0-Y7, output in Y0-Y7)
TEXT ·fdctRowCoreAVX2(SB), NOSPLIT, $0
	// Stage 1: Compute tmp0 to tmp7
	VPADDD Y0, Y7, Y8  // tmp0 = x0 + x7
	VPSUBD Y7, Y0, Y9  // tmp7 = x0 - x7
	VPADDD Y1, Y6, Y10 // tmp1 = x1 + x6
	VPSUBD Y6, Y1, Y11 // tmp6 = x1 - x6
	VPADDD Y2, Y5, Y12 // tmp2 = x2 + x5
	VPSUBD Y5, Y2, Y13 // tmp5 = x2 - x5
	VPADDD Y3, Y4, Y14 // tmp3 = x3 + x4
	VPSUBD Y4, Y3, Y15 // tmp4 = x3 - x4

	// Stage 2: Compute tmp10 to tmp13
	VPADDD Y8, Y14, Y0  // tmp10 = tmp0 + tmp3
	VPADDD Y10, Y12, Y1 // tmp11 = tmp1 + tmp2
	VPSUBD Y14, Y8, Y2  // tmp12 = tmp0 - tmp3
	VPSUBD Y12, Y10, Y3 // tmp13 = tmp1 - tmp2

	// Stage 3: Compute even coefficients s[0], s[4]
	// First s[4] = (tmp10 - tmp11) << pass1Bits
	VPSUBD Y1, Y0, Y4 // tmp10 - tmp11
	VPSLLD $2, Y4, Y4 // s[4]

	// Then s[0] = (tmp10 + tmp11 - 8*centerJSample) << pass1Bits
	VPADDD Y0, Y1, Y8                // tmp10 + tmp11
	VPSUBD ·const_1024<>(SB), Y8, Y8
	VPSLLD $2, Y8, Y0                // s[0]

	// Stage 4: Compute s[2] and s[6]
	VPADDD  Y2, Y3, Y5                     // tmp12 + tmp13
	VPMULLD ·fix_0_541196100<>(SB), Y5, Y5 // z1 = (tmp12 + tmp13) * fix_0_541196100
	VPADDD  ·const_1024<>(SB), Y5, Y5      // z1 + (1 << 10)
	VPMULLD ·fix_0_765366865<>(SB), Y2, Y6 // tmp12 * fix_0_765366865
	VPADDD  Y5, Y6, Y6
	VPSRAD  $11, Y6, Y2                    // s[2] = (z1 + tmp12 * fix_0_765366865) >> 11
	VPMULLD ·fix_1_847759065<>(SB), Y3, Y7 // tmp13 * fix_1_847759065
	VPSUBD  Y7, Y5, Y7
	VPSRAD  $11, Y7, Y6                    // s[6] = (z1 - tmp13 * fix_1_847759065) >> 11

	// Stage 5: Prepare for odd coefficients
	VMOVDQA Y9, Y1  // tmp0
	VMOVDQA Y11, Y3 // tmp1
	VMOVDQA Y13, Y5 // tmp2
	VMOVDQA Y15, Y7 // tmp3

	VPADDD Y1, Y7, Y8  // tmp10 = tmp0 + tmp3
	VPADDD Y3, Y5, Y10 // tmp11 = tmp1 + tmp2
	VPADDD Y1, Y5, Y12 // tmp12 = tmp0 + tmp2
	VPADDD Y3, Y7, Y14 // tmp13 = tmp1 + tmp3

	// Stage 6: Compute z1 for odd coefficients
	VPADDD  Y12, Y14, Y9
	VPMULLD ·fix_1_175875602<>(SB), Y9, Y9
	VPADDD  ·const_1024<>(SB), Y9, Y9      // z1 + (1 << 10)

	// Stage 7: Apply multipliers
	VPMULLD ·fix_1_501321110<>(SB), Y1, Y1
	VPMULLD ·fix_3_072711026<>(SB), Y3, Y3
	VPMULLD ·fix_2_053119869<>(SB), Y5, Y5
	VPMULLD ·fix_0_298631336<>(SB), Y7, Y7
	VPMULLD ·fix_neg_0_899976223<>(SB), Y8, Y8
	VPMULLD ·fix_neg_2_562915447<>(SB), Y10, Y10
	VPMULLD ·fix_neg_0_390180644<>(SB), Y12, Y12
	VPMULLD ·fix_neg_1_961570560<>(SB), Y14, Y14

	// Stage 8: Combine terms
	VPADDD Y9, Y12, Y12
	VPADDD Y9, Y14, Y14

	VPADDD Y1, Y8, Y1
	VPADDD Y1, Y12, Y1
	VPSRAD $11, Y1, Y1 // s[1]

	VPADDD Y3, Y10, Y3
	VPADDD Y3, Y14, Y3
	VPSRAD $11, Y3, Y3 // s[3]

	VPADDD Y5, Y10, Y5
	VPADDD Y5, Y12, Y5
	VPSRAD $11, Y5, Y5 // s[5]

	VPADDD Y7, Y8, Y7
	VPADDD Y7, Y14, Y7
	VPSRAD $11, Y7, Y7 // s[7]

	// Output in Y0-Y7: s[0], s[1], s[2], s[3], s[4], s[5], s[6], s[7]
	RET

// 1D FDCT core for columns (input in Y0-Y7, output in Y0-Y7)
TEXT ·fdctColCoreAVX2(SB), NOSPLIT, $0
	// Stage 1: Compute tmp0 to tmp7
	VPADDD Y0, Y7, Y8  // tmp0 = x0 + x7
	VPSUBD Y7, Y0, Y9  // tmp7 = x0 - x7
	VPADDD Y1, Y6, Y10 // tmp1 = x1 + x6
	VPSUBD Y6, Y1, Y11 // tmp6 = x1 - x6
	VPADDD Y2, Y5, Y12 // tmp2 = x2 + x5
	VPSUBD Y5, Y2, Y13 // tmp5 = x2 - x5
	VPADDD Y3, Y4, Y14 // tmp3 = x3 + x4
	VPSUBD Y4, Y3, Y15 // tmp4 = x3 - x4

	// Stage 2: Compute tmp10 to tmp13
	VPADDD Y8, Y14, Y0            // tmp10 = tmp0 + tmp3
	VPADDD ·const_2<>(SB), Y0, Y0 // tmp10 += 2 (rounding)
	VPADDD Y10, Y12, Y1           // tmp11 = tmp1 + tmp2
	VPSUBD Y14, Y8, Y2            // tmp12 = tmp0 - tmp3
	VPSUBD Y12, Y10, Y3           // tmp13 = tmp1 - tmp2

	// Stage 3: Compute even coefficients s[0], s[4]
	// First s[4] = (tmp10 - tmp11) >> pass1Bits
	VPSUBD Y1, Y0, Y4 // tmp10 - tmp11
	VPSRAD $2, Y4, Y4 // s[4]

	// Then s[0] = (tmp10 + tmp11) >> pass1Bits
	VPADDD Y0, Y1, Y8 // tmp10 + tmp11
	VPSRAD $2, Y8, Y0 // s[0]

	// Stage 4: Compute s[2] and s[6]
	VPADDD  Y2, Y3, Y5                     // tmp12 + tmp13
	VPMULLD ·fix_0_541196100<>(SB), Y5, Y5
	VPADDD  ·const_16384<>(SB), Y5, Y5     // z1 + (1 << 14)
	VPMULLD ·fix_0_765366865<>(SB), Y2, Y6
	VPADDD  Y5, Y6, Y6
	VPSRAD  $15, Y6, Y2                    // s[2] = (z1 + tmp12 * fix_0_765366865) >> 15
	VPMULLD ·fix_1_847759065<>(SB), Y3, Y7
	VPSUBD  Y7, Y5, Y7
	VPSRAD  $15, Y7, Y6                    // s[6] = (z1 - tmp13 * fix_1_847759065) >> 15

	// Stage 5: Prepare for odd coefficients
	VMOVDQA Y9, Y1  // tmp0
	VMOVDQA Y11, Y3 // tmp1
	VMOVDQA Y13, Y5 // tmp2
	VMOVDQA Y15, Y7 // tmp3

	VPADDD Y1, Y7, Y8  // tmp10 = tmp0 + tmp3
	VPADDD Y3, Y5, Y10 // tmp11 = tmp1 + tmp2
	VPADDD Y1, Y5, Y12 // tmp12 = tmp0 + tmp2
	VPADDD Y3, Y7, Y14 // tmp13 = tmp1 + tmp3

	// Stage 6: Compute z1 for odd coefficients
	VPADDD  Y12, Y14, Y9
	VPMULLD ·fix_1_175875602<>(SB), Y9, Y9
	VPADDD  ·const_16384<>(SB), Y9, Y9     // z1 + (1 << 14)

	// Stage 7: Apply multipliers
	VPMULLD ·fix_1_501321110<>(SB), Y1, Y1
	VPMULLD ·fix_3_072711026<>(SB), Y3, Y3
	VPMULLD ·fix_2_053119869<>(SB), Y5, Y5
	VPMULLD ·fix_0_298631336<>(SB), Y7, Y7
	VPMULLD ·fix_neg_0_899976223<>(SB), Y8, Y8
	VPMULLD ·fix_neg_2_562915447<>(SB), Y10, Y10
	VPMULLD ·fix_neg_0_390180644<>(SB), Y12, Y12
	VPMULLD ·fix_neg_1_961570560<>(SB), Y14, Y14

	// Stage 8: Combine terms
	VPADDD Y9, Y12, Y12
	VPADDD Y9, Y14, Y14

	VPADDD Y1, Y8, Y1
	VPADDD Y1, Y12, Y1
	VPSRAD $15, Y1, Y1 // s[1]

	VPADDD Y3, Y10, Y3
	VPADDD Y3, Y14, Y3
	VPSRAD $15, Y3, Y3 // s[3]

	VPADDD Y5, Y10, Y5
	VPADDD Y5, Y12, Y5
	VPSRAD $15, Y5, Y5 // s[5]

	VPADDD Y7, Y8, Y7
	VPADDD Y7, Y14, Y7
	VPSRAD $15, Y7, Y7 // s[7]

	// Output in Y0-Y7: s[0], s[1], s[2], s[3], s[4], s[5], s[6], s[7]
	RET

// Forward DCT implementation
TEXT ·fdctAVX2(SB), NOSPLIT, $0-8
	MOVQ  block+0(FP), DI
	TESTQ DI, DI
	JE    nilPointer

	// Load block into Y0-Y7
	VMOVDQU 0(DI), Y0
	VMOVDQU 32(DI), Y1
	VMOVDQU 64(DI), Y2
	VMOVDQU 96(DI), Y3
	VMOVDQU 128(DI), Y4
	VMOVDQU 160(DI), Y5
	VMOVDQU 192(DI), Y6
	VMOVDQU 224(DI), Y7

	// Process rows (pass 1)
	CALL ·fdctRowCoreAVX2(SB)

	// Store back to memory
	VMOVDQU Y0, 0(DI)
	VMOVDQU Y1, 32(DI)
	VMOVDQU Y2, 64(DI)
	VMOVDQU Y3, 96(DI)
	VMOVDQU Y4, 128(DI)
	VMOVDQU Y5, 160(DI)
	VMOVDQU Y6, 192(DI)
	VMOVDQU Y7, 224(DI)

	// Transpose
	CALL ·transpose8x8AVX2(SB)

	// Load transposed block
	VMOVDQU 0(DI), Y0
	VMOVDQU 32(DI), Y1
	VMOVDQU 64(DI), Y2
	VMOVDQU 96(DI), Y3
	VMOVDQU 128(DI), Y4
	VMOVDQU 160(DI), Y5
	VMOVDQU 192(DI), Y6
	VMOVDQU 224(DI), Y7

	// Process columns (pass 2)
	CALL ·fdctColCoreAVX2(SB)

	// Store back to memory
	VMOVDQU Y0, 0(DI)
	VMOVDQU Y1, 32(DI)
	VMOVDQU Y2, 64(DI)
	VMOVDQU Y3, 96(DI)
	VMOVDQU Y4, 128(DI)
	VMOVDQU Y5, 160(DI)
	VMOVDQU Y6, 192(DI)
	VMOVDQU Y7, 224(DI)

	// Transpose back
	CALL ·transpose8x8AVX2(SB)

	VZEROUPPER
	RET

nilPointer:
	VZEROUPPER
	RET

// 1D IDCT core for rows (input in Y0-Y7, output in Y0-Y7)
TEXT ·idctRowCoreAVX2(SB), NOSPLIT, $0
	// Check if all AC coefficients are zero
	VMOVDQA   ·zero<>(SB), Y15
	VPCMPEQD  Y1, Y15, Y8
	VPCMPEQD  Y2, Y15, Y9
	VPCMPEQD  Y3, Y15, Y10
	VPCMPEQD  Y4, Y15, Y11
	VPCMPEQD  Y5, Y15, Y12
	VPCMPEQD  Y6, Y15, Y13
	VPCMPEQD  Y7, Y15, Y14
	VPAND     Y8, Y9, Y8
	VPAND     Y8, Y10, Y8
	VPAND     Y8, Y11, Y8
	VPAND     Y8, Y12, Y8
	VPAND     Y8, Y13, Y8
	VPAND     Y8, Y14, Y8
	VPMOVMSKB Y8, AX
	CMPQ      AX, $0xFFFFFFFF
	JNE       full_idct_row

	// Fast path: DC only
	VPSLLD  $3, Y0, Y0
	VMOVDQA Y0, Y1
	VMOVDQA Y0, Y2
	VMOVDQA Y0, Y3
	VMOVDQA Y0, Y4
	VMOVDQA Y0, Y5
	VMOVDQA Y0, Y6
	VMOVDQA Y0, Y7
	RET

full_idct_row:
	// Prescale
	VPSLLD  $11, Y0, Y8              // x0 = s[0] << 11
	VPADDD  ·const_128<>(SB), Y8, Y8
	VPSLLD  $11, Y4, Y9              // x1 = s[4] << 11
	VMOVDQA Y6, Y10                  // x2 = s[6]
	VMOVDQA Y2, Y11                  // x3 = s[2]
	VMOVDQA Y1, Y12                  // x4 = s[1]
	VMOVDQA Y7, Y13                  // x5 = s[7]
	VMOVDQA Y5, Y14                  // x6 = s[5]
	VMOVDQA Y3, Y15                  // x7 = s[3]

	// Stage 1
	VPADDD  Y12, Y13, Y0
	VPMULLD ·w7<>(SB), Y0, Y0
	VPMULLD ·w1_minus_w7<>(SB), Y12, Y1
	VPADDD  Y0, Y1, Y12                 // x4
	VPMULLD ·w1_plus_w7<>(SB), Y13, Y1
	VPSUBD  Y1, Y0, Y13                 // x5

	VPADDD  Y14, Y15, Y0
	VPMULLD ·w3<>(SB), Y0, Y0
	VPMULLD ·w3_minus_w5<>(SB), Y14, Y1
	VPSUBD  Y1, Y0, Y14                 // x6
	VPMULLD ·w3_plus_w5<>(SB), Y15, Y1
	VPSUBD  Y1, Y0, Y15                 // x7

	// Stage 2
	VPADDD  Y8, Y9, Y0                  // x8 = x0 + x1
	VPSUBD  Y9, Y8, Y8                  // x0 = x0 - x1
	VPADDD  Y11, Y10, Y1
	VPMULLD ·w6<>(SB), Y1, Y1
	VPMULLD ·w2_plus_w6<>(SB), Y10, Y2
	VPSUBD  Y2, Y1, Y10                 // x2
	VPMULLD ·w2_minus_w6<>(SB), Y11, Y2
	VPADDD  Y1, Y2, Y11                 // x3
	VPADDD  Y12, Y14, Y1                // x1 = x4 + x6
	VPSUBD  Y14, Y12, Y2                // x4 = x4 - x6
	VPADDD  Y13, Y15, Y3                // x6 = x5 + x7
	VPSUBD  Y15, Y13, Y4                // x5 = x5 - x7

	// Stage 3
	VPADDD Y0, Y11, Y5 // x7 = x8 + x3
	VPSUBD Y11, Y0, Y6 // x8 = x8 - x3
	VPADDD Y8, Y10, Y7 // x3 = x0 + x2
	VPSUBD Y10, Y8, Y8 // x0 = x0 - x2

	VPADDD  Y2, Y4, Y9
	VPMULLD ·r2<>(SB), Y9, Y9
	VPADDD  ·const_128<>(SB), Y9, Y9
	VPSRAD  $8, Y9, Y10              // x2 = (r2 * (x4 + x5) + 128) >> 8
	VPSUBD  Y4, Y2, Y9
	VPMULLD ·r2<>(SB), Y9, Y9
	VPADDD  ·const_128<>(SB), Y9, Y9
	VPSRAD  $8, Y9, Y11              // x4 = (r2 * (x4 - x5) + 128) >> 8

	// Stage 4
	// Compute all unshifted adds and subs first
	VPADDD Y5, Y1, Y12  // temp_s0 = x7 + x1
	VPADDD Y7, Y10, Y13 // temp_s1 = x3 + x2
	VPADDD Y8, Y11, Y14 // temp_s2 = x0 + x4
	VPADDD Y6, Y3, Y15  // temp_s3 = x8 + x6
	VPSUBD Y3, Y6, Y0   // temp_s4 = x8 - x6
	VPSUBD Y11, Y8, Y2  // temp_s5 = x0 - x4
	VPSUBD Y10, Y7, Y4  // temp_s6 = x3 - x2
	VPSUBD Y1, Y5, Y9   // temp_s7 = x7 - x1

	// Now shift in order to avoid overwrites
	VPSRAD $8, Y4, Y6  // s[6] = temp_s6 >> 8  (shift s6 first to free Y4 if needed, but not)
	VPSRAD $8, Y0, Y4  // s[4] = temp_s4 >> 8
	VPSRAD $8, Y2, Y5  // s[5] = temp_s5 >> 8
	VPSRAD $8, Y9, Y7  // s[7] = temp_s7 >> 8
	VPSRAD $8, Y12, Y0 // s[0] = temp_s0 >> 8
	VPSRAD $8, Y13, Y1 // s[1] = temp_s1 >> 8
	VPSRAD $8, Y14, Y2 // s[2] = temp_s2 >> 8
	VPSRAD $8, Y15, Y3 // s[3] = temp_s3 >> 8

	RET

// 1D IDCT core for columns (input in Y0-Y7, output in Y0-Y7)
TEXT ·idctColCoreAVX2(SB), NOSPLIT, $0
	// Prescale
	VPSLLD  $8, Y0, Y8                // y0 = (s[0] << 8) + 8192
	VPADDD  ·const_8192<>(SB), Y8, Y8
	VPSLLD  $8, Y4, Y9                // y1 = s[4] << 8
	VMOVDQA Y6, Y10                   // y2 = s[6]
	VMOVDQA Y2, Y11                   // y3 = s[2]
	VMOVDQA Y1, Y12                   // y4 = s[1]
	VMOVDQA Y7, Y13                   // y5 = s[7]
	VMOVDQA Y5, Y14                   // y6 = s[5]
	VMOVDQA Y3, Y15                   // y7 = s[3]

	// Stage 1
	VPADDD  Y12, Y13, Y0
	VPMULLD ·w7<>(SB), Y0, Y0
	VPADDD  ·const_4<>(SB), Y0, Y0
	VPMULLD ·w1_minus_w7<>(SB), Y12, Y1
	VPADDD  Y1, Y0, Y1
	VPSRAD  $3, Y1, Y12                 // y4
	VPMULLD ·w1_plus_w7<>(SB), Y13, Y1
	VPSUBD  Y1, Y0, Y1
	VPSRAD  $3, Y1, Y13                 // y5

	VPADDD  Y14, Y15, Y0
	VPMULLD ·w3<>(SB), Y0, Y0
	VPADDD  ·const_4<>(SB), Y0, Y0
	VPMULLD ·w3_minus_w5<>(SB), Y14, Y1
	VPSUBD  Y1, Y0, Y1
	VPSRAD  $3, Y1, Y14                 // y6
	VPMULLD ·w3_plus_w5<>(SB), Y15, Y1
	VPSUBD  Y1, Y0, Y1
	VPSRAD  $3, Y1, Y15                 // y7

	// Stage 2
	VPADDD  Y8, Y9, Y0                  // y8 = y0 + y1
	VPSUBD  Y9, Y8, Y8                  // y0 = y0 - y1
	VPADDD  Y11, Y10, Y1
	VPMULLD ·w6<>(SB), Y1, Y1
	VPADDD  ·const_4<>(SB), Y1, Y1
	VPMULLD ·w2_plus_w6<>(SB), Y10, Y2
	VPSUBD  Y2, Y1, Y2
	VPSRAD  $3, Y2, Y10                 // y2
	VPMULLD ·w2_minus_w6<>(SB), Y11, Y2
	VPADDD  Y1, Y2, Y2
	VPSRAD  $3, Y2, Y11                 // y3
	VPADDD  Y12, Y14, Y1                // y1 = y4 + y6
	VPSUBD  Y14, Y12, Y2                // y4 = y4 - y6
	VPADDD  Y13, Y15, Y3                // y6 = y5 + y7
	VPSUBD  Y15, Y13, Y4                // y5 = y5 - y7

	// Stage 3
	VPADDD Y0, Y11, Y5 // y7 = y8 + y3
	VPSUBD Y11, Y0, Y6 // y8 = y8 - y3
	VPADDD Y8, Y10, Y7 // y3 = y0 + y2
	VPSUBD Y10, Y8, Y8 // y0 = y0 - y2

	VPADDD  Y2, Y4, Y9
	VPMULLD ·r2<>(SB), Y9, Y9
	VPADDD  ·const_128<>(SB), Y9, Y9
	VPSRAD  $8, Y9, Y10              // y2 = (r2 * (y4 + y5) + 128) >> 8
	VPSUBD  Y4, Y2, Y9
	VPMULLD ·r2<>(SB), Y9, Y9
	VPADDD  ·const_128<>(SB), Y9, Y9
	VPSRAD  $8, Y9, Y11              // y4 = (r2 * (y4 - y5) + 128) >> 8

	// Stage 4
	// Compute all unshifted adds and subs first
	VPADDD Y5, Y1, Y12  // temp_s0 = y7 + y1
	VPADDD Y7, Y10, Y13 // temp_s1 = y3 + y2
	VPADDD Y8, Y11, Y14 // temp_s2 = y0 + y4
	VPADDD Y6, Y3, Y15  // temp_s3 = y8 + y6
	VPSUBD Y3, Y6, Y0   // temp_s4 = y8 - y6
	VPSUBD Y11, Y8, Y2  // temp_s5 = y0 - y4
	VPSUBD Y10, Y7, Y4  // temp_s6 = y3 - y2
	VPSUBD Y1, Y5, Y9   // temp_s7 = y7 - y1

	// Now shift in order to avoid overwrites
	VPSRAD $14, Y4, Y6  // s[6] = temp_s6 >> 14
	VPSRAD $14, Y0, Y4  // s[4] = temp_s4 >> 14
	VPSRAD $14, Y2, Y5  // s[5] = temp_s5 >> 14
	VPSRAD $14, Y9, Y7  // s[7] = temp_s7 >> 14
	VPSRAD $14, Y12, Y0 // s[0] = temp_s0 >> 14
	VPSRAD $14, Y13, Y1 // s[1] = temp_s1 >> 14
	VPSRAD $14, Y14, Y2 // s[2] = temp_s2 >> 14
	VPSRAD $14, Y15, Y3 // s[3] = temp_s3 >> 14

	RET

// Inverse DCT implementation
TEXT ·idctAVX2(SB), NOSPLIT, $0-8
	MOVQ  block+0(FP), DI
	TESTQ DI, DI
	JE    nilPointer

	// Load block into Y0-Y7
	VMOVDQU 0(DI), Y0
	VMOVDQU 32(DI), Y1
	VMOVDQU 64(DI), Y2
	VMOVDQU 96(DI), Y3
	VMOVDQU 128(DI), Y4
	VMOVDQU 160(DI), Y5
	VMOVDQU 192(DI), Y6
	VMOVDQU 224(DI), Y7

	// Process rows
	CALL ·idctRowCoreAVX2(SB)

	// Store back to memory
	VMOVDQU Y0, 0(DI)
	VMOVDQU Y1, 32(DI)
	VMOVDQU Y2, 64(DI)
	VMOVDQU Y3, 96(DI)
	VMOVDQU Y4, 128(DI)
	VMOVDQU Y5, 160(DI)
	VMOVDQU Y6, 192(DI)
	VMOVDQU Y7, 224(DI)

	// Transpose
	CALL ·transpose8x8AVX2(SB)

	// Load transposed block
	VMOVDQU 0(DI), Y0
	VMOVDQU 32(DI), Y1
	VMOVDQU 64(DI), Y2
	VMOVDQU 96(DI), Y3
	VMOVDQU 128(DI), Y4
	VMOVDQU 160(DI), Y5
	VMOVDQU 192(DI), Y6
	VMOVDQU 224(DI), Y7

	// Process columns
	CALL ·idctColCoreAVX2(SB)

	// Store back to memory
	VMOVDQU Y0, 0(DI)
	VMOVDQU Y1, 32(DI)
	VMOVDQU Y2, 64(DI)
	VMOVDQU Y3, 96(DI)
	VMOVDQU Y4, 128(DI)
	VMOVDQU Y5, 160(DI)
	VMOVDQU Y6, 192(DI)
	VMOVDQU Y7, 224(DI)

	// Transpose back
	CALL ·transpose8x8AVX2(SB)

	VZEROUPPER
	RET

nilPointer:
	VZEROUPPER
	RET

