# Rubix Toolchain Reference

The `rubix` command-line tool provides a unified suite for compiling, running, checking, formatting, and packaging Rubix software.

---

## Command Overview

```text
rubix <command> [options]
```

### Core Commands

| Command | Usage | Description |
| :--- | :--- | :--- |
| **`run`** | `rubix run <file.bix>` | Compiles and executes a Rubix source file directly. |
| **`build`** | `rubix build <file.bix> [-o <out>]` | Compiles to a standalone native Linux ELF executable. |
| **`check`** | `rubix check <file.bix>` | Validates syntax and performs type checking without code generation. |
| **`fmt`** | `rubix fmt <file.bix>` | Formats source files according to standard Rubix style. |
| **`init`** | `rubix init <name>` | Initializes a new project directory with `rubix.toml`. |
| **`pkg`** | `rubix pkg <subcommand>` | Manages dependencies and project packaging. |
| **`repl`** | `rubix repl` | Starts an interactive Read-Eval-Print Loop. |
| **`doctor`** | `rubix doctor` | Checks and validates toolchain health and subsystem integrity. |
| **`lsp`** | `rubix lsp` | Starts the Language Server Protocol daemon over stdio. |
| **`version`** | `rubix version` / `rubix -v` | Displays the current Rubix version. |
| **`help`** | `rubix help` / `rubix -h` | Displays usage and command documentation. |

---

## Command Details

### 1. `rubix run`
Compiles to an in-memory or ephemeral native binary and executes it immediately:

```bash
rubix run examples/01_basics.bix
```

### 2. `rubix build`
Builds an optimized standalone binary:

```bash
# Default output (<input>.out)
rubix build src/main.bix

# Custom output binary path
rubix build src/main.bix -o bin/app

# Target specific architecture
rubix build src/main.bix -o bin/app --target x86_64-linux
```

### 3. `rubix check`
Performs static analysis, verifying that all types, variable bindings, and scopes are correct:

```bash
rubix check src/main.bix
```

### 4. `rubix fmt`
Formats Rubix code with standard 4-space indentation and clean spacing:

```bash
rubix fmt src/main.bix
```

### 5. `rubix doctor`
Verifies that all compiler subsystems (lexer, parser, analyzer, typechecker, optimizer, codegen, runtime) are fully operational:

```bash
rubix doctor
```
