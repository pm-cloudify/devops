#!/bin/bash

# Colors
BLUE="\033[34m"
GREEN="\033[32m"
RED="\033[31m"
NC="\033[0m"

# Default directory for storing hashes
HASH_BASE_PATH=~/.local/share/hash/

# Ensure the hash base path exists
if [ ! -d "$HASH_BASE_PATH" ]; then
    mkdir -p "$HASH_BASE_PATH"
fi

# Function to generate the hash for a file or directory
generate_hash() {
    local target_path="$1"
    local hash_file="$2"

    if [ -d "$target_path" ]; then
        # If it's a directory, hash all files within the directory
        find "$target_path" -type f | xargs sha256sum > "$hash_file" 2>/dev/null
    elif [ -f "$target_path" ]; then
        # If it's a single file, hash it directly
        sha256sum "$target_path" > "$hash_file"
    else
        echo -e "$RED The specified path is neither a file nor a directory. $NC"
    fi
}

# Function to initialize hash generation
init() {
    echo -e "$BLUE Init mode $NC"

    local target_path="$1"
    if [ -z "$target_path" ]; then
        echo -e "$RED No file or directory specified for hash generation. $NC"
        echo -e "Example Usage: \n   • ./integrity-check init /var/log \n   • ./integrity-check init text.txt"
        return
    fi

    if [ ! -e "$target_path" ]; then
        echo -e "$RED The specified path does not exist: $target_path $NC"
        return
    fi

    # Generate a unique file name for the hash storage based on the target's name
    local hash_file="$HASH_BASE_PATH$(basename "$target_path")-$(date "+%Y-%m-%d_%H-%M-%S").sha256sum"

    echo "Generating hash for: $target_path"
    generate_hash "$target_path" "$hash_file"
    echo -e "$GREEN Hashes saved successfully to: $hash_file $NC"
}

# Function to check hashes against the stored .sha256sum file
check() {
    echo -e "$BLUE Check mode $NC"
    
    local target_path="$1"
    if [ -z "$target_path" ]; then
        echo -e "$RED No file or directory specified for hash check. $NC"
        return
    fi

    # Find the most recent hash file for the target (based on date in file name)
    local hash_file=$(ls -t "$HASH_BASE_PATH"$(basename "$target_path")-*.sha256sum 2>/dev/null | head -n 1)

    if [ -z "$hash_file" ]; then
        echo -e "$RED No hash file found for: $target_path\n Please initialize the hash first by: $NC \n    • ./integrity-check init $target_path $NC"
        return
    fi

    echo -e "$BLUE Checking hash: $hash_file $NC"
    sha256sum -c "$hash_file" || echo -e "$RED Hash mismatch found $NC"
}

# Function to update the hash list
update() {
    echo -e "$BLUE Update mode $NC"

    local target_path="$1"
    if [ -z "$target_path" ]; then
        echo -e "$RED No file or directory specified for hash update. $NC"
        return
    fi

    if [ ! -e "$target_path" ]; then
        echo -e "$RED The specified path does not exist: $target_path $NC"
        return
    fi

    echo -e "$BLUE Updating hash list for: $target_path $NC"
    
    # Find the most recent hash file for the target (based on the target's name)
    local old_hash_file=$(ls -t "$HASH_BASE_PATH"$(basename "$target_path")-*.sha256sum 2>/dev/null | head -n 1)

    # If no hash file exists, prompt the user to initialize the hash first
    if [ -z "$old_hash_file" ]; then
        echo -e "$RED No hash file found. Please initialize the hash first by: $NC \n    • ./integrity-check init $target_path $NC"
        return
    fi

    # Remove the old hash file if it exists
    echo -e "$RED Removing old hash file: $old_hash_file $NC"
    rm -f "$old_hash_file"

    # Generate a new hash file with a timestamp-based name
    local hash_file="$HASH_BASE_PATH$(basename "$target_path")-$(date "+%Y-%m-%d_%H-%M-%S").sha256sum"

    generate_hash "$target_path" "$hash_file"
    echo -e "$GREEN Hash list updated successfully for: $target_path $NC"
}


_help() {
    echo -e "Invalid option: $1 \n    • Use 'init', 'update', or 'check'."
}

# Main case to handle different modes
case "$1" in
    init)
        init "$2"
        ;;
    check)
        check "$2"
        ;;
    update)
        update "$2"
        ;;
    *)
        _help "$1"
        ;;
esac
