// Rubix Portable Runtime: Windows x64 Platform (runtime/platform/windows/sys_win64.s)
// 100% Pure Native Assembly Runtime for Windows x86_64 (Zero C Dependencies)
// Implements Microsoft x64 calling convention and direct Win32 kernel calls

.data
.globl g_argc
.globl g_argv
g_argc: .quad 0
g_argv: .quad 0

.section .bss
win_heap_base: .quad 0
win_heap_curr: .quad 0
win_heap_end:  .quad 0
win_static_pool: .space 16777216    // 16 MB static pool

.section .rdata,"dr"
.L_win_newline:
    .string "\n"
.L_win_empty:
    .string ""

.text

// ── Process Exit ─────────────────────────────────────────────────────────────
.globl rubix_rt_exit
rubix_rt_exit:
    subq $40, %rsp
    testq %rcx, %rcx
    cmovzq %rdi, %rcx
    call ExitProcess
    addq $40, %rsp
    ret

// ── String Length ────────────────────────────────────────────────────────────
.globl string_length
.globl rubix_rt_str_len
string_length:
rubix_rt_str_len:
    testq %rcx, %rcx
    cmovzq %rdi, %rcx
    testq %rcx, %rcx
    jz .L_win_strlen_zero
    movq %rcx, %rax
.L_win_strlen_loop:
    cmpb $0, (%rax)
    je .L_win_strlen_done
    incq %rax
    jmp .L_win_strlen_loop
.L_win_strlen_done:
    subq %rcx, %rax
    ret
.L_win_strlen_zero:
    xorq %rax, %rax
    ret

// ── String Equality ──────────────────────────────────────────────────────────
.globl string_eq
.globl rubix_rt_str_eq
string_eq:
rubix_rt_str_eq:
    testq %rcx, %rcx
    cmovzq %rdi, %rcx
    testq %rdx, %rdx
    cmovzq %rsi, %rdx
    cmpq %rcx, %rdx
    je .L_win_streq_true
    testq %rcx, %rcx
    jz .L_win_streq_false
    testq %rdx, %rdx
    jz .L_win_streq_false
.L_win_streq_loop:
    movb (%rcx), %al
    movb (%rdx), %r8b
    cmpb %r8b, %al
    jne .L_win_streq_false
    testb %al, %al
    jz .L_win_streq_true
    incq %rcx
    incq %rdx
    jmp .L_win_streq_loop
.L_win_streq_true:
    movq $1, %rax
    ret
.L_win_streq_false:
    xorq %rax, %rax
    ret

// ── Memory Allocation (Bump Allocator) ───────────────────────────────────────
.globl rubix_rt_init_heap
rubix_rt_init_heap:
    leaq win_static_pool(%rip), %rax
    movq %rax, win_heap_base(%rip)
    movq %rax, win_heap_curr(%rip)
    addq $16777216, %rax
    movq %rax, win_heap_end(%rip)
    ret

.globl rubix_rt_alloc
.globl alloc
rubix_rt_alloc:
alloc:
    testq %rcx, %rcx
    cmovzq %rdi, %rcx
    movq win_heap_curr(%rip), %rax
    testq %rax, %rax
    jnz .L_win_alloc_ready
    pushq %rcx
    subq $32, %rsp
    call rubix_rt_init_heap
    addq $32, %rsp
    popq %rcx
.L_win_alloc_ready:
    addq $15, %rcx
    andq $-16, %rcx
    movq win_heap_curr(%rip), %rax
    movq %rax, %rdx
    addq %rcx, %rdx
    cmpq win_heap_end(%rip), %rdx
    jae .L_win_alloc_oom
    movq %rdx, win_heap_curr(%rip)
    ret
.L_win_alloc_oom:
    xorq %rax, %rax
    ret

.globl rubix_rt_free
.globl free
rubix_rt_free:
free:
    ret

