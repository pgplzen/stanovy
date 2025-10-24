#!/bin/bash

# Docker-based pandoc converter
# Usage: ./convert-to-pdf.sh input.md output.pdf

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [ -z "$INPUT_FILE" ] || [ -z "$OUTPUT_FILE" ]; then
    echo "Usage: $0 input.md output.pdf"
    exit 1
fi

# Get the directory of the input file
INPUT_DIR=$(dirname "$(realpath "$INPUT_FILE")")
INPUT_FILENAME=$(basename "$INPUT_FILE")
OUTPUT_FILENAME=$(basename "$OUTPUT_FILE")

echo "Converting $INPUT_FILENAME to $OUTPUT_FILENAME using Docker..."

docker run --rm \
    --platform linux/amd64 \
    -v "$INPUT_DIR":/data \
    -w /data \
    pandoc/latex:latest \
    "$INPUT_FILENAME" \
    -o "$OUTPUT_FILENAME" \
    --pdf-engine=xelatex \
    -V geometry:margin=1in \
    -V fontsize=12pt \
    -V documentclass=article \
    -V lang=cs

echo "Conversion complete: $OUTPUT_FILE"
