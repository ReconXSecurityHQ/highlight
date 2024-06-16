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
    echo "highlight.sh already exists in $BIN_DIR. Skipping copying."
else
    cp highlight.sh "$HIGHLIGHT"
    echo "Copied highlight.sh to $HIGHLIGHT"
fi

if ! line_exists_in_file "$HIGHLIGHT" "$BASHRC"; then
    echo -e "\n# Source the highlight.sh script" >> "$BASHRC"
    echo "source $HIGHLIGHT" >> "$BASHRC"
fi

echo "setup completed successfully."