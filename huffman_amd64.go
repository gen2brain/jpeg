//go:build amd64 && !noasm

package jpeg

import "errors"

var (
	errUninitializedHuffmanTable = errors.New("uninitialized huffman table")
	errBadHuffmanCode            = errors.New("bad huffman code")
	errNilPointer                = errors.New("nil pointer")
)

// decodeHuffmanAVX2 is implemented in huffman_amd64.s
//
//go:noescape
func decodeHuffmanAVX2(d *decoder, h *huffman) (uint8, int)

// decodeHuffmanSlow is the fallback slow path for when more bits are needed.
func decodeHuffmanSlow(d *decoder, h *huffman) (uint8, error) {
	var code int32
	for i := 0; i < maxCodeLength; i++ {
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

// decodeHuffman overrides the generic implementation with the assembly version
func (d *decoder) decodeHuffman(h *huffman) (uint8, error) {
	if h.nCodes == 0 {
		return 0, errUninitializedHuffmanTable
	}

	if d.bits.n < lutSize {
		if err := d.ensureNBits(lutSize); err != nil {
			if err != errMissingFF00 && err != errShortHuffmanData {
				return 0, err
			}

			if d.bytes.nUnreadable != 0 {
				d.unreadByteStuffedByte()
			}

			return decodeHuffmanSlow(d, h)
		}
	}

	for {
		s, ecode := decodeHuffmanAVX2(d, h)
		if ecode != 7 {
			if ecode == 0 {
				return s, nil
			}
			switch ecode {
			case 1:
				return 0, errNilPointer
			case 2:
				return 0, errUninitializedHuffmanTable
			case 3:
				return 0, errBadHuffmanCode
			default:
				return 0, errors.New("unknown error")
			}
		}

		// Need more bits.
		if err := d.ensureNBits(16); err != nil {
			if err != errMissingFF00 && err != errShortHuffmanData {
				return 0, err
			}

			if d.bytes.nUnreadable != 0 {
				d.unreadByteStuffedByte()
			}

			return decodeHuffmanSlow(d, h)
		}
	}
}

//go:noinline
func ensureNBitsCode(d *decoder, n int32) int {
	err := d.ensureNBits(n)
	if err == nil {
		return 0
	}

	if err == errShortHuffmanData {
		return 4
	}

	if err == errMissingFF00 {
		return 5
	}

	return 6
}

//go:noinline
func ensureNBitsWrapper(d *decoder, n int32) error {
	return d.ensureNBits(n)
}

//go:noinline
func unreadByteStuffedByteWrapper(d *decoder) {
	d.unreadByteStuffedByte()
}
