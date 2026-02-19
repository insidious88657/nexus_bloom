#!/usr/bin/env bash
set -euo pipefail

# --- env bootstrap ----------------------------------------------------------
if [[ ! -f .env ]]; then
  cat << 'EOF' > .env
SERVER_PORT=3000
FEDERATION_ENDPOINT=http://localhost:3000/federate
DEBUG=true
EOF
fi
# shellcheck disable=SC1091
source .env

echo "[NexusBloom] Starting dev environment..."

# --- server boot (skip if port in use) -------------------------------------
PORT_CHECK=$(ss -ltn "sport = :$SERVER_PORT" | wc -l | tr -d ' ' || true)
if [[ "${PORT_CHECK:-0}" -gt 1 ]]; then
  echo "[server] Port $SERVER_PORT already in use. Skipping local server start."
  SERVER_PID=""
else
  echo "[server] Installing deps (if needed) & starting dev server on :$SERVER_PORT..."
  pushd server >/dev/null
  [[ -d node_modules ]] || npm install
  npm run dev &
  SERVER_PID=$!
  popd >/dev/null
  echo "[server] PID=$SERVER_PID"
fi

cleanup() {
  if [[ -n "${SERVER_PID:-}" ]] && ps -p "$SERVER_PID" >/dev/null 2>&1; then
    echo "[cleanup] Stopping server ($SERVER_PID)"
    kill "$SERVER_PID" || true
  fi
}
trap cleanup EXIT

# --- flutter prep -----------------------------------------------------------
echo "[flutter] Resolving packages..."
pushd app >/dev/null
flutter pub get

# Pick an AVD if none running
if ! adb devices | awk 'NR>1 {print $1}' | grep -q emulator; then
  echo "[emulator] No emulator detected; attempting to start one..."
  AVD_NAME=${AVD_NAME:-$(emulator -list-avds | head -n1 || true)}
  if [[ -z "${AVD_NAME:-}" ]]; then
    echo "[emulator] No AVDs found. Create one via Android Studio or 'avdmanager'." >&2
    exit 1
  fi
  echo "[emulator] Launching AVD: $AVD_NAME"
  nohup emulator -avd "$AVD_NAME" -no-snapshot-load >/dev/null 2>&1 &
  # Give it time to boot
  echo "[emulator] Waiting for device boot..."
  adb wait-for-device || true
  # Additional grace period for boot animation to finish
  sleep 15
fi

# Use 10.0.2.2 to access host from Android emulator
APP_SERVER_URL="http://10.0.2.2:${SERVER_PORT}"

echo "[flutter] Launching app with SERVER_URL=${APP_SERVER_URL}"
# Use --profile if you want better perf; default to debug hot reload
flutter run --debug --dart-define=SERVER_URL="${APP_SERVER_URL}"

popd >/dev/null
