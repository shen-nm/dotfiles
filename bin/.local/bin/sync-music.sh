#!/bin/bash

LOCAL_DIR="$HOME/Music/Library/"
REMOTE_TARGET="root@192.168.8.100:/mnt/data/music/"

echo "Music Sync Pipeline Started"
echo "Source: $LOCAL_DIR"
echo "Target: $REMOTE_TARGET"

# Function to execute the rsync
do_sync() {
    echo "--- Syncing at $(date +%H:%M:%S) ---"
    # Added -P for progress and --info=progress2 for better feedback
    rsync -avzP --delete "$LOCAL_DIR" "$REMOTE_TARGET"
}

do_sync

echo "EXIT: Sync finished."
