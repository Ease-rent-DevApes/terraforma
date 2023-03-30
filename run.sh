#!/bin/bash

# Set the directory containing the Bash files
directory="scripts"

# Get the list of Bash files in the directory
files=$(find "$directory" -name "*.sh" -type f)

# Print the list of files and ask the user which ones to run
echo -e "\e[44mSelect the scripts to run:\e[0m"
echo -e "\e[44ma) All scripts\e[0m"
i=1
for file in $files; do
  echo -e "\e[44m$i) $(basename "$file")\e[0m"
  ((i++))
done
read -rp $'\e[44mEnter the script numbers (separated by spaces): \e[0m' choices

# Execute the selected scripts
for choice in $choices; do
  if [[ "$choice" == "a" ]]; then
    for file in $files; do
      echo -e "\e[44mRunning $(basename "$file")...\e[0m"
      bash "$file"
    done
  else
    file="$directory/$(sed -n "${choice}p" <<< "$files")"
    if [[ -x "$file" ]]; then
      echo -e "\e[44mRunning $(basename "$file")...\e[0m"
      bash "$file"
    else
      echo -e "\e[41mError: $file is not executable.\e[0m"
    fi
  fi
done