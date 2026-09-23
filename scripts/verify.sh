#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUBIX_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "==> Verifying bit-for-bit deterministic self-hosting..."
bash "$RUBIX_ROOT/scripts/selfhost.sh"
echo "==> Determinism verification PASSED."
