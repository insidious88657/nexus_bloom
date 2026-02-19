#!/bin/bash

echo "Starting Nexus Bloom..."

# Install server dependencies if needed
if [ ! -d "server/node_modules" ]; then
  echo "Installing server dependencies..."
  cd server && npm install && cd ..
fi

# Start Docker services
echo "Starting Docker services..."
docker compose up -d

# Install Flutter dependencies
echo "Getting Flutter dependencies..."
cd app && flutter pub get && cd ..

echo ""
echo "✓ Nexus Bloom is ready!"
echo "✓ Server: http://localhost:3000"
echo ""
echo "To run the mobile app:"
echo "  cd app && flutter run"
echo ""
echo "To view server logs:"
echo "  docker compose logs -f server"