.globl rubix_rt_arena_reset
.globl arena_reset
rubix_rt_arena_reset:
arena_reset:
    movq win_heap_base(%rip), %rax
    movq %rax, win_heap_curr(%rip)
    ret

// ── String Concatenation ─────────────────────────────────────────────────────
.globl string_concat
.globl rubix_rt_str_concat
string_concat:
rubix_rt_str_concat:
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    subq $40, %rsp
    testq %rcx, %rcx
    cmovzq %rdi, %rcx
    testq %rdx, %rdx
    cmovzq %rsi, %rdx
    movq %rcx, %r12
    movq %rdx, %r13
    movq %r12, %rcx
    call string_length
    movq %rax, %r14
    movq %r13, %rcx
    call string_length
    movq %rax, %rbx
    leaq 1(%r14, %rbx), %rcx
    call alloc
    testq %rax, %rax
    jz .L_win_concat_done
    movq %rax, %rcx
    testq %r14, %r14
    jz .L_win_concat_copy_b
    movq %r12, %rsi
    movq %rcx, %rdi
    movq %r14, %r8
.L_win_concat_loop_a:
    movb (%rsi), %al
    movb %al, (%rdi)
    incq %rsi
    incq %rdi
    decq %r8
    jnz .L_win_concat_loop_a
.L_win_concat_copy_b:
    testq %rbx, %rbx
    jz .L_win_concat_term
    movq %r13, %rsi
    movq %rbx, %r8
.L_win_concat_loop_b:
    movb (%rsi), %al
    movb %al, (%rdi)
    incq %rsi
    incq %rdi
    decq %r8
    jnz .L_win_concat_loop_b
.L_win_concat_term:
    movb $0, (%rdi)
.L_win_concat_done:
    movq %rcx, %rax
    addq $40, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    ret

// ── Console Output via Win32 WriteFile ───────────────────────────────────────
.globl rubix_rt_print_str
.globl rubix_rt_print_poly
.globl print_poly
rubix_rt_print_str:
rubix_rt_print_poly:
print_poly:
    pushq %rbx
    pushq %rsi
    subq $56, %rsp
    testq %rcx, %rcx
    cmovzq %rdi, %rcx
    movq %rcx, %rbx
    call string_length
    movq %rax, %rsi
    movq $-11, %rcx     // STD_OUTPUT_HANDLE
    call GetStdHandle
    movq %rax, %rcx
    movq %rbx, %rdx
    movq %rsi, %r8
    leaq 40(%rsp), %r9
    movq $0, 32(%rsp)
    call WriteFile
    movq $-11, %rcx
    call GetStdHandle
    movq %rax, %rcx
    leaq .L_win_newline(%rip), %rdx
    movq $1, %r8
    leaq 40(%rsp), %r9
    movq $0, 32(%rsp)
    call WriteFile
    addq $56, %rsp
    popq %rsi
    popq %rbx
    ret

.globl rubix_rt_print_int
rubix_rt_print_int:
    pushq %rbx
    subq $80, %rsp
    testq %rcx, %rcx
    cmovzq %rdi, %rcx
    movq %rcx, %rax
    leaq 64(%rsp), %rsi
    movb $0, (%rsi)
    testq %rax, %rax
    jns .L_win_pos
    negq %rax
.L_win_pos:
    movq $10, %rbx
.L_win_int_loop:
    xorq %rdx, %rdx
    divq %rbx
    addb $48, %dl
    decq %rsi
    movb %dl, (%rsi)
    testq %rax, %rax
    jnz .L_win_int_loop
    testq %rcx, %rcx
    jns .L_win_print_int_buf
    decq %rsi
    movb $45, (%rsi)
.L_win_print_int_buf:
    movq %rsi, %rcx
    call rubix_rt_print_str
    addq $80, %rsp
    popq %rbx
    ret

// ── Application Entry Point ──────────────────────────────────────────────────
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    call rubix_rt_init_heap
    call rubix_main
    movq %rax, %rcx
    call ExitProcess
    movq %rbp, %rsp
    popq %rbp
    ret
