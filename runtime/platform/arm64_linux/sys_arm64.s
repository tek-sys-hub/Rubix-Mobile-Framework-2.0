// Rubix Portable Runtime: Linux AArch64 Platform (runtime/platform/arm64_linux/sys_arm64.s)
// Implements core runtime services, memory allocation, and Linux AArch64 system calls

.arch armv8-a
.text

// ── Linux AArch64 Syscall Numbers ───────────────────────────────────────────
// sys_read:   63
// sys_write:  64
// sys_close:  57
// sys_exit:   93
// sys_brk:    214
// sys_mmap:   222

.section .text.sys_write, "ax", %progbits
.globl sys_write
.type sys_write, %function
sys_write:
    mov x8, #64
    svc #0
    ret

.section .text.sys_read, "ax", %progbits
.globl sys_read
.type sys_read, %function
sys_read:
    mov x8, #63
    svc #0
    ret

.section .text.sys_exit, "ax", %progbits
.globl sys_exit
.type sys_exit, %function
sys_exit:
    mov x8, #93
    svc #0
    ret

.section .text.rubix_rt_exit, "ax", %progbits
.globl rubix_rt_exit
.type rubix_rt_exit, %function
rubix_rt_exit:
    mov x8, #93
    svc #0
    ret

.section .text.string_length, "ax", %progbits
.globl string_length
.globl rubix_rt_str_len
.type string_length, %function
.type rubix_rt_str_len, %function
string_length:
rubix_rt_str_len:
    cbz x0, .L_strlen_zero
    mov x1, x0
.L_strlen_loop:
    ldrb w2, [x1], #1
    cbnz w2, .L_strlen_loop
    sub x0, x1, x0
    sub x0, x0, #1
    ret
.L_strlen_zero:
    mov x0, #0
    ret

.section .text.rubix_rt_print_str, "ax", %progbits
.globl rubix_rt_print_str
.globl rubix_rt_print_poly
.type rubix_rt_print_str, %function
.type rubix_rt_print_poly, %function
rubix_rt_print_str:
rubix_rt_print_poly:
    stp x29, x30, [sp, #-32]!
    mov x29, sp
    mov x19, x0
    bl string_length
    mov x2, x0
    mov x1, x19
    mov x0, #1
    mov x8, #64
    svc #0
    // write newline
    adr x1, .L_newline
    mov x2, #1
    mov x0, #1
    mov x8, #64
    svc #0
    ldp x29, x30, [sp], #32
    ret

.section .text.rubix_rt_print_int, "ax", %progbits
.globl rubix_rt_print_int
.type rubix_rt_print_int, %function
rubix_rt_print_int:
    stp x29, x30, [sp, #-64]!
    mov x29, sp
    mov x1, x0
    add x2, sp, #48
    mov w3, #10
    strb w3, [x2]
    mov x4, #1
    cmp x1, #0
    b.ge .L_pos_int
    neg x1, x1
    mov w5, #1
    b .L_conv_int
.L_pos_int:
    mov w5, #0
.L_conv_int:
.L_int_loop:
    mov x6, #10
    udiv x7, x1, x6
    msub x8, x7, x6, x1
    add w8, w8, #'0'
    sub x2, x2, #1
    strb w8, [x2]
    add x4, x4, #1
    mov x1, x7
    cbnz x1, .L_int_loop
    cbz w5, .L_print_int_buf
    sub x2, x2, #1
    mov w8, #'-'
    strb w8, [x2]
    add x4, x4, #1
.L_print_int_buf:
    mov x1, x2
    mov x2, x4
    mov x0, #1
    mov x8, #64
    svc #0
    ldp x29, x30, [sp], #64
    ret

.section .text.rubix_rt_alloc, "ax", %progbits
.globl rubix_rt_alloc
.globl alloc
.type rubix_rt_alloc, %function
.type alloc, %function
rubix_rt_alloc:
alloc:
    adrp x1, .L_heap_ptr
    add x1, x1, :lo12:.L_heap_ptr
    ldr x2, [x1]
    mov x0, x2
    add x2, x2, x0
    str x2, [x1]
    ret

.section .rodata
.L_newline:
    .ascii "\n"

.section .bss
.align 4
.L_heap_buf:
    .skip 65536

.section .data
.align 3
.L_heap_ptr:
    .quad .L_heap_buf

