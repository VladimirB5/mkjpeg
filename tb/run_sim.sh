#!/bin/bash

set -e # In case of error, stop executing the script
#set -x # Show current command

TOP=JPEG_TB
FILELIST=files.f

SIM=${1:-ghdl}


# Write and execute command
run_cmd()
{
    echo "$*"
    "$@"
}


# Remove leading and trailing whitespace
trim()
{
    local var="$1"

    # Remove leading whitespace
    var="${var#"${var%%[![:space:]]*}"}"

    # Remove trailing whitespace
    var="${var%"${var##*[![:space:]]}"}"

    printf '%s' "$var"
}


# Compile all source files
compile_files()
{
    while IFS='|' read -r file ghdl_cmd nvc_cmd xsim_cmd; do

        # Skip empty lines, whitespace-only lines and comments
        [[ "$file" =~ ^[[:space:]]*$ ||
           "$file" =~ ^[[:space:]]*# ]] && continue

        # Remove whitespace around fields
        file=$(trim "$file")
        ghdl_cmd=$(trim "$ghdl_cmd")
        nvc_cmd=$(trim "$nvc_cmd")
        xsim_cmd=$(trim "$xsim_cmd")

        # Select command according to simulator
        case "$SIM" in
            ghdl)
                cmd="$ghdl_cmd"
                ;;

            nvc)
                cmd="$nvc_cmd"
                ;;

            vivado|xsim)
                cmd="$xsim_cmd"
                ;;
        esac

        # "-" or empty field means:
        # do not compile this file with this simulator
        [[ -z "$cmd" || "$cmd" == "-" ]] && continue

        # Split command into arguments
        read -ra args <<< "$cmd"

        # Execute compiler command followed by source file
        run_cmd "${args[@]}" "$file"

    done < "$FILELIST"
}


run_ghdl()
{
    echo "=== GHDL simulation ==="

    compile_files

    run_cmd ghdl -e --std=08 -fsynopsys "$TOP"
    run_cmd ghdl -r --std=08 -fsynopsys "$TOP"
}


run_nvc()
{
    echo "=== NVC simulation ==="

    compile_files

    run_cmd nvc --std=2008 -e "$TOP"
    run_cmd nvc --std=2008 -r "$TOP"
}


run_xsim()
{
    echo "=== Vivado XSIM simulation ==="

    compile_files

    run_cmd xelab "$TOP" -s "${TOP}_sim" -debug all
    run_cmd xsim "${TOP}_sim" -gui
}


case "$SIM" in

    ghdl)
        run_ghdl
        ;;

    nvc)
        run_nvc
        ;;

    vivado|xsim)
        run_xsim
        ;;

    *)
        echo "Usage: $0 {ghdl|nvc|vivado}"
        exit 1
        ;;

esac
