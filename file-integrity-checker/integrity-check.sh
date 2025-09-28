#!/usr/bin/bash

# Input commands
cmd="$1"
path="$2"

# Base of hash
BaseHashStore="/usr/local/share/hash/store/"
mkdir -p "$BaseHashStore"

# ********** Functions *************
checkPath(){
    local path="$1"
    if [ -d "$path" ]; then
        # echo "This is a dir"
        return 1
    elif [ -f "$path" ]; then
        # echo "This is a file"
        return 2
    else
        # echo "wrong path input"
        return 3
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