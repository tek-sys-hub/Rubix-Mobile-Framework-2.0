#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUBIX_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "==> Running Rubix comprehensive test suite..."

# 1. Run all canonical example programs
for f in "$RUBIX_ROOT"/examples/*.bix; do
    echo "Testing $f..."
    "$RUBIX_ROOT/rubix" run "$f" > /dev/null
done

# 2. Run memory safety test
if [ -f "$RUBIX_ROOT/tests/test_memory_safety.bix" ]; then
    echo "Testing tests/test_memory_safety.bix..."
    "$RUBIX_ROOT/rubix" run "$RUBIX_ROOT/tests/test_memory_safety.bix" > /dev/null
fi

echo "All tests passed successfully!"
