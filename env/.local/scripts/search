#!/bin/bash

# Configuration
BROWSER="zen-browser"  # Replace with your preferred browser (e.g., chromium, google-chrome)
SEARCH_ENGINE="https://google.com/?q="  # Replace with your preferred search engine (e.g., https://www.google.com/search?q=)

# Run Rofi in drun mode and capture the user's input
# Use -no-custom to ensure only valid .desktop entries are selected, or custom input is captured
INPUT=$(rofi -show drun -show-icons -no-custom -p "Run or Search: ")

# Check if Rofi was exited without selection (e.g., Esc key)
if [ -z "$INPUT" ]; then
    exit 0
fi

# Check if the input matches a .desktop entry by running rofi again in drun mode
# We use echo  (fuzzy matching) to check if the input corresponds to a valid application
if rofi -show drun -show-icons -filter "$INPUT" | grep -q "^$INPUT$"; then
    # Input matches a program, so execute it
    # The input is already a valid .desktop entry name, so launch it
    gtk-launch "$INPUT" &
else
    # No matching program found, so treat the input as a search query
    $BROWSER "${SEARCH_ENGINE}${INPUT}" &
fi

