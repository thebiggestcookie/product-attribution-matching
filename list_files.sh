#!/bin/bash

# Output file
OUTPUT_FILE="project_contents.txt"

# Function to print file contents
print_file_contents() {
    echo "Contents of $1:" >> "$OUTPUT_FILE"
    echo "----------------------------------------" >> "$OUTPUT_FILE"
    cat "$1" >> "$OUTPUT_FILE"
    echo "----------------------------------------" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
}

# Function to list specific files
list_specific_files() {
    local dir=$1
    local prefix=$2

    # List and print contents of specific files
    for file in $dir/*.py $dir/*.js $dir/*.json $dir/*.yaml $dir/*.yml $dir/*.txt $dir/*.md; do
        if [ -f "$file" ]; then
            echo "${prefix}File: $(basename "$file")" >> "$OUTPUT_FILE"
            print_file_contents "$file"
        fi
    done

    # List directories but don't recurse
    for item in $dir/*; do
        if [ -d "$item" ] && [ "$(basename "$item")" != "node_modules" ]; then
            echo "${prefix}Directory: $(basename "$item")" >> "$OUTPUT_FILE"
        fi
    done
}

# Main execution
echo "Listing key contents of product_attribution_matching:" > "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

echo "Root directory:" >> "$OUTPUT_FILE"
list_specific_files "." "  "

echo "Backend directory:" >> "$OUTPUT_FILE"
list_specific_files "./backend" "  "

echo "Frontend directory:" >> "$OUTPUT_FILE"
list_specific_files "./frontend" "  "

echo "Frontend src directory:" >> "$OUTPUT_FILE"
list_specific_files "./frontend/src" "  "

echo "Project contents have been written to $OUTPUT_FILE"
