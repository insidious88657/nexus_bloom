# Nexus Bloom

AI symbiote - A Flutter mobile application with a Node.js local server.

## Project Structure

```
nexus_bloom/
├── app/                # Flutter mobile app
│   ├── lib/
│   │   ├── main.dart
│   │   ├── providers/  # Riverpod state
│   │   ├── screens/    # UI pages
│   │   ├── models/     # Data classes
│   │   ├── services/   # Abstracts + impls
│   │   └── widgets/    # Custom UI components
│   ├── pubspec.yaml
│   └── android/ ios/   # Platform specifics
├── server/             # Node.js local server
│   ├── index.js
│   ├── package.json
│   └── .env
├── docker-compose.yml  # Orchestrates everything
├── startup.sh          # One-command start
├── .env                # Shared config
└── README.md           # Docs
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Node.js (18+)
- Docker & Docker Compose (optional, for containerized deployment)

### Quick Start (Development)

#### Option 1: Simple Development Mode (No Docker)

1. Install server dependencies:
   ```bash
   cd server && npm install && cd ..
   ```

2. Start the server:
   ```bash
   cd server && npm run dev
   ```

3. In a new terminal, run the Flutter app:
   ```bash
   cd app && flutter run
   ```

#### Option 2: Docker Mode

1. Build and start services:
   ```bash
   docker compose up -d
   ```

2. Run the Flutter app:
   ```bash
   cd app && flutter run
   ```

## Development

### Server
- Development: `cd server && npm run dev`
- Production: `cd server && npm start`

### Mobile App
- Run: `cd app && flutter run`
- Test: `cd app && flutter test`
- Build: `cd app && flutter build apk` (Android) or `flutter build ios` (iOS)

## Configuration

Edit `.env` files for environment-specific configuration:
- Root `.env`: Shared configuration
- `server/.env`: Server-specific configuration
