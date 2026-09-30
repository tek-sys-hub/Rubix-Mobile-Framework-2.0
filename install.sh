#!/usr/bin/env bash
# Official Rubix 1.0.0 Fast Installer for Linux x86_64
set -e

RUBIX_DIR="$HOME/.rubix"
BIN_DIR="$RUBIX_DIR/bin"
RUNTIME_DIR="$RUBIX_DIR/runtime"
LOCAL_BIN="$HOME/.local/bin"

echo "=========================================================="
echo "         Rubix Programming Language Installer            "
echo "=========================================================="

# 1. Architecture check
ARCH="$(uname -m)"
OS="$(uname -s)"

if [ "$OS" != "Linux" ] || [ "$ARCH" != "x86_64" ]; then
    echo "Notice: Native pre-built binaries currently target Linux x86_64."
    echo "Detected: $OS $ARCH. Attempting source compilation..."
fi

# 2. Toolchain check
if ! command -v as >/dev/null 2>&1 || ! command -v gcc >/dev/null 2>&1; then
    echo "Warning: GNU Assembler (as) or GCC not found."
    echo "Please ensure build tools are installed:"
    echo "  Ubuntu/Debian: sudo apt install build-essential"
    echo "  Arch Linux:    sudo pacman -S base-devel"
    echo "  Fedora:        sudo dnf groupinstall 'Development Tools'"
fi

mkdir -p "$BIN_DIR" "$RUNTIME_DIR" "$LOCAL_BIN"

# 3. Check if running inside cloned repo or via curl
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
if [ -f "$SCRIPT_DIR/bin/rubixc" ] && [ -f "$SCRIPT_DIR/runtime/librubix_rt.a" ]; then
    echo "Installing from local repository directory..."
    cp -p "$SCRIPT_DIR/bin/rubix" "$BIN_DIR/rubix"
    cp -p "$SCRIPT_DIR/bin/rubixc" "$BIN_DIR/rubixc"
    cp -p "$SCRIPT_DIR/runtime/librubix_rt.a" "$RUNTIME_DIR/librubix_rt.a"
    chmod +x "$BIN_DIR/rubix" "$BIN_DIR/rubixc"
else
    echo "Downloading Rubix toolchain from GitHub Release..."
    TMP_TAR="/tmp/rubix_release_$$.tar.gz"
    RELEASE_URL="https://github.com/tek-sys-hub/Rubix-Mobile-Framework-2.0/releases/download/v1.0.0/rubix-v1.0.0-linux-x86_64.tar.gz"
    
    if curl -fsSL "$RELEASE_URL" -o "$TMP_TAR"; then
        tar -xzf "$TMP_TAR" -C "$RUBIX_DIR"
        rm -f "$TMP_TAR"
    else
        echo "Release tarball unavailable. Cloning and bootstrapping..."
        TMP_CLONE="/tmp/rubix_clone_$$"
        git clone https://github.com/tek-sys-hub/Rubix-Mobile-Framework-2.0.git "$TMP_CLONE"
        cd "$TMP_CLONE"
        bash scripts/selfhost.sh
        cp -p bin/rubix "$BIN_DIR/rubix"
        cp -p bin/rubixc "$BIN_DIR/rubixc"
        cp -p runtime/librubix_rt.a "$RUNTIME_DIR/librubix_rt.a"
        cd "$HOME"
        rm -rf "$TMP_CLONE"
    fi
fi

# 4. Link binary to ~/.local/bin/rubix
ln -sf "$BIN_DIR/rubix" "$LOCAL_BIN/rubix"
echo "Linked executable to $LOCAL_BIN/rubix"

# 5. Shell PATH setup
SHELL_RC=""
if [ -n "$BASH_VERSION" ]; then
    SHELL_RC="$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
elif [ -f "$HOME/.profile" ]; then
    SHELL_RC="$HOME/.profile"
fi

PATH_EXPORT='export PATH="$HOME/.local/bin:$HOME/.rubix/bin:$PATH"'
if [ -n "$SHELL_RC" ] && [ -f "$SHELL_RC" ]; then
    if ! grep -q ".local/bin" "$SHELL_RC" && ! grep -q ".rubix/bin" "$SHELL_RC"; then
        echo "" >> "$SHELL_RC"
        echo "# Rubix programming language toolchain" >> "$SHELL_RC"
        echo "$PATH_EXPORT" >> "$SHELL_RC"
        echo "Added Rubix to $SHELL_RC"
    fi
fi

# 6. Check for VS Code and install extension if present
if command -v code >/dev/null 2>&1; then
    if [ -f "$SCRIPT_DIR/editors/vscode/rubix-lang-1.0.0.vsix" ]; then
        echo "Installing Rubix VS Code extension..."
        code --install-extension "$SCRIPT_DIR/editors/vscode/rubix-lang-1.0.0.vsix" --force >/dev/null 2>&1 || true
    fi
fi

# 7. Verification
export PATH="$LOCAL_BIN:$BIN_DIR:$PATH"
echo ""
echo "Installation complete!"
if command -v rubix >/dev/null 2>&1; then
    rubix version
    rubix doctor
fi

echo "=========================================================="
echo "Run 'rubix help' to get started."
echo "=========================================================="
