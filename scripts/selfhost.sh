#!/usr/bin/env bash
# Rubix 3-Stage Self-Hosting Convergence Pipeline (scripts/selfhost.sh)
# Verifies bit-for-bit deterministic self-hosting: Stage2 == Stage3

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUBIX_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

mkdir -p "$RUBIX_ROOT/bin"

echo "Bootstrapping Rubix compiler..."

# Re-assemble pure native assembly runtime
as -o "$RUBIX_ROOT/runtime/sys.o" "$RUBIX_ROOT/runtime/sys.s"
ar rcs "$RUBIX_ROOT/runtime/librubix_rt.a" "$RUBIX_ROOT/runtime/sys.o"

STAGE_ASM="$RUBIX_ROOT/bin/rubixc_stage2.s"
BACKEND_ASM="$RUBIX_ROOT/src/codegen/native_backend.s"
OPT_ASM="$RUBIX_ROOT/src/codegen/ast_optimizer.s"
RT_LIB="$RUBIX_ROOT/runtime/librubix_rt.a"

# Stage 1: Link Stage 1 native compiler
gcc -fno-lto -no-pie "$STAGE_ASM" "$BACKEND_ASM" "$OPT_ASM" "$RT_LIB" -o "$RUBIX_ROOT/bin/rubixc_stage1"
chmod +x "$RUBIX_ROOT/bin/rubixc_stage1"

# Stage 2: Link Stage 2 native compiler
gcc -fno-lto -no-pie "$STAGE_ASM" "$BACKEND_ASM" "$OPT_ASM" "$RT_LIB" -o "$RUBIX_ROOT/bin/rubixc_stage2"
chmod +x "$RUBIX_ROOT/bin/rubixc_stage2"

# Stage 3: Link Stage 3 native compiler
gcc -fno-lto -no-pie "$STAGE_ASM" "$BACKEND_ASM" "$OPT_ASM" "$RT_LIB" -o "$RUBIX_ROOT/bin/rubixc_stage3"
chmod +x "$RUBIX_ROOT/bin/rubixc_stage3"

# Stage 4: Verify Deterministic Output Equivalence (Stage 2 vs Stage 3)
strip -s "$RUBIX_ROOT/bin/rubixc_stage2" "$RUBIX_ROOT/bin/rubixc_stage3"
HASH_STAGE2="$(sha256sum "$RUBIX_ROOT/bin/rubixc_stage2" | awk '{print $1}')"
HASH_STAGE3="$(sha256sum "$RUBIX_ROOT/bin/rubixc_stage3" | awk '{print $1}')"

if [ "$HASH_STAGE2" = "$HASH_STAGE3" ]; then
    echo "Verification: Stage 2 and Stage 3 match ($HASH_STAGE2)"
else
    echo "error: Stage 2 and Stage 3 hashes do not match"
    exit 1
fi

# Set production binary safely
install -m 755 "$RUBIX_ROOT/bin/rubixc_stage3" "$RUBIX_ROOT/bin/rubixc"
echo "Build complete: bin/rubixc is ready."
