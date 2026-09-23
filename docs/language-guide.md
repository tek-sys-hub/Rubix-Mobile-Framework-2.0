# Rubix Language Guide

This guide covers the core concepts, syntax, and features of the Rubix programming language.

---

## 1. Comments

Rubix uses `#` for single-line comments.

```rubix
# This is a comment in Rubix.
# Comments are ignored by the lexer and compiler.
```

---

## 2. Variables & Mutability

Rubix strictly distinguishes between **immutable constants** and **mutable variables**:

### Immutable Bindings (`let`)
Variables declared with `let` are immutable by default. Once initialized, their value cannot be changed:

```rubix
let language = "Rubix"
let year = 2026
let pi = 3.14159
```

### Mutable Variables (`mut`)
When you need a variable that can be updated (such as a counter or running accumulator), declare it with `mut`:

```rubix
mut counter = 0
counter = counter + 1
counter = counter + 10
```

---

## 3. Types

Rubix is statically typed with strong type inference.

### Primitive Types
- `Integer`: 64-bit signed integer (`i64`)
- `Float`: 64-bit IEEE-754 floating point (`f64`)
- `Boolean`: `true` or `false`
- `String`: UTF-8 heap-allocated immutable string
- `Void`: Empty type representing no return value (`()`)

### Type Annotations
While types are often inferred, you can explicitly annotate variables and parameters:

```rubix
let count: Integer = 42
let message: String = "Hello, World!"
let is_active: Boolean = true
```

---

## 4. Functions

Functions are declared using `fn` (or `def`), specifying parameters and return types:

```rubix
fn add(a: Integer, b: Integer): Integer {
    # The last expression in a block or function is returned automatically.
    a + b
}

fn greet(name: String): Void {
    print "Hello, " + name + "!"
}
```

### Main Entry Point
Every runnable program defines a `main` function returning an `Integer` exit code (`0` for success):

```rubix
fn main(): Integer {
    let sum = add(10, 25)
    print "Sum: " + int_to_string(sum)
    0
}
```

---

## 5. Control Flow

### If / Else Expressions
In Rubix, `if` statements are expressions that evaluate directly to a value:

```rubix
let score = 85
let grade = if score >= 90 {
    "A"
} else if score >= 80 {
    "B"
} else {
    "C"
}
```

### Loops
Rubix provides conditional `loop` constructs for iteration:

```rubix
mut i = 1
mut total = 0

loop i <= 100 {
    total = total + i
    i = i + 1
}

print "Sum 1..100 = " + int_to_string(total)
```

---

## 6. Structs & Custom Types

Custom data structures are defined using `type`:

```rubix
type Point {
    x: Integer,
    y: Integer
}

type User {
    id: Integer,
    username: String,
    is_admin: Boolean
}

fn create_point(x: Integer, y: Integer): Point {
    Point { x: x, y: y }
}
```

Fields can be accessed with dot notation:

```rubix
let pt = create_point(10, 20)
print "X: " + int_to_string(pt.x)
print "Y: " + int_to_string(pt.y)
```

---

## 7. Enums & Pattern Matching

Enums represent tagged union types that can carry data:

```rubix
enum Shape {
    Circle(radius: Integer),
    Rectangle(width: Integer, height: Integer)
}

fn describe_shape(s: Shape): String {
    match s {
        Circle(r) => "Circle with radius " + int_to_string(r),
        Rectangle(w, h) => "Rectangle " + int_to_string(w) + "x" + int_to_string(h),
        _ => "Unknown shape"
    }
}
```

---

## 8. Modules & Imports

Code is organized into modules and imported using the `use` statement:

```rubix
use std.core
use std.math
use std.fs

fn main(): Integer {
    let result = sqrt_int(144)
    print "sqrt(144) = " + int_to_string(result)
    0
}
```

---

## 9. Error Handling: Option & Result

Rubix does not have null pointer exceptions. All optionality and error recovery are handled explicitly through `Option[T]` and `Result[T, E]`:

```rubix
# Safe division returning Result
fn safe_divide(a: Integer, b: Integer): Result[Integer, String] {
    if b == 0 {
        Err("Cannot divide by zero")
    } else {
        Ok(a / b)
    }
}
```
