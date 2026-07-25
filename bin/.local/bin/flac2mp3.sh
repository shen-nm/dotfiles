#!/bin/bash

# Configuration
SOURCE_DIR="$HOME/Music/Library"
BITRATE="320k"
# Get the number of CPU cores to run conversions in parallel
CORES=$(nproc)

echo "Starting Parallel Conversion ($CORES cores)..."

# Use find to feed files into xargs
# -0 handles spaces/special characters in filenames correctly
# -P $CORES runs multiple ffmpeg instances at once
find "$SOURCE_DIR" -name "*.flac" -type f -print0 | xargs -0 -P "$CORES" -I {} bash -c '
    input="$1"
    output="${input%.flac}.mp3"
    
    echo "Processing: $(basename "$input")"
    
    # -n: skip if exists | -map_metadata 0: copy Picard tags
    # -id3v2_version 3: Windows/Mobile compatibility
    ffmpeg -loglevel error -n -i "$input" -ab '$BITRATE' \
           -map_metadata 0 -id3v2_version 3 \
           "$output" && rm "$input"
' -- {}

echo "All FLACs converted and original files removed."

# --- NEW CLEANUP STEP ---
echo "Scrubbing junk files (.lrc, .txt) from library..."
find "$SOURCE_DIR" -type f \( -name "*.lrc" -o -name "*.txt" \) -delete
echo "Cleanup complete!"
