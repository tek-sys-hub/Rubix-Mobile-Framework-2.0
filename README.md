<div align="center">
  <img src="assets/rubix-logo.svg" width="140" height="140" alt="Rubix Logo" />
  <h1>The Rubix Programming Language</h1>
  <p><strong>A high-performance, statically typed, expression-oriented systems programming language.</strong></p>

  [![CI](https://github.com/rubix-lang/rubix/actions/workflows/ci.yml/badge.svg)](https://github.com/rubix-lang/rubix/actions)
  [![Release](https://img.shields.io/github/v/release/rubix-lang/rubix?color=blue)](https://github.com/rubix-lang/rubix/releases)
  [![Self-Hosting](https://img.shields.io/badge/Self--Hosting-Deterministic%20Convergence-blue.svg)]()
  [![Binary Size](https://img.shields.io/badge/Binary%20Size-20%20KB%20--%2083%20KB-orange.svg)]()
  [![License](https://img.shields.io/badge/License-MIT-purple.svg)](LICENSE)
</div>

---

## Highlights

- **Native AOT Compilation**: Compiles directly to standalone native Linux ELF executables with zero external runtime dependencies.
- **Null-Safe Type System**: Null pointers are unrepresentable; all optionality is explicit via `Option[T]` and `Result[T, E]`.
- **Expression-Oriented**: Blocks, conditionals, and matches evaluate directly to values.
- **Zero-Pause Arena Memory**: Bounded 64 MB virtual memory arena pool eliminating garbage collection pauses and OOM lockups.
- **Modern Concurrency**: Multithreading via kernel threads (`std.thread`), spin/futex mutexes, lock-free atomic integers, and channels.
- **C Interoperability**: Built-in Foreign Function Interface (`std.ffi`) for dynamic shared library loading.
- **All-in-One Toolchain**: Package initialization (`rubix init`), compiler (`rubix build`), runner (`rubix run`), formatter (`rubix fmt`), test runner (`rubix test`), and Language Server Protocol (`rubix lsp`).

---

## Quickstart

```bash
# 1. Clone & bootstrap from source
git clone https://github.com/rubix-lang/rubix.git
cd rubix
bash scripts/selfhost.sh

# 2. Run an example
rubix run examples/01_basics.bix

# 3. Build a standalone native executable
rubix build examples/01_basics.bix -o bin/basics_app
./bin/basics_app
```

---

## Documentation

Comprehensive guides are available in the [`docs/`](docs/) directory:

- 🚀 **[Getting Started](docs/getting-started.md)** — Installation, toolchain setup, and creating your first project.
- 📖 **[Language Guide](docs/language-guide.md)** — In-depth tour of syntax, `let` vs `mut`, types, functions, control flow, and pattern matching.
- 📚 **[Standard Library Reference](docs/standard-library.md)** — Full reference for `std.core`, `std.fs`, `std.thread`, `std.async`, `std.http`, `std.json`, and more.
- 🛠️ **[Toolchain Reference](docs/toolchain.md)** — Complete CLI commands and flag options (`run`, `build`, `check`, `fmt`, `pkg`, `doctor`, `lsp`).

---

## Runnable Examples

The [`examples/`](examples/) directory includes 7 clean, human-written examples:

1. **[01_basics.bix](examples/01_basics.bix)** — Variables, immutability (`let` vs `mut`), functions, and printing.
2. **[02_control_flow.bix](examples/02_control_flow.bix)** — `if`/`else` value expressions and while loops.
3. **[03_functions.bix](examples/03_functions.bix)** — Recursion, Fibonacci, and tail call accumulator loops.
4. **[04_algorithms.bix](examples/04_algorithms.bix)** — Greatest Common Divisor (GCD) and integer power.
5. **[05_collatz.bix](examples/05_collatz.bix)** — State tracking and sequence simulation ($3n + 1$).
6. **[06_primes.bix](examples/06_primes.bix)** — Helper functions and prime number search under 100.
7. **[07_binary_search.bix](examples/07_binary_search.bix)** — Binary powers and integer floor square roots.

Run any example with:
```bash
rubix run examples/01_basics.bix
```

---

## License

Rubix is released under the [MIT License](LICENSE).
