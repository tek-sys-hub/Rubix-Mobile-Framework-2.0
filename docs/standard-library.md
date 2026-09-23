# Rubix Standard Library Reference

The Rubix Standard Library provides essential building blocks for systems, networking, file I/O, concurrency, and data manipulation.

---

## Modules Overview

| Module | Description |
| :--- | :--- |
| **`std.core`** | Fundamental types, assertions, identity functions, and pairs. |
| **`std.string`** | String manipulation, splitting, trimming, and searching. |
| **`std.math`** | Numeric algorithms, power, roots, GCD, and trigonometric routines. |
| **`std.matrix`** | 2D/3D matrix operations, dot products, and transformations. |
| **`std.collections`** | Dynamic lists (`Vec`), associative maps, and sets. |
| **`std.fs`** | File system operations, reading/writing files, path utilities. |
| **`std.thread`** | Multithreading via OS kernel threads, mutexes, and atomics. |
| **`std.async`** | Event loops, non-blocking I/O, and asynchronous tasks. |
| **`std.http`** | HTTP/1.1 client requests and high-performance server. |
| **`std.json`** | JSON parsing, validation, and serialization. |
| **`std.ffi`** | Foreign Function Interface for dynamic C shared libraries (`.so`). |

---

## 1. `std.core`
Fundamental utilities and testing assertions:

```rubix
use std.core

assert_eq_int(42, 42, "values must match")
assert_true(10 > 5, "condition check")
```

---

## 2. `std.fs`
File I/O and path manipulation:

```rubix
use std.fs

# Path utilities
let full_path = path_join("src", "main.bix")  # "src/main.bix"
let base = path_basename(full_path)           # "main.bix"
let ext = path_extension(full_path)           # ".bix"

# File operations
let content = fs_read_text("data.txt")
let write_ok = fs_write_text("output.txt", "Hello from Rubix!")
```

---

## 3. `std.math`
Arithmetic and mathematical algorithms:

```rubix
use std.math

let g = gcd(48, 18)        # 6
let p = power(2, 10)       # 1024
let r = sqrt_int(144)      # 12
let m = max(100, 250)      # 250
```

---

## 4. `std.thread`
Native multithreading and concurrency primitives:

```rubix
use std.thread

# Spawn worker thread
let t = thread_spawn(fn() {
    print "Worker thread running"
})

thread_join(t)
```

---

## 5. `std.http`
HTTP server and client capabilities:

```rubix
use std.http

# Start an HTTP server on port 8080
http_serve("0.0.0.0", 8080, fn(req: Request): Response {
    Response {
        status: 200,
        body: "Hello from Rubix Web Server!"
    }
})
```

---

## 6. `std.ffi`
Call external C libraries directly:

```rubix
use std.ffi

# Load libc and call standard functions
let handle = ffi_open("libc.so.6")
let puts_fn = ffi_symbol(handle, "puts")
```
