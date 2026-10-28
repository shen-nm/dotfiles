#!/usr/bin/env bash

# Configuration
SOURCE_DIR="$HOME/Music/Library"
BITRATE="320k"
CORES=$(nproc)

# Export BITRATE so parallel subshells inherit it cleanly
export BITRATE

echo "Starting Parallel Conversion ($CORES cores)..."

# Convert FLAC to 320k MP3 in parallel
find "$SOURCE_DIR" -type f -iname "*.flac" -print0 | xargs -0 -P "$CORES" -n 1 bash -c '
    input="$1"
    output="${input%.*}.mp3"

    echo "Processing: $(basename "$input")"

    # -n: skip if output exists
    # -map 0:a -map 0:v?: preserves audio AND embedded album art
    # -c:a libmp3lame -b:a: modern ffmpeg audio bitrate syntax
    # -id3v2_version 3: ensures broad player compatibility
    ffmpeg -loglevel error -n -i "$input" \
        -map 0:a -map 0:v? -c:a libmp3lame -b:a "$BITRATE" -c:v copy \
        -map_metadata 0 -id3v2_version 3 \
        "$output" && rm "$input"
' _

echo "All FLACs converted and original files removed."

# --- CLEANUP STEP ---
echo "Scrubbing junk files (.lrc, .txt) from library..."
find "$SOURCE_DIR" -type f \( -name "*.lrc" -o -name "*.txt" \) -delete

echo "Cleanup complete!"
