// Rubix Portable Runtime: Apple Silicon macOS AArch64 Platform (runtime/platform/arm64_macos/sys_darwin.s)
// Implements core runtime services and Mach-O calling conventions for macOS / iOS

.section __TEXT,__text,regular,pure_instructions
.p2align 2

.globl _sys_exit
_sys_exit:
    // macOS AArch64 exit syscall
    mov x16, #1
    svc #0x80
    ret

.globl _rubix_rt_exit
_rubix_rt_exit:
    mov x16, #1
    svc #0x80
    ret

.globl _string_length
.globl _rubix_rt_str_len
_string_length:
_rubix_rt_str_len:
    cbz x0, .L_macho_strlen_zero
    mov x1, x0
.L_macho_strlen_loop:
    ldrb w2, [x1], #1
    cbnz w2, .L_macho_strlen_loop
    sub x0, x1, x0
    sub x0, x0, #1
    ret
.L_macho_strlen_zero:
    mov x0, #0
    ret

.globl _rubix_rt_print_str
.globl _rubix_rt_print_poly
_rubix_rt_print_str:
_rubix_rt_print_poly:
    stp x29, x30, [sp, #-32]!
    mov x29, sp
    mov x19, x0
    bl _string_length
    mov x2, x0
    mov x1, x19
    mov x0, #1
    mov x16, #4
    svc #0x80
    adrp x1, .L_macho_newline@PAGE
    add x1, x1, .L_macho_newline@PAGEOFF
    mov x2, #1
    mov x0, #1
    mov x16, #4
    svc #0x80
    ldp x29, x30, [sp], #32
    ret

.section __TEXT,__cstring,cstring_literals
.L_macho_newline:
    .asciz "\n"
