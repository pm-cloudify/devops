#!/usr/bin/bash

# Input commands
cmd="$1"
path="$2"


# Colors
BLUE="\033[34m"
GREEN="\033[32m"
RED="\033[31m"
NC="\033[0m"

# Base of hash
BaseHashStore="/usr/local/share/hash/store/"

if [ ! -d "$BaseHashStore" ]; then
    mkdir -p "$BaseHashStore"
fi

# ********** Functions *************
checkPath(){
    local path="$1"
    if [ -d "$path" ]; then
        # echo "This is a dir"
        return 0
    elif [ -f "$path" ]; then
        # echo "This is a file"
        return 0
    else
        # echo "wrong path input"
        exit 1
    fi
}

generateHash(){
    local target="$1"
    local hash_file="$2"

    if [ -d "$target" ]; then
        find "$target" -type f | xargs sha256sum > "$hash_file" 2>/dev/null
    elif [ -f "$target" ]; then
        sha256sum "$target" > "$hash_file"
    else
        echo -e "$RED The specified path is neither a file nor a directory. $NC"
    fi
}

# check hash integrity
check() {
    local path="$1"
}

# update hash of log
update() {
    local filePath="$1"
    local res=$(sha256sum "filePath" | awk '{ print $1 }')
    return "$res"
}

# update this file hashes
update() { 
    echo ""
}

# help message
_help() {
    echo -e "Invalid option: $1 \n    • Use 'init', 'update', or 'check'."
}

# ********** End of functions 

# cmd run

checkPath "$path"

case "$1" in 
    init)
        init "$path"
        ;;
    check)
        check "$path"
        ;;
    update)
        init "$path"
        ;;
    *)
        _help "$cmd"
        ;;
esac
