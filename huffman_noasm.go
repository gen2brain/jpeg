//go:build !amd64 || noasm

// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package jpeg

// decodeHuffman returns the next Huffman-coded value from the bit-stream,
// decoded according to h.
func (d *decoder) decodeHuffman(h *huffman) (uint8, error) {
	if h.nCodes == 0 {
		return 0, FormatError("uninitialized Huffman table")
	}

	if d.bits.n < 8 {
		if err := d.ensureNBits(8); err != nil {
			if err != errMissingFF00 && err != errShortHuffmanData {
				return 0, err
			}
			// There are no more bytes of data in this segment, but we may still
			// be able to read the next symbol out of the previously read bits.
			// First, undo the readByte that the ensureNBits call made.
			if d.bytes.nUnreadable != 0 {
				d.unreadByteStuffedByte()
			}
			goto slowPath
		}
	}
	if v := h.lut[(d.bits.a>>uint32(d.bits.n-lutSize))&0xff]; v != 0 {
		n := (v & 0xff) - 1
		d.bits.n -= int32(n)
		d.bits.m >>= n
		return uint8(v >> 8), nil
	}

slowPath:
	for i, code := 0, int32(0); i < maxCodeLength; i++ {
		if d.bits.n == 0 {
			if err := d.ensureNBits(1); err != nil {
				return 0, err
			}
		}
		if d.bits.a&d.bits.m != 0 {
			code |= 1
		}
		d.bits.n--
		d.bits.m >>= 1
		if code <= h.maxCodes[i] {
			return h.vals[h.valsIndices[i]+code-h.minCodes[i]], nil
		}
		code <<= 1
	}
	return 0, FormatError("bad Huffman code")
}
