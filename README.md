<div align="center">
  <img src="assets/rubix-logo.svg" width="140" height="140" alt="Rubix Logo" />
  <h1>The Rubix Programming Language</h1>
  <p><strong>A high-performance, statically typed, expression-oriented systems programming language.</strong></p>

  [![CI](https://github.com/tek-sys-hub/Rubix-Mobile-Framework-2.0/actions/workflows/ci.yml/badge.svg)](https://github.com/tek-sys-hub/Rubix-Mobile-Framework-2.0/actions)
  [![Release](https://img.shields.io/github/v/release/tek-sys-hub/Rubix-Mobile-Framework-2.0?color=blue)](https://github.com/tek-sys-hub/Rubix-Mobile-Framework-2.0/releases)
  [![VS Code Marketplace](https://img.shields.io/badge/VS%20Code%20Marketplace-Rubix%20Language-blue?logo=visual-studio-code)](https://marketplace.visualstudio.com/items?itemName=Rubix-lang-v10.rubix-language)
  [![Self-Hosting](https://img.shields.io/badge/Self--Hosting-Deterministic%20Convergence-blue.svg)]()
  [![Binary Size](https://img.shields.io/badge/Binary%20Size-15%20KB%20--%2083%20KB-orange.svg)]()
  [![License](https://img.shields.io/badge/License-MIT-purple.svg)](LICENSE)
</div>

---

## Highlights

- **Native AOT Compilation**: Compiles directly to standalone native Linux ELF executables with zero external runtime dependencies.
- **Null-Safe Type System**: Null pointers are unrepresentable; all optionality is explicit via `Option[T]` and `Result[T, E]`.
- **Expression-Oriented**: Blocks, conditionals, and matches evaluate directly to values.
- **Dynamic Scalable Arena Memory**: Dynamic kernel mmap scaling with sub-microsecond allocations and O(1) instant recycling.
- **Modern Concurrency**: Multithreading via kernel threads (`std.thread`), spin/futex mutexes, lock-free atomic integers, and channels.
- **C Interoperability**: Built-in Foreign Function Interface (`std.ffi`) for dynamic shared library loading.
- **All-in-One Toolchain**: Package initialization (`rubix init`), compiler (`rubix build`), runner (`rubix run`), formatter (`rubix fmt`), test runner (`rubix test`), and Language Server Protocol (`rubix lsp`).
- **Official VS Code & Cursor Extension**: Full IDE experience with title bar Run/Build buttons, on-save diagnostic linter, auto-formatter, and hover documentation.

---

## Performance & Language Comparison

Rubix combines the raw native execution speed of C/C++ with the memory safety of Rust and the instant compilation speed of Go, completely dependency-free without requiring `libc`.

| Metric / Category | Rubix | Rust (`rustc -O`) | C (`gcc -O3`) | C++ (`g++ -O3`) | Best in Class |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Allocation Speed** | ⚡ **1-2 ns** (bump allocator) | 🐢 15-40 ns (malloc / heap) | 🐢 15-50 ns (malloc / free) | 🐢 15-50 ns (`new` / heap) | 🏆 **Rubix** |
| **Raw Compute Loop** | 🚀 **3.7-7.7 B ops/s** | ⚡ 3.5-7.5 B ops/s | ⚡ 3.5-7.5 B ops/s | ⚡ 3.5-7.5 B ops/s | 🏆 **Rubix** |
| **Collatz (500k sequences)** | ⚡ **0.114 s** | ⚡ 0.105-0.120 s | ⚡ 0.100-0.115 s | ⚡ 0.100-0.115 s | 🏆 **Rubix / C** |
| **Standalone Binary Size** | 📦 **15 KB** (zero libc ELF) | 📦 300 KB - 3 MB | 📦 20 KB - 1 MB | 📦 100 KB - 5 MB | 🏆 **Rubix** |
| **Compilation Speed** | ⚡ **46-58 ms** (< 0.1s instant) | 🐢 1.2-3.5 s (LLVM lag) | 🚀 250-450 ms | 🐢 600-1800 ms | 🏆 **Rubix** |
| **External Dependencies** | 🛡️ **Zero** (direct kernel syscalls) | 🔗 Requires libc | 🔗 Requires libc | 🔗 Requires libstdc++ | 🏆 **Rubix** |
| **Source File Purity** | 💎 **100% Pure `.bix`** | 🦀 Pure `.rs` | 📄 `.c` | 📄 `.cpp` | 🏆 **Rubix** |
| **Memory Model** | ♾️ **Dynamic RAM + O(1) Reset** | 🛡️ Ownership / Borrowing | ⚠️ Manual `free()` | ⚠️ RAII / Smart Ptrs | 🏆 **Rubix / Rust** |
| **Self-Hosting Verification** | 🔒 **Bit-for-Bit Deterministic** | 🔒 Bootstrapped | 🔒 Bootstrapped | 🔒 Bootstrapped | 🏆 **All** |

### Verified Pure `.bix` Benchmarks

All benchmark sources are 100% pure `.bix` files in [`tests/benchmarks/`](tests/benchmarks/):

- **Raw Compute ([`bench_raw_compute.bix`](tests/benchmarks/bench_raw_compute.bix))**: 100,000,000 tight loop operations in **27 ms** (~**3.70 Billion ops/sec**).
- **Algorithmic Compute ([`bench_collatz.bix`](tests/benchmarks/bench_collatz.bix))**: 500,000 Collatz sequences (62,134,795 sequence steps) in **116 ms** (~**532 Million steps/sec**).
- **Memory Scalability ([`bench_memory_growth.bix`](tests/benchmarks/bench_memory_growth.bix))**: 110 MB dynamic kernel mmap allocation and instant recycling in **0.9 ms** (>**110 GB/s**).

Run the benchmarks locally:
```bash
rubix build tests/benchmarks/bench_raw_compute.bix -o bin/bench_raw && ./bin/bench_raw
rubix build tests/benchmarks/bench_collatz.bix -o bin/bench_collatz && time ./bin/bench_collatz
rubix build tests/benchmarks/bench_memory_growth.bix -o bin/bench_mem && ./bin/bench_mem
```

---

## Quickstart

### 1. Installation

#### Windows (PowerShell)
Run in PowerShell:
```powershell
irm https://raw.githubusercontent.com/tek-sys-hub/Rubix-Mobile-Framework-2.0/main/install.ps1 | iex
```

#### Linux / macOS
Run in your terminal:
```bash
curl -fsSL https://raw.githubusercontent.com/tek-sys-hub/Rubix-Mobile-Framework-2.0/main/install.sh | bash
```

#### Or Clone & Install from Source
```bash
# Clone repository
git clone https://github.com/tek-sys-hub/Rubix-Mobile-Framework-2.0.git rubix
cd rubix

# Linux bootstrap
bash scripts/selfhost.sh

# Or Windows setup
.\install.ps1
```

### 2. Run an Example

```bash
rubix run examples/01_basics.bix
```

### 3. Build a Standalone Native Executable

```bash
# Windows
rubix build examples/01_basics.bix -o bin/basics_app.exe
.\bin\basics_app.exe

# Linux
rubix build examples/01_basics.bix -o bin/basics_app
./bin/basics_app
```

---

## Editor Support (VS Code & Cursor)

The official **Rubix Language Support** extension provides full IDE capabilities:

- **Install via Marketplace**: Search `Rubix` in the VS Code Extensions tab (`Ctrl + Shift + X`).
- **Install from VSIX**:
  ```bash
  code --install-extension editors/vscode/rubix-lang-1.0.0.vsix --force
  ```
- **Features**:
  - `▶ Run` and `📦 Build` buttons in the editor title bar
  - On-save real-time diagnostic linter with inline red squiggly error highlights
  - Automated AST code formatter (`Shift + Alt + F`)
  - Interactive hover documentation for types, built-ins, and standard library methods
  - Keyboard shortcuts: `Ctrl + Shift + R` (Run) and `Ctrl + Shift + B` (Build)

---

## Documentation

Comprehensive guides are available in the [`docs/`](docs/) directory:

- 🚀 **[Getting Started](docs/getting-started.md)** - Installation, toolchain setup, and creating your first project.
- 📖 **[Language Guide](docs/language-guide.md)** - In-depth tour of syntax, `let` vs `mut`, types, functions, control flow, and pattern matching.
- 📚 **[Standard Library Reference](docs/standard-library.md)** - Full reference for `std.core`, `std.fs`, `std.thread`, `std.async`, `std.http`, `std.json`, and more.
- 🛠️ **[Toolchain Reference](docs/toolchain.md)** - Complete CLI commands and flag options (`run`, `build`, `check`, `fmt`, `pkg`, `doctor`, `lsp`).

---

## Runnable Examples

The [`examples/`](examples/) directory includes 7 clean, human-written examples:

1. **[01_basics.bix](examples/01_basics.bix)** - Variables, immutability (`let` vs `mut`), functions, and printing.
2. **[02_control_flow.bix](examples/02_control_flow.bix)** - `if`/`else` value expressions and while loops.
3. **[03_functions.bix](examples/03_functions.bix)** - Recursion, Fibonacci, and tail call accumulator loops.
4. **[04_algorithms.bix](examples/04_algorithms.bix)** - Greatest Common Divisor (GCD) and integer power.
5. **[05_collatz.bix](examples/05_collatz.bix)** - State tracking and sequence simulation ($3n + 1$).
6. **[06_primes.bix](examples/06_primes.bix)** - Helper functions and prime number search under 100.
7. **[07_binary_search.bix](examples/07_binary_search.bix)** - Binary powers and integer floor square roots.

Run any example with:
```bash
rubix run examples/01_basics.bix
```

---

## License

Rubix is released under the [MIT License](LICENSE).
