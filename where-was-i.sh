#!/bin/bash

# Function to prompt the user to return to the last opened directory
function prompt_last_dir() {
    # Check if the last directory exists and is readable
    if [ -f ~/.last_dir ] && [ -r ~/.last_dir ]; then
        # Read the last directory from the file
        LAST_DIR=$(cat ~/.last_dir)

        # Prompt the user to return to the last directory
        read -p "Do you want to return to the last opened directory? ($LAST_DIR) [Y/n]: " RESPONSE

        # If the user agrees, change to the last directory
        if [[ "$RESPONSE" =~ ^[Yy]$ ]] || [[ -z "$RESPONSE" ]]; then
            cd "$LAST_DIR"
        fi
    fi
}

# Function to save the current directory to a file
function save_last_dir() {
    # Save the current directory to the file
    pwd > ~/.last_dir
}

# Call the prompt_last_dir function when the script is sourced
prompt_last_dir

# Save the current directory when the shell exits
trap save_last_dir EXIT
