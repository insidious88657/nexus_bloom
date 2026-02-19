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
- Flutter SDK
- Docker & Docker Compose
- Node.js (for local development)

### Quick Start

1. Make the startup script executable:
   ```bash
   chmod +x startup.sh
   ```

2. Run the startup script:
   ```bash
   ./startup.sh
   ```

3. Start the Flutter app:
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
