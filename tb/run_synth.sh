#!/bin/bash
set -euo pipefail
# -e exit on error
# -u Error on undefined variables
# -o pipefail — Detect errors in pipelines

TOOL="${1:-}"
TOP="JpegEnc"
PART="xc7a200tfbg484-1"

FILELIST="scripts/files_synthesis.f"

mkdir -p build

case "$TOOL" in

    vivado)
        echo "Running Vivado synthesis..."

        vivado -mode batch \
            -source scripts/synth_vivado.tcl \
            -tclargs "$TOP" "$PART" "$FILELIST" \
            -log build/vivado.log \
            -journal build/vivado.jou
        ;;

    yosys)
        echo "Running GHDL + Yosys synthesis..."

        mkdir -p build/ghdl

        mapfile -t SOURCES < <(
            grep -vE '^[[:space:]]*(#|$)' "$FILELIST"
        )

        ghdl -a --std=08 -fsynopsys \
            --workdir=build/ghdl \
            "${SOURCES[@]}"

        ghdl --synth --std=08 -fsynopsys \
            --workdir=build/ghdl \
            --out=verilog "$TOP" > build/jpeg_synth.v

        yosys -l build/yosys.log -p "
            read_verilog build/jpeg_synth.v
            synth_xilinx -family xc7 -top $TOP
            stat
        "
        ;;

    *)
        echo "Usage: $0 {vivado|yosys}"
        exit 1
        ;;
esac
