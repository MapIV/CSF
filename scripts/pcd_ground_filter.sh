#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
CSF_BASE_DIR=${SCRIPT_DIR%/*}
SRC_DIR=${CSF_BASE_DIR%/*}
BASE_DIR=${SRC_DIR%/*}
PCD_GROUND_FILTER=${BASE_DIR}"/devel/lib/csf_seg/pcd_ground_filter"

SEPARATE_UPPER_LOWER_GROUND=0
SURFACE_OUTPUT=""

function usage() {
cat <<_EOT_
Usage:
  $0 [-s] [-p] <INPUT_PCD> <CONFIG_FILE>

Description:
  Separate ground and non-ground points from a PCD file.

Options:
  * -s: Output ground surface along with ground and non-ground PCDs.
  * -p: Separate upper and lower ground PCDS. 

_EOT_
    
    exit 1
}

# Parse option
if [ "$OPTIND" = 1 ]; then
    while getopts hsp OPT
    do
        case $OPT in
            h)
            usage ;;
            s)
            SURFACE_OUTPUT="surface" ;;
            p)
            SEPARATE_UPPER_LOWER_GROUND=1 ;;
            \?)
                echo "Undefined option $OPT"
            usage ;;
        esac
    done
else
    echo "No installed getopts-command." 1>&2
    exit 1
fi
shift $(($OPTIND - 1))

PCD_FILE=$1
CONFIG_FILE=$2

$PCD_GROUND_FILTER $PCD_FILE $CONFIG_FILE $SEPARATE_UPPER_LOWER_GROUND $SURFACE_OUTPUT 