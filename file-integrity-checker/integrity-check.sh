#!/usr/bin/bash

cmd="$1"
path="$2"

# TODO: check hash integrity
checkHash() {
    echo ""
}

# TODO: update hash of log
updateHash() {
    echo ""
}

# TODO: check and run cmd
runCommand() { 
    echo ""
}

if [ -d "$path" ]; then
    echo "This is a dir"
elif [ -f "$path" ]; then
    echo "This is a file"
else
    echo "wrong path input"
fi
