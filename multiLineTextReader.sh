#!/bin/bash

# Prompt the user for input
echo "Enter your text. Press Ctrl+D on an empty line to finish:"
# Capture multi-line input from the user
IFS=''         # Disable word splitting
input_lines="" # Variable to store the input

while IFS= read -r line; do
    input_lines+="$line"$'\n'
done

# Prompt the user for the output file name
read -p "Enter the output file name: " output_file

# Write the input to the output file
echo "$input_lines" > "$output_file"

echo "Input has been written to $output_file"
