;; Rubix Portable Runtime: WebAssembly Platform (runtime/platform/wasm/sys_wasm.wat)
;; Implements runtime primitives for WebAssembly modules

(module
  ;; Memory
  (memory (export "memory") 2)

  ;; Environment imports
  (import "env" "rubix_print_str" (func $rubix_print_str (param i32 i32)))
  (import "env" "rubix_print_int" (func $rubix_print_int (param i32)))

  ;; String length helper
  (func $string_length (export "string_length") (param $ptr i32) (result i32)
    (local $len i32)
    (local.set $len (i32.const 0))
    (block $done
      (loop $scan
        (i32.load8_u (i32.add (local.get $ptr) (local.get $len)))
        (i32.eqz)
        (br_if $done)
        (local.set $len (i32.add (local.get $len) (i32.const 1)))
        (br $scan)
      )
    )
    (local.get $len)
  )

  ;; Memory bump allocator
  (global $heap_ptr (mut i32) (i32.const 65536))
  (func $rubix_rt_alloc (export "rubix_rt_alloc") (param $size i32) (result i32)
    (local $current i32)
    (local.set $current (global.get $heap_ptr))
    (global.set $heap_ptr (i32.add (local.get $current) (local.get $size)))
    (local.get $current)
  )
)
