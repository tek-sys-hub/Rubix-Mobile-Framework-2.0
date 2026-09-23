# Rubix Language Support for Visual Studio Code

Official VS Code extension for **Rubix 1.0.0** (`*.bix`), the high-performance, statically typed, expression-oriented systems programming language.

## Features

- **Rich Syntax Highlighting**: Accurate TextMate grammar for all Rubix 1.0.0 constructs (`fn`, `let`, `mut`, `match`, `enum`, `type`, `Option[T]`, `Result[T, E]`, `?`).
- **Dedicated `.bix` File Icon**: Crisp vector file icon in the VS Code file explorer.
- **Language Configuration**: Auto-closing braces/brackets, indentation rules, and comment toggling (`#`).
- **Productive Code Snippets**: Quick templates for functions (`fn`), types (`type`), sum type enums (`enum`), pattern matches (`match`), and loops (`loop`, `for`).
- **Integrated Toolchain Commands**:
  - `Rubix: Build Standalone Native Executable` (`rubix build`)
  - `Rubix: Run Active File` (`rubix run`)
  - `Rubix: Format Document` (`rubix fmt`)
  - `Rubix: Run Doctor Subsystem Health Check` (`rubix doctor`)

## Installation

```bash
# Package into VSIX
cd editors/vscode
npm run package # or code --install-extension rubix-lang-1.0.0.vsix
```
