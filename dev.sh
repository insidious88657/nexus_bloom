#!/bin/bash

# Simple development startup without Docker
# 12-Factor: Config via env, fast startup

echo "Starting Nexus Bloom (Development Mode)..."

# Install server dependencies if needed
if [ ! -d "server/node_modules" ]; then
  echo "Installing server dependencies..."
  cd server && npm install && cd ..
fi

# Start server in background
echo "Starting server on port 3000..."
cd server
node index.js &
SERVER_PID=$!
cd ..

echo "Server PID: $SERVER_PID"
echo ""
echo "✓ Server running at http://localhost:3000"
echo ""
echo "To run the Flutter app:"
echo "  cd app && flutter run"
echo ""
echo "To stop the server:"
echo "  kill $SERVER_PID"
