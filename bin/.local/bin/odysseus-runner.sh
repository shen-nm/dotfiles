#!/bin/bash

# Function to clean up background tasks on exit
cleanup() {
    echo -e "\nStopping Odysseus and Ollama..."
    pkill -f "uvicorn app:app"
    # Optional: Uncomment the next line if you want the script to fully stop Ollama too
    # sudo systemctl stop ollama
    exit 0
}

# Trap Ctrl+C (SIGINT) and call the cleanup function
trap cleanup SIGINT

echo "Starting Ollama service..."
sudo systemctl start ollama

echo "Launching Odysseus..."
# Change this path to the exact location of your odysseus folder
cd ~/odysseus 
source venv/bin/activate

export OBSIDIAN_API_KEY="e36fb33a2366ec7e7fef553746cd076f7cd89557d5a2092b3c7032d4adb14435"
export OBSIDIAN_API_URL="https://127.0.0.1:27124"

python -m uvicorn app:app --host 127.0.0.1 --port 7000