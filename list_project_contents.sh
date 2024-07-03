#!/bin/bash

# Function to print file contents
print_file_contents() {
    echo "Contents of $1:"
    echo "----------------------------------------"
    cat "$1"
    echo "----------------------------------------"
    echo ""
}

# Function to recursively list directory contents
list_contents() {
    for item in "$1"/*; do
        if [ -d "$item" ]; then
            echo "Directory: $item"
            list_contents "$item"
        elif [ -f "$item" ]; then
            echo "File: $item"
            # Print contents of important files
            case "$item" in
                *.py|*.js|*.json|*.yaml|*.yml|*.txt|*.md|*.html|*.css)
                    print_file_contents "$item"
                    ;;
            esac
        fi
    done
}

# Start listing from the current directory
echo "Listing contents of product_attribution_matching:"
list_contents "."
