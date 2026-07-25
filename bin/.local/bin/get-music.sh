#!/bin/bash

LIBRARY="$HOME/Music/Library"

# Ensure the library directory exists
mkdir -p "$LIBRARY"

if [ -z "$1" ]; then
    echo "Usage: get-music [Spotify_URL]"
    exit 1
fi

echo "--- Downloading to Library ---"
# Removed --save-lyrics and added download sub-command for clarity
spotdl download "$1" --output "$LIBRARY/{artist}/{album}/{title}.{output-ext}" --generate-lrc --cookie-file ~/spotify-cookies.txt
# spotdl download "$1" --output "$LIBRARY/{artist}/{album}/{title}.{output-ext}" --generate-lrc --audio youtube-music --format mp3
echo "--- Opening Library ---"
xdg-open "$LIBRARY"
