#!/bin/bash

# Railway start script for PocketBase
echo "Starting PocketBase on port ${PORT:-8080}"

# Start PocketBase with the port from Railway
./pocketbase serve --http=0.0.0.0:${PORT:-8080}