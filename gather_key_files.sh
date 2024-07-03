#!/bin/bash

OUTPUT_FILE="key_files_content.txt"

# Function to add file content to the output
add_file_content() {
    if [ -f "$1" ]; then
        echo "=== Content of $1 ===" >> "$OUTPUT_FILE"
        cat "$1" >> "$OUTPUT_FILE"
        echo -e "\n\n" >> "$OUTPUT_FILE"
    else
        echo "File not found: $1" >> "$OUTPUT_FILE"
    fi
}

# Start with a clean output file
echo "Key Files Content" > "$OUTPUT_FILE"
echo "==================" >> "$OUTPUT_FILE"

# Backend files
add_file_content "backend/app.py"
add_file_content "backend/requirements.txt"

# Frontend files
add_file_content "frontend/src/App.js"
add_file_content "frontend/package.json"

# Root directory files
add_file_content "render.yaml"
add_file_content ".env"  # If you have one in the root

echo "Content of key files has been written to $OUTPUT_FILE"
echo "You can now review this file and share its contents."
