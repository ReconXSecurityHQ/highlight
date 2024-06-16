#!/bin/bash

BIN_DIR=~/bin
BASHRC=~/.bashrc
HIGHLIGHT="$BIN_DIR/highlight.sh"

# Function to check if a line exists in a file
line_exists_in_file() {
    local line="$1"
    local file="$2"
    grep -qF -- "$line" "$file"
}

if [ ! -d "$BIN_DIR" ]; then
    mkdir -p "$BIN_DIR"
    echo "Created directory: $BIN_DIR"
fi

# Check if highlight.sh already exists in ~/bin
if [ -f "$HIGHLIGHT" ]; then
    rm "$HIGHLIGHT"
fi

cp highlight.sh "$HIGHLIGHT"

if ! line_exists_in_file "$HIGHLIGHT" "$BASHRC"; then
    echo -e "\n# Source the highlight.sh script" >> "$BASHRC"
    echo "source $HIGHLIGHT" >> "$BASHRC"
fi

if source ~/.bashrc; then
    echo "highlight successfully register to source"
fi