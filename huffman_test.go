package jpeg

import (
	"bytes"
	"testing"
)

type huffTest struct {
	tcTh    byte
	counts  [16]byte
	symbols []byte
	samples []sample
}

type sample struct {
	bitStr    string
	expected  []uint8
	remaining int32
	wantErr   bool
}

var huffTests = []huffTest{
	{
		tcTh:    0,
		counts:  [16]byte{1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		symbols: []byte{0, 1, 2},
		samples: []sample{
			{"00000000", []uint8{0}, 7, false},
			{"10000000", []uint8{1}, 5, false},
			{"10100000", []uint8{2}, 5, false},
			{"10000000", []uint8{1, 0}, 4, false},
			{"10001010", []uint8{1, 0, 2}, 1, false},
			{"11", nil, 0, true}, // incomplete
			{"10000000000000000000", []uint8{1}, 17, false},
			{"10100000000000000000", []uint8{2}, 17, false},
		},
	},
	{
		tcTh:    0,
		counts:  [16]byte{1, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
		symbols: []byte{0, 1, 2, 3},
		samples: []sample{
			{"1100000000", []uint8{3}, 0, false},
			{"1100000001", nil, 0, true},
			{"11000", nil, 0, true},
			{"110000000000000000000000", []uint8{3}, 14, false},
		},
	},
	{
		tcTh:    0,
		counts:  [16]byte{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
		symbols: []byte{1, 42},
		samples: []sample{
			{"0", []uint8{1}, 0, false},
			{"1000000000000", []uint8{42}, 0, false},
			{"10000000000000000000000000000000", []uint8{42}, 19, false},
		},
	},
}

func TestDecodeHuffman(t *testing.T) {
	for ti, tt := range huffTests {
		data := []byte{tt.tcTh}
		data = append(data, tt.counts[:]...)
		data = append(data, tt.symbols...)

		d := &decoder{r: bytes.NewReader(data)}
		if err := d.processDHT(len(data)); err != nil {
			t.Errorf("%d: processDHT: %v", ti, err)
			continue
		}

		tc := int(tt.tcTh >> 4)
		th := int(tt.tcTh & 0x0f)
		h := &d.huff[tc][th]

		for si, sample := range tt.samples {
			dd := &decoder{
				r: bytes.NewReader([]byte{}),
			}

			a, n := parseBitStr(sample.bitStr)
			dd.bits.a = a
			dd.bits.n = n

			if n > 0 {
				dd.bits.m = 1 << uint32(n-1)
			} else {
				dd.bits.m = 0
			}

			if sample.wantErr {
				_, err := dd.decodeHuffman(h)
				if err == nil {
					t.Errorf("%d.%d: expected error", ti, si)
				}
				continue
			}

			for j, exp := range sample.expected {
				v, err := dd.decodeHuffman(h)
				if err != nil {
					t.Errorf("%d.%d: at index %d: %v", ti, si, j, err)
				}

				if v != exp {
					t.Errorf("%d.%d: at index %d: got %d, want %d", ti, si, j, v, exp)
				}
			}

			if dd.bits.n != sample.remaining {
				t.Errorf("%d.%d: remaining bits: got %d, want %d", ti, si, dd.bits.n, sample.remaining)
			}
		}
	}
}

func BenchmarkDecodeHuffmanShort(b *testing.B) {
	counts := [16]byte{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	symbols := []byte{0x00}
	data := []byte{0}
	data = append(data, counts[:]...)
	data = append(data, symbols...)

	d := &decoder{r: bytes.NewReader(data)}
	if err := d.processDHT(len(data)); err != nil {
		b.Fatal(err)
	}

	h := &d.huff[0][0]
	d.r = zeroReader{}

	for i := range d.bytes.buf {
		d.bytes.buf[i] = 0
	}

	d.bytes.i = 0
	d.bytes.j = len(d.bytes.buf)
	d.bytes.nUnreadable = 0
	d.bits = bits{}
	b.ResetTimer()

	for i := 0; i < b.N; i++ {
		_, err := d.decodeHuffman(h)
		if err != nil {
			b.Fatal(err)
		}
	}
}

func BenchmarkDecodeHuffmanLong(b *testing.B) {
	counts := [16]byte{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
	symbols := []byte{0x00}
	data := []byte{0}
	data = append(data, counts[:]...)
	data = append(data, symbols...)

	d := &decoder{r: bytes.NewReader(data)}
	if err := d.processDHT(len(data)); err != nil {
		b.Fatal(err)
	}

	h := &d.huff[0][0]
	d.r = zeroReader{}

	for i := range d.bytes.buf {
		d.bytes.buf[i] = 0
	}

	d.bytes.i = 0
	d.bytes.j = len(d.bytes.buf)
	d.bytes.nUnreadable = 0
	d.bits = bits{}
	b.ResetTimer()

	for i := 0; i < b.N; i++ {
		_, err := d.decodeHuffman(h)
		if err != nil {
			b.Fatal(err)
		}
	}
}

func parseBitStr(s string) (uint32, int32) {
	var a uint32
	n := len(s)

	for i := 0; i < n; i++ {
		if s[i] == '1' {
			a |= 1 << uint(n-1-i)
		}
	}

	return a, int32(n)
}

type zeroReader struct{}

func (zeroReader) Read(p []byte) (int, error) {
	for i := range p {
		p[i] = 0
	}

	return len(p), nil
}
