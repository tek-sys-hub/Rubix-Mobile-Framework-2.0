# Getting Started with Rubix

Welcome to **Rubix**, a statically typed, expression-oriented systems programming language engineered for performance, reliability, and developer happiness.

---

## Installation

### Method 1: Build from Source (Recommended)

Rubix is 100% self-hosted and compiles with zero external dependencies aside from standard GNU assembler (`as`) and C linker (`gcc` or `clang`).

```bash
# 1. Clone the repository
git clone https://github.com/rubix-lang/rubix.git
cd rubix

# 2. Run the deterministic bootstrap script
bash scripts/selfhost.sh

# 3. Add Rubix to your PATH (optional: add to ~/.bashrc or ~/.zshrc)
export PATH="$HOME/.rubix/bin:$HOME/.local/bin:$PATH"
```

Verify your installation:

```bash
rubix -v
# Output: rubix 1.0.0 (x86_64-linux)

rubix doctor
# Output:
# Rubix toolchain diagnostics:
#   Lexer: OK
#   Parser: OK
#   Semantics: OK
#   Typechecker: OK
#   Optimizer: OK
#   Codegen: OK
#   Runtime: OK
#   Diagnostics: OK
# All subsystems operational.
```

---

## Creating Your First Project

The `rubix init` command scaffolds a complete project structure with build configuration:

```bash
# Create a new project named 'hello_rubix'
rubix init hello_rubix
cd hello_rubix
```

This creates the standard project layout:

```text
hello_rubix/
├── rubix.toml          # Project manifest and dependency declarations
├── src/
│   └── main.bix        # Application entry point
└── tests/              # Test suite directory
```

---

## Running and Building

### 1. Direct Execution (`rubix run`)
Compile and run your Rubix file in a single step without saving intermediate build files:

```bash
rubix run src/main.bix
```

### 2. Standalone Native Binary (`rubix build`)
Compile your application to an optimized, standalone native Linux ELF executable:

```bash
# Compiles to bin/hello_rubix
rubix build src/main.bix -o bin/hello_rubix

# Run the standalone binary directly
./bin/hello_rubix
```

### 3. Syntax & Type Checking (`rubix check`)
Quickly validate syntax and run full type inference without generating machine code:

```bash
rubix check src/main.bix
```

### 4. Code Formatting (`rubix fmt`)
Format source code deterministically to conform to official Rubix style guidelines:

```bash
rubix fmt src/main.bix
```

---

## Editor Support

Rubix provides syntax highlighting and Language Server Protocol (LSP) integrations for major editors located in the `editors/` directory:

- **VS Code**: Install the extension in `editors/vscode/`
- **Vim / Neovim**: Copy syntax files from `editors/vim/` to `~/.vim/`
- **Sublime Text**: Copy syntax definitions from `editors/sublime/`
