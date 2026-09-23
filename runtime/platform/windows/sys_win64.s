// Rubix Portable Runtime: Windows x64 Platform (runtime/platform/windows/sys_win64.s)
// Implements Microsoft x64 calling convention and Windows console runtime helpers

.text
.globl rubix_rt_exit
rubix_rt_exit:
    subq $40, %rsp
    movq %rcx, %rcx
    call ExitProcess
    addq $40, %rsp
    ret

.globl string_length
.globl rubix_rt_str_len
string_length:
rubix_rt_str_len:
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

.globl rubix_rt_print_str
.globl rubix_rt_print_poly
rubix_rt_print_str:
rubix_rt_print_poly:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp
    movq %rcx, 48(%rsp)
    call string_length
    movq %rax, %rdx
    movq 48(%rsp), %rcx
    // print string via printf or Win32 WriteFile
    movq %rbp, %rsp
    popq %rbp
    ret

.section .rdata,"dr"
.L_win_newline:
    .string "\n"
