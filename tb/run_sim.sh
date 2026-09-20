#!/bin/bash

set -e # in case of error, stop executting the script
#set -x # show current command

TOP=tb_jpeg
FILELIST=files.f

# write and execute command
run_cmd()
{
    echo "$*"
    "$@"
}

run_ghdl()
{
    echo "=== GHDL simulation ==="

    while IFS= read -r file; do
        [[ -z "$file" || "$file" =~ ^[[:space:]]*# ]] && continue
        run_cmd ghdl -a --std=08 -fsynopsys "$file"
    done < "$FILELIST"

    run_cmd ghdl -e --std=08 -fsynopsys "$TOP"
    run_cmd ghdl -r --std=08 -fsynopsys "$TOP"
}


run_nvc()
{
    echo "=== NVC simulation ==="

    while IFS= read -r file; do
        [[ -z "$file" || "$file" =~ ^[[:space:]]*# ]] && continue
        run_cmd nvc --std=2008 -a "$file"
    done < "$FILELIST"

    run_cmd nvc --std=2008 -e "$TOP"
    run_cmd nvc --std=2008 -r "$TOP"
}


run_xsim()
{
    echo "=== Vivado XSIM simulation ==="

    while IFS= read -r file; do
        [[ -z "$file" || "$file" =~ ^[[:space:]]*# ]] && continue
        run_cmd xvhdl --2008 "$file"
    done < "$FILELIST"

    run_cmd xelab "$TOP" -s "${TOP}_sim"
    run_cmd xsim "${TOP}_sim" -runall
}

SIM=${1:-ghdl}


case "$SIM" in

    ghdl)
        echo "=== GHDL ==="
        run_ghdl
        ;;

    nvc)
        echo "=== NVC ==="
        run_nvc
        ;;

    vivado|xsim)
        echo "=== XSIM ==="
        run_xsim
        ;;

    *)
        echo "Usage: $0 {ghdl|nvc|vivado}"
        exit 1
        ;;
esac
