#!/bin/bash

# Set the directory containing the Bash files
directory="scripts"

# Get the list of Bash files in the directory
files=$(find "$directory" -name "*.sh" -type f)

# Make all files executable
for file in $files; do
  chmod +x "$file"
done

# Print a confirmation message
echo "All files in the $directory directory have been made executable."