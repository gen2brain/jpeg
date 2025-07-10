//go:build amd64 && !noasm

package jpeg

const blockSize = 64 // A DCT block is 8x8.

type block [blockSize]int32

//go:noescape
func fdctAVX2(b *block)

//go:noescape
func idctAVX2(b *block)

func fdct(b *block) {
	fdctAVX2(b)
}

func idct(b *block) {
	idctAVX2(b)
}
