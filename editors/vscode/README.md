# Rubix Language Support for Visual Studio Code & Cursor

Official extension for **Rubix 1.0.0** (`*.bix`), providing a complete IDE experience for high-performance systems development.

## Features

- **One-Click Run & Build Buttons**: Dedicated `▶ Run` and `📦 Build` buttons in the editor title bar.
- **On-Save Diagnostic Linter**: Automatically validates syntax and types on save, displaying inline red squigglies and populating the VS Code Problems panel.
- **On-Save & On-Demand Formatter**: Integrates with `rubix fmt` via `Shift + Alt + F` or Format Document.
- **Interactive Hover Documentation**: Rich type descriptions and code snippets when hovering over types (`Integer`, `String`, `Option[T]`, `Result[T, E]`), statements, and functions (`alloc`, `arena_reset`, `print`).
- **Rich Syntax Highlighting**: Accurate TextMate grammar for all Rubix constructs (`fn`, `def`, `let`, `mut`, `match`, `enum`, `type`, `loop`, `print`, `read_file`).
- **Dedicated File Icons**: Crisp vector file icon in the VS Code file explorer.
- **Auto-Closing & Bracket Matching**: Smart pairs for `{}`, `()`, `[]`, and `""`.
- **Productive Code Snippets**: Quick templates for `fn`, `mut`, `loop`, `type`, `enum`, and `match`.

## Shortcuts

| Shortcut | Action | Command |
| :--- | :--- | :--- |
| `Ctrl + Shift + R` | Run Active Rubix File | `rubix.run` |
| `Ctrl + Shift + B` | Build Standalone Native Binary | `rubix.build` |
| `Shift + Alt + F` | Format Document | `editor.action.formatDocument` |
| `Ctrl + /` | Toggle Line Comment (`#`) | `editor.action.commentLine` |

## Installation

Install directly via the VS Code CLI:
```bash
code --install-extension editors/vscode/rubix-lang-1.0.0.vsix --force
```

Or from within VS Code:
1. Open the Extensions view (`Ctrl + Shift + X`).
2. Click the `...` menu in the top right.
3. Select **Install from VSIX...** and choose `editors/vscode/rubix-lang-1.0.0.vsix`.
