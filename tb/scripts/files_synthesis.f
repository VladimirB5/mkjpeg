# ============================================================
# MKJPEG source files
# ============================================================

# common
../design/common/JPEG_PKG.vhd
../design/common/RAMZ.VHD
../design/common/FIFO.vhd
../design/common/SingleSM.vhd

#test
vhdl/DCT_TROM.vhd

# buffifo
../design/BufFifo/multiplier.vhd
../design/BufFifo/SUB_RAMZ_LUT.vhd
../design/BufFifo/SUB_RAMZ.VHD
../design/BufFifo/BUF_FIFO.vhd

# fdct
#../design/mdct/FinitePrecRndNrst.v
../design/mdct/FinitePrecRndNrst.vhd
../design/mdct/MDCT_PKG.vhd
../design/mdct/ROMO.VHD
../design/mdct/ROME.VHD
../design/mdct/RAM.VHD
../design/mdct/DBUFCTL.VHD
../design/mdct/DCT1D.vhd
../design/mdct/DCT2D.VHD
../design/mdct/MDCT.VHD
../design/mdct/FDCT.vhd

#test
#../tb/vhdl/DCT_TROM.vhd

# quantizer
#../design/quantizer/ROMQ.vhd
#../design/quantizer/s_divider.vhd
../design/quantizer/ROMR.vhd
../design/quantizer/r_divider.vhd
../design/quantizer/QUANTIZER.vhd
../design/quantizer/QUANT_TOP.VHD

# zigzag
../design/zigzag/ZIGZAG.VHD
../design/zigzag/ZZ_TOP.VHD

# rle
../design/rle/RleDoubleFifo.vhd
../design/rle/RLE.VHD
../design/rle/RLE_TOP.VHD

# huffman
../design/huffman/DoubleFifo.vhd
../design/huffman/DC_ROM.vhd
../design/huffman/AC_ROM.vhd
../design/huffman/DC_CR_ROM.vhd
../design/huffman/AC_CR_ROM.vhd
../design/huffman/Huffman.vhd

# bytestuffer
../design/bytestuffer/ByteStuffer.vhd

# control
../design/control/CtrlSM.vhd

# HostIF
../design/hostif/HostIF.vhd

# IRamIF
../design/iramif/IRAMIF.vhd

# jfifgen
#../design/JFIFGen/HeaderRAM.v
#../design/JFIFGen/HeaderRAM.vhd
../design/JFIFGen/HeaderRamStatic.vhd
../design/JFIFGen/JFIFGen.vhd

# outmux
../design/outmux/OutMux.vhd

# top
../design/top/JpegEnc.vhd
