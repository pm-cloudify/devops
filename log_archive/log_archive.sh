#!/bin/bash -
#===============================================================================
#
#          FILE: log_archive.sh
#
#         USAGE: ./log_archive.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Pouya Mohammadi 
#  ORGANIZATION: pm-cloudify
#       CREATED: 07/10/2025 07:21:37 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

echo $#

if [ $# -eq 1 ]; then
    input_dir="${1%/}"
    timestap=$(date --utc  +%Y%m%d_%H%M%S)
    find "$input_dir" -type f -name '*.log' -print0 |  tar --null -czvf "log_archive_$timestap.tar.gz" --transform="s|^$input_dir/||" --files-from -
elif [ $# -lt 1 ]; then
    echo "Dir address required."
    exit 1 
else 
    echo "Too many args. only one dir address is enough!"
    exit 2
fi

