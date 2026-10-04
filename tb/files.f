# ============================================================
# MKJPEG source files
# ============================================================

# common
../design/common/JPEG_PKG.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/common/RAMZ.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/common/FIFO.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/common/SingleSM.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

#test
vhdl/DCT_TROM.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# buffifo
../design/BufFifo/multiplier.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/BufFifo/SUB_RAMZ_LUT.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/BufFifo/SUB_RAMZ.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/BufFifo/BUF_FIFO.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# fdct
../design/mdct/FinitePrecRndNrst.v | - | - | xvlog
../design/mdct/MDCT_PKG.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/mdct/ROMO.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/mdct/ROME.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/mdct/RAM.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/mdct/DBUFCTL.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/mdct/DCT1D.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/mdct/DCT2D.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/mdct/MDCT.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/mdct/FDCT.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

#test
#../tb/vhdl/DCT_TROM.vhd

# quantizer
#../design/quantizer/ROMQ.vhd
#../design/quantizer/s_divider.vhd
../design/quantizer/ROMR.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/quantizer/r_divider.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/quantizer/QUANTIZER.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/quantizer/QUANT_TOP.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# zigzag
../design/zigzag/ZIGZAG.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/zigzag/ZZ_TOP.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# rle
../design/rle/RleDoubleFifo.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/rle/RLE.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/rle/RLE_TOP.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# huffman
../design/huffman/DoubleFifo.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/huffman/DC_ROM.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/huffman/AC_ROM.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/huffman/DC_CR_ROM.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/huffman/AC_CR_ROM.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
../design/huffman/Huffman.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# bytestuffer
../design/bytestuffer/ByteStuffer.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# control
../design/control/CtrlSM.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# HostIF
../design/hostif/HostIF.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# IRamIF
../design/iramif/IRAMIF.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# jfifgen
../design/JFIFGen/HeaderRAM.v | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvlog
../design/JFIFGen/JFIFGen.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# outmux
../design/outmux/OutMux.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# top
../design/top/JpegEnc.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008

# testbench
vhdl/RAMSIM.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
vhdl/MDCTTB_PKG.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
vhdl/GPL_V2_Image_pkg.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
vhdl/ClkGen.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
vhdl/HostBFM.vhd | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
vhdl/JPEG_TB.VHD | ghdl -a --std=08 -fsynopsys | nvc --std=2008 -a | xvhdl --2008
