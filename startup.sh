#!/bin/bash

echo "Starting Nexus Bloom..."

# Start Docker services
docker-compose up -d

# Install Flutter dependencies
cd app && flutter pub get && cd ..

echo "Nexus Bloom is ready!"
echo "Server: http://localhost:3000"
echo "Run 'flutter run' in the app directory to start the mobile app"
