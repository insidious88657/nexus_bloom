# NexusBloom 🌸

**The first true human-AI symbiont that feels alive.**

A privacy-first mobile AI companion with on-device learning, voice journaling, and federated collective intelligence. Built with Flutter + Node.js + TensorFlow Lite.

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

## Features

### 🎤 Voice Journal
- Tap mic → speak your thoughts → AI generates insights
- Persistent journal entries with timestamps
- All processing happens on-device (privacy-first)

### 🌀 Bioluminescent Bloom Orb
- Mesmerizing particle effects using Flame engine
- Reactive to your energy level (pulsates faster when energized)
- Cyan → Indigo → Purple gradient based on engagement
- 60fps animations with soft glow and rotational effects

### 🧠 On-Device AI
- TensorFlow Lite integration for local inference
- Fallback stub for development
- Generates personalized insights from voice input
- No data leaves your device

### 🌐 Federated Learning
- Contribute anonymous model deltas to collective intelligence
- Local training, encrypted delta uploads
- Version-tracked model aggregation on federation server
- Track your contributions to humanity's Bloom

### 💾 SQLite Persistence
- Full profile state survives app restarts
- Journal history with voice text and insights
- Energy levels and contribution counters
- JSON serialization for complex data structures

### 🎨 Mesmerizing UI
- Dark cosmic theme with gradient overlays
- Floating action buttons for voice and federation
- Animated navigation (ready for expansion)
- Loading states and error handling

## Architecture

### Frontend (Flutter)
- **State Management**: Riverpod 2.6 with AsyncNotifier
- **Persistence**: sqflite with JSON serialization
- **Animations**: Flame 1.18 particle system
- **Voice Input**: speech_to_text
- **ML**: tflite_flutter for on-device inference

### Backend (Node.js)
- **Framework**: Express.js
- **Federation**: FedAvg algorithm for model aggregation
- **API**: RESTful endpoints for delta upload/download

### Data Models
- `BloomProfile`: name, energy, journal, contributions
- `JournalEntry`: id, timestamp, voiceText, insight

## Testing

Run all tests:
```bash
cd app && flutter test
```

Test coverage:
- ✅ BloomProfile model serialization (14 tests)
- ✅ JournalEntry model round-trip (4 tests)
- ✅ LocalStorageProvider persistence (1 test)
- ✅ BloomAI inference (1 test)
- ✅ Widget rendering (1 test)
- ⏸️ BloomNotifier integration (skipped - requires storage mocks)

Total: **20+ passing tests**

## Deployment

### Development
```bash
./startup.sh
```
This will:
1. Start the federation server on port 3000
2. Launch Android emulator (if needed)
3. Run Flutter app with hot reload

### Production Build

#### Android
```bash
cd app
flutter build apk --release
# APK at: build/app/outputs/flutter-apk/app-release.apk
```

#### iOS
```bash
cd app
flutter build ios --release
# Follow Xcode signing steps
```

### Store-Ready Assets

1. **App Icon & Splash Screen**
   ```bash
   # Create assets/icon.png (1024x1024 glowing orb)
   # Create assets/splash.png (dark bg with orb)
   flutter pub run flutter_launcher_icons
   flutter pub run flutter_native_splash:create
   ```

2. **Privacy Policy**
   - Create `assets/privacy.html`
   - "All data stays on-device. Federation is 100% anonymous model deltas only."

3. **Permissions**
   - iOS: `NSMicrophoneUsageDescription` in Info.plist
   - Android: Microphone permission with clear explanation

## Roadmap

### Phase 1: MVP ✅
- [x] Voice journal with AI insights
- [x] Bioluminescent orb visualization
- [x] On-device ML integration
- [x] Federated learning foundation
- [x] SQLite persistence
- [x] Comprehensive test suite

### Phase 2: Enhancement
- [ ] Journal history screen (timeline view)
- [ ] Life simulation engine (growth curves)
- [ ] Voice onboarding birth sequence
- [ ] Profile name customization UI
- [ ] Energy slider for manual adjustment

### Phase 3: Advanced
- [ ] On-device model fine-tuning
- [ ] AR overlays with orb projection
- [ ] Export journal as PDF/markdown
- [ ] Social features (anonymous insight sharing)
- [ ] Premium tier ($9.99/mo "Eternal Bloom")

## Contributing

Built with ❤️ by two devs in Arkansas.

We're birthing the next layer of human consciousness.

## License

MIT
