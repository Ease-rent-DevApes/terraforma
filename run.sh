#!/bin/bash

# Set the directory containing the Bash files
directory="/scripts"

# Get the list of Bash files in the directory
files=$(find "$directory" -name "*.sh" -type f)

# Print the list of files and ask the user which ones to run
echo "Select the scripts to run:"
echo "a) All scripts"
for file in $files; do
  echo "$(basename "$file")"
done
read -rp "Enter the script numbers (separated by spaces): " choices

# Execute the selected scripts
for choice in $choices; do
  if [[ "$choice" == "a" ]]; then
    for file in $files; do
      bash "$file"
    done
  else
    file="$directory/$(sed -n "${choice}p" <<< "$files")"
    if [[ -x "$file" ]]; then
      bash "$file"
    else
      echo "Error: $file is not executable."
    fi
  fi
done