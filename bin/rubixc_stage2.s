    .text
    .globl rubix_main

.globl init_lexer
.type init_lexer, @function
init_lexer:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq $40, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq -8(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq $1, %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq $1, %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    movq -8(%rbp), %rax
    movq %rax, %rdi
    call rubix_rt_poly_len
    movq (%rsp), %rbx
    movq %rax, 32(%rbx)
    popq %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl is_digit
.type is_digit, @function
is_digit:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $48, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setge %al
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    movq $57, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setle %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl is_alpha
.type is_alpha, @function
is_alpha:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $65, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setge %al
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    movq $90, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setle %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    movq $97, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setge %al
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    movq $122, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setle %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    movq $95, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl is_alphanumeric
.type is_alphanumeric, @function
is_alphanumeric:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call is_alpha
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call is_digit
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl peek
.type peek, @function
peek:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 32(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setge %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_1
    movq $0, %rax
    jmp .L_end_2
.L_else_1:
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rsi
    popq %rdi
    call rubix_rt_str_byte_at
.L_end_2:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl advance
.type advance, @function
advance:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 32(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setge %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_3
    movq $0, %rax
    jmp .L_end_4
.L_else_3:
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rsi
    popq %rdi
    call rubix_rt_str_byte_at
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 8(%rax)
    movq -16(%rbp), %rax
    pushq %rax
    movq $10, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_5
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 16(%rax)
    movq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 24(%rax)
    jmp .L_end_6
.L_else_5:
    movq -8(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 24(%rax)
.L_end_6:
    movq -16(%rbp), %rax
.L_end_4:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl skip_whitespace
.type skip_whitespace, @function
skip_whitespace:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq $0, %rax
    movq %rax, -16(%rbp)
.L_loop_start_7:
    movq -16(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_8
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq $32, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $9, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $10, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $13, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_9
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    jmp .L_end_10
.L_else_9:
    movq -24(%rbp), %rax
    pushq %rax
    movq $35, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_11
.L_loop_start_13:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 32(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setl %al
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    movq $10, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_14
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    jmp .L_loop_start_13
.L_loop_end_14:
    jmp .L_end_12
.L_else_11:
    movq $1, %rax
    movq %rax, -16(%rbp)
.L_end_12:
.L_end_10:
    jmp .L_loop_start_7
.L_loop_end_8:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl is_keyword
.type is_keyword, @function
is_keyword:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_0(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_1(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_2(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_3(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_4(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_5(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_6(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_7(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_8(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_9(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_10(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_11(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_12(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_13(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_14(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_15(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_16(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_15
    movq $1, %rax
    jmp .L_end_16
.L_else_15:
    movq $0, %rax
.L_end_16:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl scan_identifier_or_keyword
.type scan_identifier_or_keyword, @function
scan_identifier_or_keyword:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -32(%rbp)
.L_loop_start_17:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    popq %rdi
    call is_alphanumeric
    cmpq $0, %rax
    je .L_loop_end_18
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    jmp .L_loop_start_17
.L_loop_end_18:
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rdx
    popq %rsi
    popq %rdi
    call rubix_rt_str_substring
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    popq %rdi
    call is_keyword
    cmpq $0, %rax
    je .L_else_19
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $1, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq -40(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_20
.L_else_19:
    movq -40(%rbp), %rax
    pushq %rax
    leaq .LC_str_18(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    leaq .LC_str_19(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    leaq .LC_str_20(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_21
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq -40(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_22
.L_else_21:
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $2, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq -40(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_22:
.L_end_20:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl scan_number
.type scan_number, @function
scan_number:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -32(%rbp)
.L_loop_start_23:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    popq %rdi
    call is_digit
    cmpq $0, %rax
    je .L_loop_end_24
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    jmp .L_loop_start_23
.L_loop_end_24:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    movq $46, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rsi
    popq %rdi
    call rubix_rt_str_byte_at
    pushq %rax
    popq %rdi
    call is_digit
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_25
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
.L_loop_start_27:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    popq %rdi
    call is_digit
    cmpq $0, %rax
    je .L_loop_end_28
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    jmp .L_loop_start_27
.L_loop_end_28:
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rdx
    popq %rsi
    popq %rdi
    call rubix_rt_str_substring
    movq %rax, -48(%rbp)
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $4, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq -48(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_26
.L_else_25:
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rdx
    popq %rsi
    popq %rdi
    call rubix_rt_str_substring
    movq %rax, -56(%rbp)
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $3, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq -56(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_26:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl scan_string
.type scan_string, @function
scan_string:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -32(%rbp)
    movq $0, %rax
    movq %rax, -40(%rbp)
    movq $0, %rax
    movq %rax, -48(%rbp)
.L_loop_start_29:
    movq -40(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_30
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_31
    movq $1, %rax
    movq %rax, -40(%rbp)
    jmp .L_end_32
.L_else_31:
    movq -56(%rbp), %rax
    pushq %rax
    movq $34, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_33
    movq $1, %rax
    movq %rax, -48(%rbp)
    movq $1, %rax
    movq %rax, -40(%rbp)
    jmp .L_end_34
.L_else_33:
    movq -56(%rbp), %rax
    pushq %rax
    movq $92, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_35
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    jmp .L_end_36
.L_else_35:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
.L_end_36:
.L_end_34:
.L_end_32:
    jmp .L_loop_start_29
.L_loop_end_30:
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rdx
    popq %rsi
    popq %rdi
    call rubix_rt_str_substring
    movq %rax, -64(%rbp)
    movq -48(%rbp), %rax
    cmpq $0, %rax
    je .L_else_37
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $5, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq -64(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_38
.L_else_37:
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $9, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_21(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_38:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl scan_operator_or_punctuation
.type scan_operator_or_punctuation, @function
scan_operator_or_punctuation:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    movq $61, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_39
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    movq $61, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_41
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_22(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_42
.L_else_41:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    movq $62, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_43
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_23(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_44
.L_else_43:
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_24(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_44:
.L_end_42:
    jmp .L_end_40
.L_else_39:
    movq -32(%rbp), %rax
    pushq %rax
    movq $58, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_45
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    movq $61, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_47
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_25(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_48
.L_else_47:
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $7, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_26(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_48:
    jmp .L_end_46
.L_else_45:
    movq -32(%rbp), %rax
    pushq %rax
    movq $33, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_49
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    movq $61, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_51
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_27(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_52
.L_else_51:
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_28(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_52:
    jmp .L_end_50
.L_else_49:
    movq -32(%rbp), %rax
    pushq %rax
    movq $60, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_53
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    movq $61, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_55
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_29(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_56
.L_else_55:
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_30(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_56:
    jmp .L_end_54
.L_else_53:
    movq -32(%rbp), %rax
    pushq %rax
    movq $62, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_57
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    movq $61, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_59
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_31(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_60
.L_else_59:
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_32(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_60:
    jmp .L_end_58
.L_else_57:
    movq -32(%rbp), %rax
    pushq %rax
    movq $43, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_61
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_33(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_62
.L_else_61:
    movq -32(%rbp), %rax
    pushq %rax
    movq $45, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_63
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    movq $62, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_65
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_34(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_66
.L_else_65:
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_35(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_66:
    jmp .L_end_64
.L_else_63:
    movq -32(%rbp), %rax
    pushq %rax
    movq $42, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_67
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_36(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_68
.L_else_67:
    movq -32(%rbp), %rax
    pushq %rax
    movq $47, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_69
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_37(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_70
.L_else_69:
    movq -32(%rbp), %rax
    pushq %rax
    movq $37, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_71
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_38(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_72
.L_else_71:
    movq -32(%rbp), %rax
    pushq %rax
    movq $63, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_73
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_39(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_74
.L_else_73:
    movq -32(%rbp), %rax
    pushq %rax
    movq $40, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_75
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $7, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_40(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_76
.L_else_75:
    movq -32(%rbp), %rax
    pushq %rax
    movq $41, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_77
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $7, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_41(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_78
.L_else_77:
    movq -32(%rbp), %rax
    pushq %rax
    movq $123, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_79
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $7, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_42(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_80
.L_else_79:
    movq -32(%rbp), %rax
    pushq %rax
    movq $125, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_81
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $7, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_43(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_82
.L_else_81:
    movq -32(%rbp), %rax
    pushq %rax
    movq $91, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_83
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $7, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_44(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_84
.L_else_83:
    movq -32(%rbp), %rax
    pushq %rax
    movq $93, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_85
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $7, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_45(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_86
.L_else_85:
    movq -32(%rbp), %rax
    pushq %rax
    movq $44, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_87
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $7, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_46(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_88
.L_else_87:
    movq -32(%rbp), %rax
    pushq %rax
    movq $46, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_89
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    pushq %rax
    movq $46, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_91
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $6, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_47(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_92
.L_else_91:
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $7, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_48(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_92:
    jmp .L_end_90
.L_else_89:
    movq -32(%rbp), %rax
    pushq %rax
    movq $59, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_93
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $7, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_49(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_94
.L_else_93:
    movq -32(%rbp), %rax
    pushq %rax
    movq $95, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_95
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $2, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_50(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_96
.L_else_95:
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $9, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_51(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
.L_end_96:
.L_end_94:
.L_end_90:
.L_end_88:
.L_end_86:
.L_end_84:
.L_end_82:
.L_end_80:
.L_end_78:
.L_end_76:
.L_end_74:
.L_end_72:
.L_end_70:
.L_end_68:
.L_end_64:
.L_end_62:
.L_end_58:
.L_end_54:
.L_end_50:
.L_end_46:
.L_end_40:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl next_token
.type next_token, @function
next_token:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call skip_whitespace
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    movq 24(%rax), %rax
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 32(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setge %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_97
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $8, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_52(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    jmp .L_end_98
.L_else_97:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call peek
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    popq %rdi
    call is_alpha
    cmpq $0, %rax
    je .L_else_99
    movq -8(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call scan_identifier_or_keyword
    jmp .L_end_100
.L_else_99:
    movq -32(%rbp), %rax
    pushq %rax
    popq %rdi
    call is_digit
    cmpq $0, %rax
    je .L_else_101
    movq -8(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call scan_number
    jmp .L_end_102
.L_else_101:
    movq -32(%rbp), %rax
    pushq %rax
    movq $34, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_103
    movq -8(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call scan_string
    jmp .L_end_104
.L_else_103:
    movq -8(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call scan_operator_or_punctuation
.L_end_104:
.L_end_102:
.L_end_100:
.L_end_98:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl create_node
.type create_node, @function
create_node:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call node_new
    movq %rbp, %rsp
    popq %rbp
    ret

.globl get_node_kind
.type get_node_kind, @function
get_node_kind:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call node_kind
    movq %rbp, %rsp
    popq %rbp
    ret

.globl get_node_text
.type get_node_text, @function
get_node_text:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call node_text
    movq %rbp, %rsp
    popq %rbp
    ret

.globl get_node_line
.type get_node_line, @function
get_node_line:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call node_line
    movq %rbp, %rsp
    popq %rbp
    ret

.globl get_node_col
.type get_node_col, @function
get_node_col:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call node_col
    movq %rbp, %rsp
    popq %rbp
    ret

.globl get_node_child
.type get_node_child, @function
get_node_child:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call node_child
    movq %rbp, %rsp
    popq %rbp
    ret

.globl get_node_sibling
.type get_node_sibling, @function
get_node_sibling:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call node_sibling
    movq %rbp, %rsp
    popq %rbp
    ret

.globl add_child
.type add_child, @function
add_child:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_105
    movq -8(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call node_add_child
    jmp .L_end_106
.L_else_105:
.L_end_106:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl set_node_type
.type set_node_type, @function
set_node_type:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_107
    movq -8(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call node_set_type
    jmp .L_end_108
.L_else_107:
.L_end_108:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl get_node_type
.type get_node_type, @function
get_node_type:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_109
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call node_get_type
    jmp .L_end_110
.L_else_109:
    movq $0, %rax
.L_end_110:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl get_total_node_count
.type get_total_node_count, @function
get_total_node_count:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    call node_count
    movq %rbp, %rsp
    popq %rbp
    ret

.globl advance_parser
.type advance_parser, @function
advance_parser:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 8(%rax)
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    popq %rdi
    call next_token
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 16(%rax)
    movq %rbp, %rsp
    popq %rbp
    ret

.globl init_parser
.type init_parser, @function
init_parser:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_52(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    movq %rax, -24(%rbp)
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_52(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    movq %rax, -32(%rbp)
    movq $40, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq -8(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -32(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 32(%rbx)
    popq %rax
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -40(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -40(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parser_error
.type parser_error, @function
parser_error:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    leaq .LC_str_53(%rip), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_54(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 32(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_26(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 16(%rax), %rax
    movq %rax, %rdi
    call rubix_rt_int_to_str
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_26(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 24(%rax), %rax
    movq %rax, %rdi
    call rubix_rt_int_to_str
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_55(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq -8(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 24(%rax)
    movq %rbp, %rsp
    popq %rbp
    ret

.globl match_kind
.type match_kind, @function
match_kind:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_111
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $1, %rax
    jmp .L_end_112
.L_else_111:
    movq $0, %rax
.L_end_112:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl expect_kind
.type expect_kind, @function
expect_kind:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_113
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $1, %rax
    jmp .L_end_114
.L_else_113:
    movq -8(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parser_error
    movq $0, %rax
.L_end_114:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl expect_keyword
.type expect_keyword, @function
expect_keyword:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_115
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $1, %rax
    jmp .L_end_116
.L_else_115:
    movq -8(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parser_error
    movq $0, %rax
.L_end_116:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl get_precedence
.type get_precedence, @function
get_precedence:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $6, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_117
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_19(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_119
    movq $10, %rax
    jmp .L_end_120
.L_else_119:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_18(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_121
    movq $15, %rax
    jmp .L_end_122
.L_else_121:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_22(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_27(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_123
    movq $20, %rax
    jmp .L_end_124
.L_else_123:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_30(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_32(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_29(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_31(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_125
    movq $30, %rax
    jmp .L_end_126
.L_else_125:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_47(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_127
    movq $35, %rax
    jmp .L_end_128
.L_else_127:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_33(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_35(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_129
    movq $40, %rax
    jmp .L_end_130
.L_else_129:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_36(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_37(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_38(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_131
    movq $50, %rax
    jmp .L_end_132
.L_else_131:
    movq $0, %rax
.L_end_132:
.L_end_130:
.L_end_128:
.L_end_126:
.L_end_124:
.L_end_122:
.L_end_120:
    jmp .L_end_118
.L_else_117:
    movq $0, %rax
.L_end_118:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_expression
.type parse_expression, @function
parse_expression:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_prefix
    movq %rax, -24(%rbp)
    movq $0, %rax
    movq %rax, -32(%rbp)
.L_loop_start_133:
    movq -32(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_134
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rdi
    call get_precedence
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_135
    movq -8(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_infix
    movq %rax, -24(%rbp)
    jmp .L_end_136
.L_else_135:
    movq $1, %rax
    movq %rax, -32(%rbp)
.L_end_136:
    jmp .L_loop_start_133
.L_loop_end_134:
    movq -24(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_prefix
.type parse_prefix, @function
parse_prefix:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $3, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_137
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $9, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    movq -24(%rbp), %rax
    jmp .L_end_138
.L_else_137:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $4, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_139
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $9, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    movq $3, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    movq -32(%rbp), %rax
    jmp .L_end_140
.L_else_139:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_141
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $9, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    movq $5, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    movq -40(%rbp), %rax
    jmp .L_end_142
.L_else_141:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_14(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_15(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_143
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $9, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    movq $4, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    movq -48(%rbp), %rax
    jmp .L_end_144
.L_else_143:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_7(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_145
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_if
    jmp .L_end_146
.L_else_145:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_6(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_147
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_match
    jmp .L_end_148
.L_else_147:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_149
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $8, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -56(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_postfix
    jmp .L_end_150
.L_else_149:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $6, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_35(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $6, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_20(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_28(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_151
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    pushq %rax
    movq $60, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -64(%rbp)
    movq $10, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -72(%rbp)
    movq -72(%rbp), %rax
    pushq %rax
    movq -64(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -72(%rbp), %rax
    jmp .L_end_152
.L_else_151:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_40(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_153
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -80(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_56(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -80(%rbp), %rax
    jmp .L_end_154
.L_else_153:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_44(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_155
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $29, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_57(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -88(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_45(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_157
.L_loop_start_159:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_45(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_160
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -96(%rbp)
    movq -88(%rbp), %rax
    pushq %rax
    movq -96(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_161
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_162
.L_else_161:
.L_end_162:
    jmp .L_loop_start_159
.L_loop_end_160:
    jmp .L_end_158
.L_else_157:
.L_end_158:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_58(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -88(%rbp), %rax
    jmp .L_end_156
.L_else_155:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_0(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_1(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_163
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $25, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_59(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -104(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_60(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_41(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_165
    movq $0, %rax
    movq %rax, -112(%rbp)
.L_loop_start_167:
    movq -112(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_168
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -120(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_61(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $13, %rax
    pushq %rax
    movq -120(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -120(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -120(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -128(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_26(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_169
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -136(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_62(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    jmp .L_end_170
.L_else_169:
.L_end_170:
    movq -104(%rbp), %rax
    pushq %rax
    movq -128(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_171
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_172
.L_else_171:
    movq $1, %rax
    movq %rax, -112(%rbp)
.L_end_172:
    jmp .L_loop_start_167
.L_loop_end_168:
    jmp .L_end_166
.L_else_165:
.L_end_166:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_63(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $6, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_23(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_173
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -144(%rbp)
    movq -104(%rbp), %rax
    pushq %rax
    movq -144(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_174
.L_else_173:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_block
    movq %rax, -152(%rbp)
    movq -104(%rbp), %rax
    pushq %rax
    movq -152(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
.L_end_174:
    movq -104(%rbp), %rax
    jmp .L_end_164
.L_else_163:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_42(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_175
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_block
    jmp .L_end_176
.L_else_175:
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_64(%rip), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    popq %rsi
    popq %rdi
    call parser_error
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $0, %rax
.L_end_176:
.L_end_164:
.L_end_156:
.L_end_154:
.L_end_152:
.L_end_150:
.L_end_148:
.L_end_146:
.L_end_144:
.L_end_142:
.L_end_140:
.L_end_138:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_postfix
.type parse_postfix, @function
parse_postfix:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    movq $0, %rax
    movq %rax, -32(%rbp)
.L_loop_start_177:
    movq -32(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_178
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_40(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_179
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -40(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $15, %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_65(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_41(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_181
    movq $0, %rax
    movq %rax, -56(%rbp)
.L_loop_start_183:
    movq -56(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_184
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -64(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    movq -64(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_185
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_186
.L_else_185:
    movq $1, %rax
    movq %rax, -56(%rbp)
.L_end_186:
    jmp .L_loop_start_183
.L_loop_end_184:
    jmp .L_end_182
.L_else_181:
.L_end_182:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_66(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -48(%rbp), %rax
    movq %rax, -24(%rbp)
    jmp .L_end_180
.L_else_179:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_42(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_text
    movq %rax, %rdi
    call rubix_rt_poly_len
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_text
    pushq %rax
    movq $0, %rax
    movq %rax, %rsi
    popq %rdi
    call rubix_rt_str_byte_at
    pushq %rax
    movq $65, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setge %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_text
    pushq %rax
    movq $0, %rax
    movq %rax, %rsi
    popq %rdi
    call rubix_rt_str_byte_at
    pushq %rax
    movq $90, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setle %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_187
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -72(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_text
    movq %rax, -80(%rbp)
    movq $16, %rax
    pushq %rax
    movq -72(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -72(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -80(%rbp), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -88(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_43(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_189
    movq $0, %rax
    movq %rax, -96(%rbp)
.L_loop_start_191:
    movq -96(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_192
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_43(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_193
    movq $1, %rax
    movq %rax, -96(%rbp)
    jmp .L_end_194
.L_else_193:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -104(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_67(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_68(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -112(%rbp)
    movq $6, %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -120(%rbp)
    movq -120(%rbp), %rax
    pushq %rax
    movq -112(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -88(%rbp), %rax
    pushq %rax
    movq -120(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_195
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_196
.L_else_195:
    movq $1, %rax
    movq %rax, -96(%rbp)
.L_end_196:
.L_end_194:
    jmp .L_loop_start_191
.L_loop_end_192:
    jmp .L_end_190
.L_else_189:
.L_end_190:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_69(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -88(%rbp), %rax
    movq %rax, -24(%rbp)
    jmp .L_end_188
.L_else_187:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_44(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_197
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -128(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -136(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_70(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $27, %rax
    pushq %rax
    movq -128(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -128(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_71(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -144(%rbp)
    movq -144(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -144(%rbp), %rax
    pushq %rax
    movq -136(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -144(%rbp), %rax
    movq %rax, -24(%rbp)
    jmp .L_end_198
.L_else_197:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_48(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_199
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -152(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_72(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $17, %rax
    pushq %rax
    movq -152(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -152(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -152(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -160(%rbp)
    movq -160(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -160(%rbp), %rax
    movq %rax, -24(%rbp)
    jmp .L_end_200
.L_else_199:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $6, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_39(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_201
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -168(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $26, %rax
    pushq %rax
    movq -168(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -168(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_39(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -176(%rbp)
    movq -176(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -176(%rbp), %rax
    movq %rax, -24(%rbp)
    jmp .L_end_202
.L_else_201:
    movq $1, %rax
    movq %rax, -32(%rbp)
.L_end_202:
.L_end_200:
.L_end_198:
.L_end_188:
.L_end_180:
    jmp .L_loop_start_177
.L_loop_end_178:
    movq -24(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_infix
.type parse_infix, @function
parse_infix:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_precedence
    movq %rax, -32(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -40(%rbp)
    movq -24(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_47(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_203
    movq $28, %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_47(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -48(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -48(%rbp), %rax
    jmp .L_end_204
.L_else_203:
    movq $7, %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -56(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -56(%rbp), %rax
.L_end_204:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_statement
.type parse_statement, @function
parse_statement:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_2(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_205
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_73(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $0, %rax
    movq %rax, -32(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_26(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_207
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -40(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_62(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $14, %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -32(%rbp)
    jmp .L_end_208
.L_else_207:
.L_end_208:
    movq -8(%rbp), %rax
    pushq %rax
    movq $6, %rax
    pushq %rax
    leaq .LC_str_74(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -48(%rbp)
    movq $20, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -56(%rbp)
    movq $8, %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -64(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_209
    movq -64(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_210
.L_else_209:
.L_end_210:
    movq -56(%rbp), %rax
    pushq %rax
    movq -64(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -56(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -56(%rbp), %rax
    jmp .L_end_206
.L_else_205:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_3(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_211
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -72(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_75(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $0, %rax
    movq %rax, -80(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_26(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_213
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -88(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_62(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $14, %rax
    pushq %rax
    movq -88(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -88(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -88(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -80(%rbp)
    jmp .L_end_214
.L_else_213:
.L_end_214:
    movq -8(%rbp), %rax
    pushq %rax
    movq $6, %rax
    pushq %rax
    leaq .LC_str_76(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -96(%rbp)
    movq $21, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -72(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -104(%rbp)
    movq $8, %rax
    pushq %rax
    movq -72(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -72(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -72(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -112(%rbp)
    movq -80(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_215
    movq -112(%rbp), %rax
    pushq %rax
    movq -80(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_216
.L_else_215:
.L_end_216:
    movq -104(%rbp), %rax
    pushq %rax
    movq -112(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -104(%rbp), %rax
    pushq %rax
    movq -96(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -104(%rbp), %rax
    jmp .L_end_212
.L_else_211:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_13(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_217
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $19, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_13(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -120(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_43(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_219
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_8(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_221
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -128(%rbp)
    movq -120(%rbp), %rax
    pushq %rax
    movq -128(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_222
.L_else_221:
.L_end_222:
    jmp .L_end_220
.L_else_219:
.L_end_220:
    movq -120(%rbp), %rax
    jmp .L_end_218
.L_else_217:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_7(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_223
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_if
    jmp .L_end_224
.L_else_223:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_6(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_225
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_match
    jmp .L_end_226
.L_else_225:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_9(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_227
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_for
    jmp .L_end_228
.L_else_227:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_11(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_229
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_loop
    jmp .L_end_230
.L_else_229:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_0(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_1(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_231
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_40(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_233
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    jmp .L_end_234
.L_else_233:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_function
.L_end_234:
    jmp .L_end_232
.L_else_231:
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -136(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $6, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_24(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_25(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_235
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -144(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -152(%rbp)
    movq $6, %rax
    pushq %rax
    movq -144(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -144(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -144(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -160(%rbp)
    movq -160(%rbp), %rax
    pushq %rax
    movq -136(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -160(%rbp), %rax
    pushq %rax
    movq -152(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -160(%rbp), %rax
    jmp .L_end_236
.L_else_235:
    movq -136(%rbp), %rax
.L_end_236:
.L_end_232:
.L_end_230:
.L_end_228:
.L_end_226:
.L_end_224:
.L_end_218:
.L_end_212:
.L_end_206:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_block
.type parse_block, @function
parse_block:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_42(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_237
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $3, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_77(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -24(%rbp)
.L_loop_start_239:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_43(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_240
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_statement
    movq %rax, -32(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_49(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_241
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_242
.L_else_241:
.L_end_242:
    jmp .L_loop_start_239
.L_loop_end_240:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_78(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -24(%rbp), %rax
    jmp .L_end_238
.L_else_237:
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_16(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_243
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $3, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_77(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -40(%rbp)
.L_loop_start_245:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_8(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_246
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_statement
    movq %rax, -48(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_loop_start_245
.L_loop_end_246:
    movq -40(%rbp), %rax
    jmp .L_end_244
.L_else_243:
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_79(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parser_error
    movq $0, %rax
.L_end_244:
.L_end_238:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_if
.type parse_if, @function
parse_if:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_16(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_247
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_248
.L_else_247:
.L_end_248:
    movq $4, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_7(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq $3, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_77(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -40(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_42(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_249
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_block
    movq %rax, -40(%rbp)
    jmp .L_end_250
.L_else_249:
.L_loop_start_251:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_8(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_252
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_statement
    movq %rax, -48(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_loop_start_251
.L_loop_end_252:
.L_end_250:
    movq -32(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_8(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_253
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $3, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_77(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -56(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_7(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_255
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_if
    movq %rax, -64(%rbp)
    movq -56(%rbp), %rax
    pushq %rax
    movq -64(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -32(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -32(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_256
.L_else_255:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_42(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_257
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_block
    movq %rax, -56(%rbp)
    jmp .L_end_258
.L_else_257:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_16(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_259
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_loop_start_261:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_262
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_statement
    movq %rax, -72(%rbp)
    movq -56(%rbp), %rax
    pushq %rax
    movq -72(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_loop_start_261
.L_loop_end_262:
    jmp .L_end_260
.L_else_259:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_statement
    movq %rax, -80(%rbp)
    movq -56(%rbp), %rax
    pushq %rax
    movq -80(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
.L_end_260:
.L_end_258:
.L_end_256:
    movq -32(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_254
.L_else_253:
.L_end_254:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_263
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_264
.L_else_263:
.L_end_264:
    movq -32(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_match
.type parse_match, @function
parse_match:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_80(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $11, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_6(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
.L_loop_start_265:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_43(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_266
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -40(%rbp)
    movq $0, %rax
    movq %rax, -48(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_50(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_267
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $8, %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_50(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -48(%rbp)
    jmp .L_end_268
.L_else_267:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_269
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    movq %rax, -56(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $8, %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -48(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_40(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_271
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_loop_start_273:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_41(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_274
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_275
    movq $8, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -64(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    movq -64(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_277
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_278
.L_else_277:
.L_end_278:
    jmp .L_end_276
.L_else_275:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_end_276:
    jmp .L_loop_start_273
.L_loop_end_274:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_81(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    jmp .L_end_272
.L_else_271:
.L_end_272:
    jmp .L_end_270
.L_else_269:
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -48(%rbp)
.L_end_270:
.L_end_268:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $6, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_23(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_279
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_280
.L_else_279:
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_82(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parser_error
.L_end_280:
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -72(%rbp)
    movq $12, %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_83(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -80(%rbp)
    movq -80(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -80(%rbp), %rax
    pushq %rax
    movq -72(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -32(%rbp), %rax
    pushq %rax
    movq -80(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_281
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_282
.L_else_281:
.L_end_282:
    jmp .L_loop_start_265
.L_loop_end_266:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_84(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -32(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_for
.type parse_for, @function
parse_for:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_85(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_10(%rip), %rax
    pushq %rax
    leaq .LC_str_86(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_keyword
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -32(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_block
    movq %rax, -40(%rbp)
    movq $24, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -48(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -48(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_loop
.type parse_loop, @function
parse_loop:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $0, %rax
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_42(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_283
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_16(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_285
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parse_expression
    movq %rax, -24(%rbp)
    jmp .L_end_286
.L_else_285:
.L_end_286:
    jmp .L_end_284
.L_else_283:
.L_end_284:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_16(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_287
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_288
.L_else_287:
.L_end_288:
    movq $5, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_11(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -32(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_289
    movq -32(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_290
.L_else_289:
.L_end_290:
    movq $3, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_77(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -40(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_42(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_291
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_block
    movq %rax, -40(%rbp)
    jmp .L_end_292
.L_else_291:
.L_loop_start_293:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_294
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_statement
    movq %rax, -48(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_loop_start_293
.L_loop_end_294:
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    pushq %rax
    leaq .LC_str_87(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_keyword
.L_end_292:
    movq -32(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -32(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_function
.type parse_function, @function
parse_function:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_88(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $2, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -32(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_44(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_295
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_loop_start_297:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_45(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_298
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_299
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -40(%rbp)
    movq $13, %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -48(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_301
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_302
.L_else_301:
.L_end_302:
    jmp .L_end_300
.L_else_299:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_end_300:
    jmp .L_loop_start_297
.L_loop_end_298:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_89(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    jmp .L_end_296
.L_else_295:
.L_end_296:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_90(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_41(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_303
    movq $0, %rax
    movq %rax, -56(%rbp)
.L_loop_start_305:
    movq -56(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_306
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -64(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_61(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $13, %rax
    pushq %rax
    movq -64(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -64(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -64(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -72(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_26(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_307
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -80(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_0(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_309
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_310
.L_else_309:
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_91(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parser_error
.L_end_310:
    movq $14, %rax
    pushq %rax
    movq -80(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -80(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -80(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -88(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_44(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_311
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_loop_start_313:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_45(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_314
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_315
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -96(%rbp)
    movq $13, %rax
    pushq %rax
    movq -96(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -96(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -104(%rbp)
    movq -88(%rbp), %rax
    pushq %rax
    movq -104(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_317
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_318
.L_else_317:
.L_end_318:
    jmp .L_end_316
.L_else_315:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_end_316:
    jmp .L_loop_start_313
.L_loop_end_314:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_92(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    jmp .L_end_312
.L_else_311:
.L_end_312:
    movq -72(%rbp), %rax
    pushq %rax
    movq -88(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_308
.L_else_307:
.L_end_308:
    movq -32(%rbp), %rax
    pushq %rax
    movq -72(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_319
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_320
.L_else_319:
    movq $1, %rax
    movq %rax, -56(%rbp)
.L_end_320:
    jmp .L_loop_start_305
.L_loop_end_306:
    jmp .L_end_304
.L_else_303:
.L_end_304:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_93(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_26(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_321
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -112(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_0(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_323
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_324
.L_else_323:
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_94(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call parser_error
.L_end_324:
    movq $14, %rax
    pushq %rax
    movq -112(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -112(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -112(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -120(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_44(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_325
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_loop_start_327:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_45(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_328
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_329
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -128(%rbp)
    movq $13, %rax
    pushq %rax
    movq -128(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -128(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -128(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -136(%rbp)
    movq -120(%rbp), %rax
    pushq %rax
    movq -136(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_331
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_332
.L_else_331:
.L_end_332:
    jmp .L_end_330
.L_else_329:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_end_330:
    jmp .L_loop_start_327
.L_loop_end_328:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_92(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    jmp .L_end_326
.L_else_325:
.L_end_326:
    movq -32(%rbp), %rax
    pushq %rax
    movq -120(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_322
.L_else_321:
.L_end_322:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_16(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_333
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq $3, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_77(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -144(%rbp)
.L_loop_start_335:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_336
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_statement
    movq %rax, -152(%rbp)
    movq -144(%rbp), %rax
    pushq %rax
    movq -152(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_loop_start_335
.L_loop_end_336:
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    pushq %rax
    leaq .LC_str_95(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_keyword
    movq -32(%rbp), %rax
    pushq %rax
    movq -144(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_334
.L_else_333:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_block
    movq %rax, -160(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    movq -160(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
.L_end_334:
    movq -32(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_type_decl
.type parse_type_decl, @function
parse_type_decl:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_96(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $14, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -32(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_42(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_337
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_loop_start_339:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_43(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_340
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -40(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_67(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_68(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -48(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_97(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $13, %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -56(%rbp)
    movq $14, %rax
    pushq %rax
    movq -48(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -48(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -48(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -64(%rbp)
    movq -56(%rbp), %rax
    pushq %rax
    movq -64(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -32(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_341
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_342
.L_else_341:
.L_end_342:
    jmp .L_loop_start_339
.L_loop_end_340:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_69(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    jmp .L_end_338
.L_else_337:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_16(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_343
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_loop_start_345:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_346
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -72(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_67(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_68(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -80(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_97(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $13, %rax
    pushq %rax
    movq -72(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -72(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -72(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -88(%rbp)
    movq $14, %rax
    pushq %rax
    movq -80(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -80(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -80(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -96(%rbp)
    movq -88(%rbp), %rax
    pushq %rax
    movq -96(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -32(%rbp), %rax
    pushq %rax
    movq -88(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_loop_start_345
.L_loop_end_346:
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_17(%rip), %rax
    pushq %rax
    leaq .LC_str_98(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_keyword
    jmp .L_end_344
.L_else_343:
.L_end_344:
.L_end_338:
    movq -32(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_enum_decl
.type parse_enum_decl, @function
parse_enum_decl:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_99(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $22, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -32(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_100(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
.L_loop_start_347:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_43(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_348
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -40(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    pushq %rax
    leaq .LC_str_101(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq $23, %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -40(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -48(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_40(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_349
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_loop_start_351:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_41(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_352
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_353
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -56(%rbp)
    movq $14, %rax
    pushq %rax
    movq -56(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -56(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -56(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -64(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    movq -64(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_355
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_356
.L_else_355:
.L_end_356:
    jmp .L_end_354
.L_else_353:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
.L_end_354:
    jmp .L_loop_start_351
.L_loop_end_352:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_102(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    jmp .L_end_350
.L_else_349:
.L_end_350:
    movq -32(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_46(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_357
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_358
.L_else_357:
.L_end_358:
    jmp .L_loop_start_347
.L_loop_end_348:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    pushq %rax
    leaq .LC_str_103(%rip), %rax
    pushq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    call expect_kind
    movq -32(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_use_stmt
.type parse_use_stmt, @function
parse_use_stmt:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    leaq .LC_str_52(%rip), %rax
    movq %rax, -24(%rbp)
    movq $0, %rax
    movq %rax, -32(%rbp)
.L_loop_start_359:
    movq -32(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_360
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_361
    movq -24(%rbp), %rax
    pushq %rax
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_363
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    movq %rax, -24(%rbp)
    jmp .L_end_364
.L_else_363:
    movq -24(%rbp), %rax
    pushq %rax
    leaq .LC_str_48(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, -24(%rbp)
.L_end_364:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_48(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_365
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call advance_parser
    jmp .L_end_366
.L_else_365:
    movq $1, %rax
    movq %rax, -32(%rbp)
.L_end_366:
    jmp .L_end_362
.L_else_361:
    movq $1, %rax
    movq %rax, -32(%rbp)
.L_end_362:
    jmp .L_loop_start_359
.L_loop_end_360:
    movq $18, %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rbp, %rsp
    popq %rbp
    ret

.globl parse_program
.type parse_program, @function
parse_program:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq $1, %rax
    pushq %rax
    movq $1, %rax
    pushq %rax
    movq $1, %rax
    pushq %rax
    leaq .LC_str_104(%rip), %rax
    pushq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call create_node
    movq %rax, -16(%rbp)
.L_loop_start_367:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    cmpq $0, %rax
    je .L_loop_end_368
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_0(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_1(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_369
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_function
    movq %rax, -24(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_370
.L_else_369:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_4(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_371
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_type_decl
    movq %rax, -32(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_372
.L_else_371:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_5(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_373
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_enum_decl
    movq %rax, -40(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_374
.L_else_373:
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_12(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_375
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_use_stmt
    movq %rax, -48(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
    jmp .L_end_376
.L_else_375:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_statement
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call add_child
.L_end_376:
.L_end_374:
.L_end_372:
.L_end_370:
    jmp .L_loop_start_367
.L_loop_end_368:
    movq -16(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl make_diagnostic
.type make_diagnostic, @function
make_diagnostic:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %r8, -40(%rbp)
    movq %r9, -48(%rbp)
    movq $48, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq -8(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq -16(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -24(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -32(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    movq -40(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 32(%rbx)
    movq -48(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 40(%rbx)
    popq %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl severity_prefix
.type severity_prefix, @function
severity_prefix:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_377
    leaq .LC_str_105(%rip), %rax
    jmp .L_end_378
.L_else_377:
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_379
    leaq .LC_str_106(%rip), %rax
    jmp .L_end_380
.L_else_379:
    movq -8(%rbp), %rax
    pushq %rax
    movq $3, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_381
    leaq .LC_str_107(%rip), %rax
    jmp .L_end_382
.L_else_381:
    movq -8(%rbp), %rax
    pushq %rax
    movq $4, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_383
    leaq .LC_str_108(%rip), %rax
    jmp .L_end_384
.L_else_383:
    leaq .LC_str_109(%rip), %rax
.L_end_384:
.L_end_382:
.L_end_380:
.L_end_378:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl format_diagnostic
.type format_diagnostic, @function
format_diagnostic:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    popq %rdi
    call severity_prefix
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_26(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    movq %rax, %rdi
    call rubix_rt_int_to_str
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_26(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    movq 24(%rax), %rax
    movq %rax, %rdi
    call rubix_rt_int_to_str
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, -24(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_110(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    movq 32(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_111(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_54(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -24(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_111(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, -32(%rbp)
    movq -8(%rbp), %rax
    movq 40(%rax), %rax
    pushq %rax
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    cmpq $0, %rax
    je .L_else_385
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_112(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    movq 40(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_111(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, -32(%rbp)
    jmp .L_end_386
.L_else_385:
.L_end_386:
    movq -32(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl report_error
.type report_error, @function
report_error:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %r8, -40(%rbp)
    movq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %r9
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call make_diagnostic
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    popq %rdi
    call format_diagnostic
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq %rbp, %rsp
    popq %rbp
    ret

.globl report_warning
.type report_warning, @function
report_warning:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %r8, -40(%rbp)
    movq $2, %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %r9
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call make_diagnostic
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    popq %rdi
    call format_diagnostic
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq %rbp, %rsp
    popq %rbp
    ret

.globl init_semantics
.type init_semantics, @function
init_semantics:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq $40, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq $1, %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    movq -8(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 32(%rbx)
    popq %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl push_scope
.type push_scope, @function
push_scope:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    movq 24(%rax), %rax
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 24(%rax)
    movq -24(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 16(%rax)
    movq -16(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl pop_scope
.type pop_scope, @function
pop_scope:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 16(%rax)
    movq %rbp, %rsp
    popq %rbp
    ret

.globl record_semantic_error
.type record_semantic_error, @function
record_semantic_error:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %r8, -40(%rbp)
    movq -8(%rbp), %rax
    movq 32(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call report_error
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 0(%rax)
    movq %rbp, %rsp
    popq %rbp
    ret

.globl is_let_declared
.type is_let_declared, @function
is_let_declared:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq $0, %rax
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -32(%rbp)
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl analyze_node
.type analyze_node, @function
analyze_node:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setle %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_387
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_388
.L_else_387:
.L_end_388:
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_kind
    movq %rax, -24(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_text
    movq %rax, -32(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_line
    movq %rax, -40(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_col
    movq %rax, -48(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_389
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -56(%rbp)
.L_loop_start_391:
    movq -56(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_392
    movq -8(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -56(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -56(%rbp)
    jmp .L_loop_start_391
.L_loop_end_392:
    jmp .L_end_390
.L_else_389:
    movq -24(%rbp), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_393
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call push_scope
    movq %rax, -64(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -72(%rbp)
.L_loop_start_395:
    movq -72(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_396
    movq -8(%rbp), %rax
    pushq %rax
    movq -72(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -72(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -72(%rbp)
    jmp .L_loop_start_395
.L_loop_end_396:
    movq -8(%rbp), %rax
    pushq %rax
    movq -64(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call pop_scope
    jmp .L_end_394
.L_else_393:
    movq -24(%rbp), %rax
    pushq %rax
    movq $3, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_397
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call push_scope
    movq %rax, -80(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -88(%rbp)
.L_loop_start_399:
    movq -88(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_400
    movq -8(%rbp), %rax
    pushq %rax
    movq -88(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -88(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -88(%rbp)
    jmp .L_loop_start_399
.L_loop_end_400:
    movq -8(%rbp), %rax
    pushq %rax
    movq -80(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call pop_scope
    jmp .L_end_398
.L_else_397:
    movq -24(%rbp), %rax
    pushq %rax
    movq $20, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $21, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_401
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -96(%rbp)
    movq -96(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_403
    movq -96(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -104(%rbp)
    movq -104(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_405
    movq -8(%rbp), %rax
    pushq %rax
    movq -104(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    jmp .L_end_406
.L_else_405:
.L_end_406:
    jmp .L_end_404
.L_else_403:
.L_end_404:
    jmp .L_end_402
.L_else_401:
    movq -24(%rbp), %rax
    pushq %rax
    movq $4, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_407
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -112(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -112(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -112(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_409
    movq -112(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -120(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -120(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -120(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_411
    movq -120(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -128(%rbp)
    movq -128(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_413
    movq -8(%rbp), %rax
    pushq %rax
    movq -128(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    jmp .L_end_414
.L_else_413:
.L_end_414:
    jmp .L_end_412
.L_else_411:
.L_end_412:
    jmp .L_end_410
.L_else_409:
.L_end_410:
    jmp .L_end_408
.L_else_407:
    movq -24(%rbp), %rax
    pushq %rax
    movq $11, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_415
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -136(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -136(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -136(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -144(%rbp)
.L_loop_start_417:
    movq -144(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_418
    movq -144(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -152(%rbp)
    movq -152(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_419
    movq -152(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -160(%rbp)
    movq -160(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_421
    movq -8(%rbp), %rax
    pushq %rax
    movq -160(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    jmp .L_end_422
.L_else_421:
.L_end_422:
    jmp .L_end_420
.L_else_419:
.L_end_420:
    movq -144(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -144(%rbp)
    jmp .L_loop_start_417
.L_loop_end_418:
    jmp .L_end_416
.L_else_415:
    movq -24(%rbp), %rax
    pushq %rax
    movq $24, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_423
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -168(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -168(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -168(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_425
    movq -168(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -176(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -176(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    jmp .L_end_426
.L_else_425:
.L_end_426:
    jmp .L_end_424
.L_else_423:
    movq -24(%rbp), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_427
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -184(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -184(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -184(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_429
    movq -184(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -192(%rbp)
    movq -192(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_431
    movq -8(%rbp), %rax
    pushq %rax
    movq -192(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    jmp .L_end_432
.L_else_431:
.L_end_432:
    jmp .L_end_430
.L_else_429:
.L_end_430:
    jmp .L_end_428
.L_else_427:
    movq -24(%rbp), %rax
    pushq %rax
    movq $6, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_433
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -200(%rbp)
    movq -200(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_435
    movq -200(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -208(%rbp)
    movq -208(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_437
    movq -8(%rbp), %rax
    pushq %rax
    movq -208(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    jmp .L_end_438
.L_else_437:
.L_end_438:
    jmp .L_end_436
.L_else_435:
.L_end_436:
    jmp .L_end_434
.L_else_433:
    movq -24(%rbp), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_439
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -216(%rbp)
    movq -216(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_441
    movq -8(%rbp), %rax
    pushq %rax
    movq -216(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -216(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -224(%rbp)
    movq -224(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_443
    movq -8(%rbp), %rax
    pushq %rax
    movq -224(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    jmp .L_end_444
.L_else_443:
.L_end_444:
    jmp .L_end_442
.L_else_441:
.L_end_442:
    jmp .L_end_440
.L_else_439:
    movq -24(%rbp), %rax
    pushq %rax
    movq $10, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $26, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_445
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -232(%rbp)
    movq -232(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_447
    movq -8(%rbp), %rax
    pushq %rax
    movq -232(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    jmp .L_end_448
.L_else_447:
.L_end_448:
    jmp .L_end_446
.L_else_445:
    movq -24(%rbp), %rax
    pushq %rax
    movq $15, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_449
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -240(%rbp)
    movq -240(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_451
    movq -8(%rbp), %rax
    pushq %rax
    movq -240(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -240(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -248(%rbp)
.L_loop_start_453:
    movq -248(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_454
    movq -8(%rbp), %rax
    pushq %rax
    movq -248(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -248(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -248(%rbp)
    jmp .L_loop_start_453
.L_loop_end_454:
    jmp .L_end_452
.L_else_451:
.L_end_452:
    jmp .L_end_450
.L_else_449:
    movq -24(%rbp), %rax
    pushq %rax
    movq $16, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_455
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -256(%rbp)
.L_loop_start_457:
    movq -256(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_458
    movq -8(%rbp), %rax
    pushq %rax
    movq -256(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -256(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -256(%rbp)
    jmp .L_loop_start_457
.L_loop_end_458:
    jmp .L_end_456
.L_else_455:
    movq -24(%rbp), %rax
    pushq %rax
    movq $17, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $27, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_459
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -264(%rbp)
    movq -264(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_461
    movq -8(%rbp), %rax
    pushq %rax
    movq -264(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -264(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -272(%rbp)
    movq -272(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_463
    movq -8(%rbp), %rax
    pushq %rax
    movq -272(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    jmp .L_end_464
.L_else_463:
.L_end_464:
    jmp .L_end_462
.L_else_461:
.L_end_462:
    jmp .L_end_460
.L_else_459:
    movq -24(%rbp), %rax
    pushq %rax
    movq $19, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_465
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -280(%rbp)
    movq -280(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_467
    movq -8(%rbp), %rax
    pushq %rax
    movq -280(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    jmp .L_end_468
.L_else_467:
.L_end_468:
    jmp .L_end_466
.L_else_465:
.L_end_466:
.L_end_460:
.L_end_456:
.L_end_450:
.L_end_446:
.L_end_440:
.L_end_434:
.L_end_428:
.L_end_424:
.L_end_416:
.L_end_408:
.L_end_402:
.L_end_398:
.L_end_394:
.L_end_390:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl run_semantic_analysis
.type run_semantic_analysis, @function
run_semantic_analysis:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call init_semantics
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call analyze_node
    movq -24(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl init_typechecker
.type init_typechecker, @function
init_typechecker:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq $24, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -8(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    popq %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl type_name
.type type_name, @function
type_name:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_469
    leaq .LC_str_113(%rip), %rax
    jmp .L_end_470
.L_else_469:
    movq -8(%rbp), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_471
    leaq .LC_str_114(%rip), %rax
    jmp .L_end_472
.L_else_471:
    movq -8(%rbp), %rax
    pushq %rax
    movq $3, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_473
    leaq .LC_str_115(%rip), %rax
    jmp .L_end_474
.L_else_473:
    movq -8(%rbp), %rax
    pushq %rax
    movq $4, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_475
    leaq .LC_str_116(%rip), %rax
    jmp .L_end_476
.L_else_475:
    movq -8(%rbp), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_477
    leaq .LC_str_117(%rip), %rax
    jmp .L_end_478
.L_else_477:
    movq -8(%rbp), %rax
    pushq %rax
    movq $6, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_479
    leaq .LC_str_118(%rip), %rax
    jmp .L_end_480
.L_else_479:
    movq -8(%rbp), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_481
    leaq .LC_str_119(%rip), %rax
    jmp .L_end_482
.L_else_481:
    movq -8(%rbp), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_483
    leaq .LC_str_120(%rip), %rax
    jmp .L_end_484
.L_else_483:
    leaq .LC_str_121(%rip), %rax
.L_end_484:
.L_end_482:
.L_end_480:
.L_end_478:
.L_end_476:
.L_end_474:
.L_end_472:
.L_end_470:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl record_type_error
.type record_type_error, @function
record_type_error:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %r8, -40(%rbp)
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call report_error
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 0(%rax)
    movq %rbp, %rsp
    popq %rbp
    ret

.globl check_type_compat
.type check_type_compat, @function
check_type_compat:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %r8, -40(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_485
    movq $1, %rax
    jmp .L_end_486
.L_else_485:
    leaq .LC_str_122(%rip), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call type_name
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_123(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdi
    call type_name
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_124(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, -48(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    leaq .LC_str_125(%rip), %rax
    pushq %rax
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call record_type_error
    movq $0, %rax
.L_end_486:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl infer_and_check
.type infer_and_check, @function
infer_and_check:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setle %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_487
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_488
.L_else_487:
.L_end_488:
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_kind
    movq %rax, -24(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_text
    movq %rax, -32(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_line
    movq %rax, -40(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_col
    movq %rax, -48(%rbp)
    movq $1, %rax
    movq %rax, -56(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq $9, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_489
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_type
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_491
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_14(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_15(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_493
    movq $4, %rax
    movq %rax, -56(%rbp)
    jmp .L_end_494
.L_else_493:
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_126(%rip), %rax
    pushq %rax
    movq 8(%rsp), %rax
    movq 0(%rax), %rcx
    movq $0, %rdx
.L_cont_loop_497:
    cmpq %rcx, %rdx
    jge .L_cont_end_499
    movq 8(%rsp), %rax
    movq 8(%rax, %rdx, 8), %rbx
    cmpq 0(%rsp), %rbx
    je .L_cont_found_498
    addq $1, %rdx
    jmp .L_cont_loop_497
.L_cont_found_498:
    movq $1, %rax
    jmp .L_cont_done_500
.L_cont_end_499:
    movq $0, %rax
.L_cont_done_500:
    addq $16, %rsp
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_495
    movq $5, %rax
    movq %rax, -56(%rbp)
    jmp .L_end_496
.L_else_495:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_48(%rip), %rax
    pushq %rax
    movq 8(%rsp), %rax
    movq 0(%rax), %rcx
    movq $0, %rdx
.L_cont_loop_503:
    cmpq %rcx, %rdx
    jge .L_cont_end_505
    movq 8(%rsp), %rax
    movq 8(%rax, %rdx, 8), %rbx
    cmpq 0(%rsp), %rbx
    je .L_cont_found_504
    addq $1, %rdx
    jmp .L_cont_loop_503
.L_cont_found_504:
    movq $1, %rax
    jmp .L_cont_done_506
.L_cont_end_505:
    movq $0, %rax
.L_cont_done_506:
    addq $16, %rsp
    cmpq $0, %rax
    je .L_else_501
    movq $3, %rax
    movq %rax, -56(%rbp)
    jmp .L_end_502
.L_else_501:
    movq $2, %rax
    movq %rax, -56(%rbp)
.L_end_502:
.L_end_496:
.L_end_494:
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_492
.L_else_491:
.L_end_492:
    jmp .L_end_490
.L_else_489:
    movq -24(%rbp), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_507
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_type
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_509
    movq $2, %rax
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_510
.L_else_509:
.L_end_510:
    jmp .L_end_508
.L_else_507:
    movq -24(%rbp), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_511
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -64(%rbp)
    movq -64(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -72(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -64(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq %rax, -80(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -72(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq %rax, -88(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_33(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_35(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_36(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_37(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_38(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_513
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_33(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -80(%rbp), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -88(%rbp), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_515
    movq $5, %rax
    movq %rax, -56(%rbp)
    jmp .L_end_516
.L_else_515:
    movq -80(%rbp), %rax
    pushq %rax
    movq $3, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -88(%rbp), %rax
    pushq %rax
    movq $3, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_517
    movq $3, %rax
    movq %rax, -56(%rbp)
    jmp .L_end_518
.L_else_517:
    movq $2, %rax
    movq %rax, -56(%rbp)
.L_end_518:
.L_end_516:
    jmp .L_end_514
.L_else_513:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_22(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_27(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_519
    movq $4, %rax
    movq %rax, -56(%rbp)
    jmp .L_end_520
.L_else_519:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_30(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_32(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_29(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_31(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_521
    movq $4, %rax
    movq %rax, -56(%rbp)
    jmp .L_end_522
.L_else_521:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_18(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_19(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_523
    movq -8(%rbp), %rax
    pushq %rax
    movq $4, %rax
    pushq %rax
    movq -80(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call check_type_compat
    movq -8(%rbp), %rax
    pushq %rax
    movq $4, %rax
    pushq %rax
    movq -88(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call check_type_compat
    movq $4, %rax
    movq %rax, -56(%rbp)
    jmp .L_end_524
.L_else_523:
.L_end_524:
.L_end_522:
.L_end_520:
.L_end_514:
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_512
.L_else_511:
    movq -24(%rbp), %rax
    pushq %rax
    movq $10, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_525
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -96(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -96(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq %rax, -104(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_20(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_28(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_527
    movq -8(%rbp), %rax
    pushq %rax
    movq $4, %rax
    pushq %rax
    movq -104(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    call check_type_compat
    movq $4, %rax
    movq %rax, -56(%rbp)
    jmp .L_end_528
.L_else_527:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_35(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_529
    movq -104(%rbp), %rax
    movq %rax, -56(%rbp)
    jmp .L_end_530
.L_else_529:
.L_end_530:
.L_end_528:
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_526
.L_else_525:
    movq -24(%rbp), %rax
    pushq %rax
    movq $20, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $21, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_531
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -112(%rbp)
    movq -112(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -120(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -120(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq %rax, -128(%rbp)
    movq -112(%rbp), %rax
    pushq %rax
    movq -128(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    movq -16(%rbp), %rax
    pushq %rax
    movq -128(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    movq -128(%rbp), %rax
    movq %rax, -56(%rbp)
    jmp .L_end_532
.L_else_531:
    movq -24(%rbp), %rax
    pushq %rax
    movq $6, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_533
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -136(%rbp)
    movq -136(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -144(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -144(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq %rax, -152(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -152(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    movq -152(%rbp), %rax
    movq %rax, -56(%rbp)
    jmp .L_end_534
.L_else_533:
    movq -24(%rbp), %rax
    pushq %rax
    movq $4, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_535
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -160(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -160(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq %rax, -168(%rbp)
    movq -160(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -176(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -176(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq %rax, -184(%rbp)
    movq -176(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_537
    movq -176(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -192(%rbp)
    movq -192(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_539
    movq -8(%rbp), %rax
    pushq %rax
    movq -192(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    jmp .L_end_540
.L_else_539:
.L_end_540:
    jmp .L_end_538
.L_else_537:
.L_end_538:
    movq -184(%rbp), %rax
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_536
.L_else_535:
    movq -24(%rbp), %rax
    pushq %rax
    movq $11, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_541
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -200(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -200(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq -200(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -208(%rbp)
    movq $1, %rax
    movq %rax, -216(%rbp)
.L_loop_start_543:
    movq -208(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_544
    movq -208(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -224(%rbp)
    movq -224(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -232(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -232(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq %rax, -216(%rbp)
    movq -208(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -208(%rbp)
    jmp .L_loop_start_543
.L_loop_end_544:
    movq -216(%rbp), %rax
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_542
.L_else_541:
    movq -24(%rbp), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $24, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_545
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -240(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -240(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq -240(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -248(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -248(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq $1, %rax
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_546
.L_else_545:
    movq -24(%rbp), %rax
    pushq %rax
    movq $15, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_547
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -256(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -256(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq -256(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -264(%rbp)
.L_loop_start_549:
    movq -264(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_550
    movq -8(%rbp), %rax
    pushq %rax
    movq -264(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq -264(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -264(%rbp)
    jmp .L_loop_start_549
.L_loop_end_550:
    movq $2, %rax
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_548
.L_else_547:
    movq -24(%rbp), %rax
    pushq %rax
    movq $16, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_551
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -272(%rbp)
.L_loop_start_553:
    movq -272(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_554
    movq -8(%rbp), %rax
    pushq %rax
    movq -272(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq -272(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -272(%rbp)
    jmp .L_loop_start_553
.L_loop_end_554:
    movq $6, %rax
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_552
.L_else_551:
    movq -24(%rbp), %rax
    pushq %rax
    movq $17, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $27, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_555
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -280(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -280(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq $0, %rax
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_556
.L_else_555:
    movq -24(%rbp), %rax
    pushq %rax
    movq $19, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_557
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -288(%rbp)
    movq -288(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_559
    movq -8(%rbp), %rax
    pushq %rax
    movq -288(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq %rax, -56(%rbp)
    jmp .L_end_560
.L_else_559:
.L_end_560:
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
    jmp .L_end_558
.L_else_557:
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -296(%rbp)
    movq $1, %rax
    movq %rax, -304(%rbp)
.L_loop_start_561:
    movq -296(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_562
    movq -8(%rbp), %rax
    pushq %rax
    movq -296(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq %rax, -304(%rbp)
    movq -296(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -296(%rbp)
    jmp .L_loop_start_561
.L_loop_end_562:
    movq -304(%rbp), %rax
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call set_node_type
.L_end_558:
.L_end_556:
.L_end_552:
.L_end_548:
.L_end_546:
.L_end_542:
.L_end_536:
.L_end_534:
.L_end_532:
.L_end_526:
.L_end_512:
.L_end_508:
.L_end_490:
    movq -56(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl run_typechecker
.type run_typechecker, @function
run_typechecker:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call init_typechecker
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call infer_and_check
    movq -24(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl val_void
.type val_void, @function
val_void:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $1, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    leaq .LC_str_52(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl val_int
.type val_int, @function
val_int:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $2, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq -8(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    leaq .LC_str_52(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl val_bool
.type val_bool, @function
val_bool:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $4, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq -8(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    leaq .LC_str_52(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl val_str
.type val_str, @function
val_str:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq $32, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $5, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    movq -8(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    popq %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl is_truthy
.type is_truthy, @function
is_truthy:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $4, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_563
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    jmp .L_end_564
.L_else_563:
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_565
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    jmp .L_end_566
.L_else_565:
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_567
    movq -8(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    jmp .L_end_568
.L_else_567:
    movq $0, %rax
.L_end_568:
.L_end_566:
.L_end_564:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl val_to_string
.type val_to_string, @function
val_to_string:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_569
    movq -8(%rbp), %rax
    movq 24(%rax), %rax
    jmp .L_end_570
.L_else_569:
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_571
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rdi
    call rubix_rt_int_to_str
    jmp .L_end_572
.L_else_571:
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $4, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_573
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    cmpq $0, %rax
    je .L_else_575
    leaq .LC_str_14(%rip), %rax
    jmp .L_end_576
.L_else_575:
    leaq .LC_str_15(%rip), %rax
.L_end_576:
    jmp .L_end_574
.L_else_573:
    leaq .LC_str_127(%rip), %rax
.L_end_574:
.L_end_572:
.L_end_570:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl init_eval_context
.type init_eval_context, @function
init_eval_context:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq $40, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    call val_void
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 16(%rbx)
    leaq .LC_str_52(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 24(%rbx)
    movq -8(%rbp), %rax
    movq (%rsp), %rbx
    movq %rax, 32(%rbx)
    popq %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl eval_node
.type eval_node, @function
eval_node:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setle %al
    movzbq %al, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 16(%rax), %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_577
    call val_void
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_578
.L_else_577:
.L_end_578:
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_kind
    movq %rax, -24(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_text
    movq %rax, -32(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq $9, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_579
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_type
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_581
    movq -32(%rbp), %rax
    pushq %rax
    popq %rdi
    call val_str
    jmp .L_end_582
.L_else_581:
    movq -40(%rbp), %rax
    pushq %rax
    movq $4, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_14(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_15(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_583
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_14(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    popq %rdi
    call val_bool
    jmp .L_end_584
.L_else_583:
    movq -32(%rbp), %rax
    pushq %rax
    popq %rdi
    call string_to_int
    pushq %rax
    popq %rdi
    call val_int
.L_end_584:
.L_end_582:
    jmp .L_end_580
.L_else_579:
    movq -24(%rbp), %rax
    pushq %rax
    movq $8, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_585
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_14(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_15(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_587
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_14(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    popq %rdi
    call val_bool
    jmp .L_end_588
.L_else_587:
    movq $0, %rax
    pushq %rax
    popq %rdi
    call val_int
.L_end_588:
    jmp .L_end_586
.L_else_585:
    movq -24(%rbp), %rax
    pushq %rax
    movq $7, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_589
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -56(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_18(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_591
    movq -8(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -64(%rbp)
    cmpq $0, %rax
    je .L_else_593
    movq $0, %rax
    pushq %rax
    popq %rdi
    call val_bool
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_594
.L_else_593:
.L_end_594:
    movq -8(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -72(%rbp)
    movq -72(%rbp), %rax
    pushq %rax
    popq %rdi
    call is_truthy
    pushq %rax
    popq %rdi
    call val_bool
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_592
.L_else_591:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_19(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_595
    movq -8(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -80(%rbp)
    movq -80(%rbp), %rax
    pushq %rax
    popq %rdi
    call is_truthy
    cmpq $0, %rax
    je .L_else_597
    movq $1, %rax
    pushq %rax
    popq %rdi
    call val_bool
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_598
.L_else_597:
.L_end_598:
    movq -8(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -88(%rbp)
    movq -88(%rbp), %rax
    pushq %rax
    popq %rdi
    call is_truthy
    pushq %rax
    popq %rdi
    call val_bool
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_596
.L_else_595:
.L_end_596:
.L_end_592:
    movq -8(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -96(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -56(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -104(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_33(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_599
    movq -96(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_601
    movq -96(%rbp), %rax
    pushq %rax
    popq %rdi
    call val_to_string
    pushq %rax
    movq -104(%rbp), %rax
    pushq %rax
    popq %rdi
    call val_to_string
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    popq %rdi
    call val_str
    jmp .L_end_602
.L_else_601:
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    popq %rdi
    call val_int
.L_end_602:
    jmp .L_end_600
.L_else_599:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_35(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_603
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    subq %rbx, %rax
    pushq %rax
    popq %rdi
    call val_int
    jmp .L_end_604
.L_else_603:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_36(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_605
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    imulq %rbx, %rax
    pushq %rax
    popq %rdi
    call val_int
    jmp .L_end_606
.L_else_605:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_37(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_607
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    cmpq $0, %rax
    je .L_else_609
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cqto
    idivq %rbx
    pushq %rax
    popq %rdi
    call val_int
    jmp .L_end_610
.L_else_609:
    movq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 16(%rax)
    leaq .LC_str_128(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 24(%rax)
    call val_void
.L_end_610:
    jmp .L_end_608
.L_else_607:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_38(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_611
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    cmpq $0, %rax
    je .L_else_613
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cqto
    idivq %rbx
    movq %rdx, %rax
    pushq %rax
    popq %rdi
    call val_int
    jmp .L_end_614
.L_else_613:
    movq $0, %rax
    pushq %rax
    popq %rdi
    call val_int
.L_end_614:
    jmp .L_end_612
.L_else_611:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_22(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_615
    movq -96(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_617
    movq -96(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 24(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    popq %rdi
    call val_bool
    jmp .L_end_618
.L_else_617:
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    popq %rdi
    call val_bool
.L_end_618:
    jmp .L_end_616
.L_else_615:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_27(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_619
    movq -96(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_621
    movq -96(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 24(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    popq %rdi
    call val_bool
    jmp .L_end_622
.L_else_621:
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    xorq $1, %rax
    pushq %rax
    popq %rdi
    call val_bool
.L_end_622:
    jmp .L_end_620
.L_else_619:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_30(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_623
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setl %al
    movzbq %al, %rax
    pushq %rax
    popq %rdi
    call val_bool
    jmp .L_end_624
.L_else_623:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_29(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_625
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setle %al
    movzbq %al, %rax
    pushq %rax
    popq %rdi
    call val_bool
    jmp .L_end_626
.L_else_625:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_32(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_627
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    pushq %rax
    popq %rdi
    call val_bool
    jmp .L_end_628
.L_else_627:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_31(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_629
    movq -96(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -104(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setge %al
    movzbq %al, %rax
    pushq %rax
    popq %rdi
    call val_bool
    jmp .L_end_630
.L_else_629:
    call val_void
.L_end_630:
.L_end_628:
.L_end_626:
.L_end_624:
.L_end_620:
.L_end_616:
.L_end_612:
.L_end_608:
.L_end_606:
.L_end_604:
.L_end_600:
    jmp .L_end_590
.L_else_589:
    movq -24(%rbp), %rax
    pushq %rax
    movq $10, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_631
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -112(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -112(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -120(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_35(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_633
    pushq %rax
    popq %rdi
    call val_int
    jmp .L_end_634
.L_else_633:
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_20(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_28(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_635
    pushq %rax
    popq %rdi
    call val_bool
    jmp .L_end_636
.L_else_635:
    movq -120(%rbp), %rax
.L_end_636:
.L_end_634:
    jmp .L_end_632
.L_else_631:
    movq -24(%rbp), %rax
    pushq %rax
    movq $19, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_637
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -128(%rbp)
    movq -128(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_639
    movq -8(%rbp), %rax
    pushq %rax
    movq -128(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 8(%rax)
    jmp .L_end_640
.L_else_639:
    call val_void
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 8(%rax)
.L_end_640:
    movq $1, %rax
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 0(%rax)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    jmp .L_end_638
.L_else_637:
    movq -24(%rbp), %rax
    pushq %rax
    movq $4, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_641
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -136(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -136(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -144(%rbp)
    movq -136(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -152(%rbp)
    movq -144(%rbp), %rax
    pushq %rax
    popq %rdi
    call is_truthy
    cmpq $0, %rax
    je .L_else_643
    movq -8(%rbp), %rax
    pushq %rax
    movq -152(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    jmp .L_end_644
.L_else_643:
    movq -152(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_645
    movq -152(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -160(%rbp)
    movq -160(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_647
    movq -8(%rbp), %rax
    pushq %rax
    movq -160(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    jmp .L_end_648
.L_else_647:
    call val_void
.L_end_648:
    jmp .L_end_646
.L_else_645:
    call val_void
.L_end_646:
.L_end_644:
    jmp .L_end_642
.L_else_641:
    movq -24(%rbp), %rax
    pushq %rax
    movq $11, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_649
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -168(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -168(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -176(%rbp)
    movq -168(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -184(%rbp)
    call val_void
    movq %rax, -192(%rbp)
.L_loop_start_651:
    movq -184(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    pushq %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    pushq %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_652
    movq -184(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -200(%rbp)
    movq -200(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -208(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -208(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -192(%rbp)
    movq -184(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -184(%rbp)
    jmp .L_loop_start_651
.L_loop_end_652:
    movq -192(%rbp), %rax
    jmp .L_end_650
.L_else_649:
    movq -24(%rbp), %rax
    pushq %rax
    movq $5, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_653
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -216(%rbp)
    movq -216(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -224(%rbp)
    call val_void
    movq %rax, -232(%rbp)
.L_loop_start_655:
    movq -8(%rbp), %rax
    pushq %rax
    movq -216(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    pushq %rax
    popq %rdi
    call is_truthy
    pushq %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    pushq %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_656
    movq -8(%rbp), %rax
    pushq %rax
    movq -224(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -232(%rbp)
    jmp .L_loop_start_655
.L_loop_end_656:
    movq -232(%rbp), %rax
    jmp .L_end_654
.L_else_653:
    movq -24(%rbp), %rax
    pushq %rax
    movq $3, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_657
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -240(%rbp)
    call val_void
    movq %rax, -248(%rbp)
.L_loop_start_659:
    movq -240(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    pushq %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    pushq %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_660
    movq -8(%rbp), %rax
    pushq %rax
    movq -240(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -248(%rbp)
    movq -240(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -240(%rbp)
    jmp .L_loop_start_659
.L_loop_end_660:
    movq -248(%rbp), %rax
    jmp .L_end_658
.L_else_657:
    call val_void
.L_end_658:
.L_end_654:
.L_end_650:
.L_end_642:
.L_end_638:
.L_end_632:
.L_end_590:
.L_end_586:
.L_end_580:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl find_main_function
.type find_main_function, @function
find_main_function:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -16(%rbp)
    movq $0, %rax
    movq %rax, -24(%rbp)
.L_loop_start_661:
    movq -16(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_loop_end_662
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_kind
    pushq %rax
    movq $2, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_text
    pushq %rax
    leaq .LC_str_129(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_663
    movq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    jmp .L_end_664
.L_else_663:
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -16(%rbp)
.L_end_664:
    jmp .L_loop_start_661
.L_loop_end_662:
    movq -24(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl evaluate_program
.type evaluate_program, @function
evaluate_program:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call init_eval_context
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call find_main_function
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_665
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_child
    movq %rax, -32(%rbp)
    movq $0, %rax
    movq %rax, -40(%rbp)
.L_loop_start_667:
    movq -32(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_668
    movq -32(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_kind
    pushq %rax
    movq $3, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_669
    movq -32(%rbp), %rax
    movq %rax, -40(%rbp)
    jmp .L_end_670
.L_else_669:
.L_end_670:
    movq -32(%rbp), %rax
    pushq %rax
    popq %rdi
    call get_node_sibling
    movq %rax, -32(%rbp)
    jmp .L_loop_start_667
.L_loop_end_668:
    movq -40(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_671
    movq -16(%rbp), %rax
    pushq %rax
    movq -40(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call eval_node
    movq %rax, -48(%rbp)
    movq -16(%rbp), %rax
    movq 0(%rax), %rax
    cmpq $0, %rax
    je .L_else_673
    movq -16(%rbp), %rax
    movq 8(%rax), %rax
    movq %rax, -48(%rbp)
    jmp .L_end_674
.L_else_673:
.L_end_674:
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    cmpq $0, %rax
    je .L_else_675
    movq $1, %rax
    jmp .L_end_676
.L_else_675:
    movq -48(%rbp), %rax
    movq 8(%rax), %rax
.L_end_676:
    jmp .L_end_672
.L_else_671:
    movq $0, %rax
.L_end_672:
    jmp .L_end_666
.L_else_665:
    movq -16(%rbp), %rax
    movq 16(%rax), %rax
    cmpq $0, %rax
    je .L_else_677
    movq $1, %rax
    jmp .L_end_678
.L_else_677:
    movq $0, %rax
.L_end_678:
.L_end_666:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl start_repl
.type start_repl, @function
start_repl:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    leaq .LC_str_130(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_131(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_132(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_133(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_134(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq %rbp, %rsp
    popq %rbp
    ret

.globl init_formatter
.type init_formatter, @function
init_formatter:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq $16, %rdi
    call rubix_rt_alloc
    pushq %rax
    movq $0, %rax
    movq (%rsp), %rbx
    movq %rax, 0(%rbx)
    leaq .LC_str_52(%rip), %rax
    movq (%rsp), %rbx
    movq %rax, 8(%rbx)
    popq %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl append_indent
.type append_indent, @function
append_indent:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq $0, %rax
    movq %rax, -16(%rbp)
.L_loop_start_679:
    movq -16(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq 0(%rax), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setl %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_loop_end_680
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_135(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 8(%rax)
    movq -16(%rbp), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, -16(%rbp)
    jmp .L_loop_start_679
.L_loop_end_680:
    movq %rbp, %rsp
    popq %rbp
    ret

.globl append_text
.type append_text, @function
append_text:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 8(%rax)
    movq %rbp, %rsp
    popq %rbp
    ret

.globl append_line
.type append_line, @function
append_line:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call append_indent
    movq -8(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_111(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    movq -8(%rbp), %rax
    popq %rbx
    movq %rbx, 8(%rax)
    movq %rbp, %rsp
    popq %rbp
    ret

.globl format_source
.type format_source, @function
format_source:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call init_lexer
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call init_parser
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_program
    movq %rax, -40(%rbp)
    movq -32(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_681
    movq -8(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_682
.L_else_681:
.L_end_682:
    call init_formatter
    movq %rax, -48(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -48(%rbp), %rax
    popq %rbx
    movq %rbx, 8(%rax)
    movq -48(%rbp), %rax
    movq 8(%rax), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl print_banner
.type print_banner, @function
print_banner:
    pushq %rbp
    movq %rsp, %rbp
    movq %rbp, %rsp
    popq %rbp
    ret

.globl print_help
.type print_help, @function
print_help:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    leaq .LC_str_137(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_139(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_142(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_143(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_144(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_146(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_147(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_145(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_148(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_153(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_154(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_151(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_141(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_all_cmds_1(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_all_cmds_2(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_cfg_1(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_cfg_2(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_cfg_3(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_more_info(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_pkg_path(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq %rbp, %rsp
    popq %rbp
    ret

.globl print_version
.type print_version, @function
print_version:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    leaq .LC_str_155(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq %rbp, %rsp
    popq %rbp
    ret

.globl cmd_check
.type cmd_check, @function
cmd_check:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_683
    leaq .LC_str_158(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_159(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_684
.L_else_683:
.L_end_684:
    cmpq $0, %rax
    je .L_else_685
    leaq .LC_str_160(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_124(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_686
.L_else_685:
.L_end_686:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call read_file
    movq %rax, -16(%rbp)
    call node_arena_reset
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call init_lexer
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call init_parser
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_program
    movq %rax, -40(%rbp)
    movq -32(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_687
    leaq .LC_str_161(%rip), %rax
    pushq %rax
    movq -32(%rbp), %rax
    movq 24(%rax), %rax
    movq %rax, %rdi
    call rubix_rt_int_to_str
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_162(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_688
.L_else_687:
.L_end_688:
    movq -40(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call run_semantic_analysis
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_689
    leaq .LC_str_161(%rip), %rax
    pushq %rax
    movq -48(%rbp), %rax
    movq 0(%rax), %rax
    movq %rax, %rdi
    call rubix_rt_int_to_str
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_163(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_690
.L_else_689:
.L_end_690:
    movq -40(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call run_typechecker
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_691
    leaq .LC_str_161(%rip), %rax
    pushq %rax
    movq -56(%rbp), %rax
    movq 0(%rax), %rax
    movq %rax, %rdi
    call rubix_rt_int_to_str
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_164(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_692
.L_else_691:
.L_end_692:
    leaq .LC_str_165(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_166(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    call get_total_node_count
    movq %rax, %rdi
    call rubix_rt_int_to_str
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_167(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl cmd_build
.type cmd_build, @function
cmd_build:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    
    cmpq $0, -8(%rbp)
    je .L_build_err
    movq -8(%rbp), %rax
    cmpb $0, (%rax)
    je .L_build_err
    
    cmpq $0, -16(%rbp)
    je .L_check_args_for_dash_o
    movq -16(%rbp), %rax
    cmpb $0, (%rax)
    jne .L_do_compile_file

.L_check_args_for_dash_o:
    call get_arg_count
    cmpq $3, %rax
    jl .L_build_default_out
    movq $2, %rdi
    call get_arg
    movq %rax, %r12
    leaq .LC_str_dash_o(%rip), %rsi
    movq %r12, %rdi
    call strcmp
    testl %eax, %eax
    jne .L_build_default_out
    movq $3, %rdi
    call get_arg
    movq %rax, -16(%rbp)
    jmp .L_do_compile_file

.L_build_default_out:
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_out_ext(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, -16(%rbp)

.L_do_compile_file:
    movq -8(%rbp), %rdi
    movq -16(%rbp), %rsi
    xorq %rdx, %rdx
    call compile_file
    movq %rbp, %rsp
    popq %rbp
    ret

.L_build_err:
    leaq .LC_str_168(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_169(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl cmd_fmt
.type cmd_fmt, @function
cmd_fmt:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_697
    leaq .LC_str_171(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_172(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_698
.L_else_697:
.L_end_698:
    cmpq $0, %rax
    je .L_else_699
    leaq .LC_str_160(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_124(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_700
.L_else_699:
.L_end_700:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call read_file
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call format_source
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq -24(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call write_file
    leaq .LC_str_173(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl cmd_new
.type cmd_new, @function
cmd_new:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_701
    leaq .LC_str_174(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_175(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_702
.L_else_701:
.L_end_702:
    leaq .LC_str_176(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_177(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_178(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_177(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_179(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl cmd_run
.type cmd_run, @function
cmd_run:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    movq %rdi, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_52(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_703
    leaq .LC_str_180(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_181(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_704
.L_else_703:
.L_end_704:
    cmpq $0, %rax
    je .L_else_705
    leaq .LC_str_160(%rip), %rax
    pushq %rax
    movq -8(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_124(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_706
.L_else_705:
.L_end_706:
    movq -8(%rbp), %rax
    pushq %rax
    popq %rdi
    call read_file
    movq %rax, -16(%rbp)
    call node_arena_reset
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call init_lexer
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    movq -8(%rbp), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call init_parser
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_program
    movq %rax, -40(%rbp)
    movq -32(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_707
    leaq .LC_str_182(%rip), %rax
    pushq %rax
    movq -32(%rbp), %rax
    movq 24(%rax), %rax
    movq %rax, %rdi
    call rubix_rt_int_to_str
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_183(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_708
.L_else_707:
.L_end_708:
    movq -40(%rbp), %rax
    pushq %rax
    popq %rdi
    call evaluate_program
    movq %rbp, %rsp
    popq %rbp
    ret

.globl cmd_doctor
.type cmd_doctor, @function
cmd_doctor:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    leaq .LC_str_184(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_185(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_186(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_187(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_188(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_189(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_190(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_191(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_192(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_193(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl cmd_test
.type cmd_test, @function
cmd_test:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    leaq .LC_str_194(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_195(%rip), %rax
    movq %rax, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    leaq .LC_str_196(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call init_lexer
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call next_token
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    movq 0(%rax), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -24(%rbp), %rax
    movq 8(%rax), %rax
    pushq %rax
    leaq .LC_str_2(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_else_709
    leaq .LC_str_197(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    jmp .L_end_710
.L_else_709:
    leaq .LC_str_198(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
.L_end_710:
    leaq .LC_str_199(%rip), %rax
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    leaq .LC_str_200(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call init_lexer
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    leaq .LC_str_200(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call init_parser
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_program
    movq %rax, -56(%rbp)
    movq -48(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_711
    leaq .LC_str_201(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    jmp .L_end_712
.L_else_711:
    leaq .LC_str_202(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
.L_end_712:
    leaq .LC_str_203(%rip), %rax
    movq %rax, -64(%rbp)
    movq -64(%rbp), %rax
    pushq %rax
    leaq .LC_str_204(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call init_lexer
    movq %rax, -72(%rbp)
    movq -72(%rbp), %rax
    pushq %rax
    leaq .LC_str_204(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call init_parser
    movq %rax, -80(%rbp)
    movq -80(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_program
    movq %rax, -88(%rbp)
    movq -80(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_713
    leaq .LC_str_205(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    jmp .L_end_714
.L_else_713:
    leaq .LC_str_206(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
.L_end_714:
    leaq .LC_str_207(%rip), %rax
    movq %rax, -96(%rbp)
    movq -96(%rbp), %rax
    pushq %rax
    leaq .LC_str_208(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call init_lexer
    movq %rax, -104(%rbp)
    movq -104(%rbp), %rax
    pushq %rax
    leaq .LC_str_208(%rip), %rax
    pushq %rax
    popq %rsi
    popq %rdi
    call init_parser
    movq %rax, -112(%rbp)
    movq -112(%rbp), %rax
    pushq %rax
    popq %rdi
    call parse_program
    movq %rax, -120(%rbp)
    movq -112(%rbp), %rax
    movq 24(%rax), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_715
    leaq .LC_str_209(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    jmp .L_end_716
.L_else_715:
    leaq .LC_str_210(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
.L_end_716:
    leaq .LC_str_211(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl rubix_main
.type rubix_main, @function
rubix_main:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    call get_arg_count
    movq %rax, -8(%rbp)
    movq -8(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_717
    call print_help
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_end_718
.L_else_717:
.L_end_718:
    movq $0, %rax
    pushq %rax
    popq %rdi
    call get_arg
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_108(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_212(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_213(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_719
    call print_help
    movq $0, %rax
    jmp .L_end_720
.L_else_719:
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_214(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_215(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_216(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_else_721
    call print_version
    movq $0, %rax
    jmp .L_end_722
.L_else_721:
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_217(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_723
    call cmd_doctor
    jmp .L_end_724
.L_else_723:
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_218(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_725
    call cmd_test
    jmp .L_end_726
.L_else_725:
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_219(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_727
    call start_repl
    movq $0, %rax
    jmp .L_end_728
.L_else_727:
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_220(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_729
    movq $1, %rax
    pushq %rax
    popq %rdi
    call get_arg
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    pushq %rax
    popq %rdi
    call cmd_check
    jmp .L_end_730
.L_else_729:
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_221(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_731
    movq $1, %rax
    pushq %rax
    popq %rdi
    call get_arg
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    pushq %rax
    popq %rdi
    call cmd_build
    jmp .L_end_732
.L_else_731:
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_222(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_733
    movq $1, %rax
    pushq %rax
    popq %rdi
    call get_arg
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    pushq %rax
    popq %rdi
    call cmd_fmt
    jmp .L_end_734
.L_else_733:
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_223(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_735
    movq $1, %rax
    pushq %rax
    popq %rdi
    call get_arg
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    pushq %rax
    popq %rdi
    call cmd_new
    jmp .L_end_736
.L_else_735:
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_224(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_eq
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_else_737
    movq $1, %rax
    pushq %rax
    popq %rdi
    call get_arg
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    pushq %rax
    popq %rdi
    call cmd_run
    jmp .L_end_738
.L_else_737:
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call file_exists
    cmpq $0, %rax
    je .L_else_739
    movq -16(%rbp), %rax
    pushq %rax
    popq %rdi
    call cmd_run
    jmp .L_end_740
.L_else_739:
    leaq .LC_str_225(%rip), %rax
    pushq %rax
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    pushq %rax
    leaq .LC_str_124(%rip), %rax
    movq %rax, %rbx
    popq %rax
    movq %rax, %rdi
    movq %rbx, %rsi
    call rubix_rt_poly_add
    movq %rax, %rdi
    call rubix_rt_print_poly
    leaq .LC_str_226(%rip), %rax
    movq %rax, %rdi
    call rubix_rt_print_poly
    movq $1, %rax
.L_end_740:
.L_end_738:
.L_end_736:
.L_end_734:
.L_end_732:
.L_end_730:
.L_end_728:
.L_end_726:
.L_end_724:
.L_end_722:
.L_end_720:
    movq %rbp, %rsp
    popq %rbp
    ret

    .section .rodata
.LC_str_0:
    .string "fn"
.LC_str_1:
    .string "def"
.LC_str_2:
    .string "let"
.LC_str_3:
    .string "mut"
.LC_str_4:
    .string "type"
.LC_str_5:
    .string "enum"
.LC_str_6:
    .string "match"
.LC_str_7:
    .string "if"
.LC_str_8:
    .string "else"
.LC_str_9:
    .string "for"
.LC_str_10:
    .string "in"
.LC_str_11:
    .string "loop"
.LC_str_12:
    .string "use"
.LC_str_13:
    .string "return"
.LC_str_14:
    .string "true"
.LC_str_15:
    .string "false"
.LC_str_16:
    .string "do"
.LC_str_17:
    .string "end"
.LC_str_18:
    .string "and"
.LC_str_19:
    .string "or"
.LC_str_20:
    .string "not"
.LC_str_21:
    .string "Unterminated string"
.LC_str_22:
    .string "=="
.LC_str_23:
    .string "=>"
.LC_str_24:
    .string "="
.LC_str_25:
    .string ":="
.LC_str_26:
    .string ":"
.LC_str_27:
    .string "!="
.LC_str_28:
    .string "!"
.LC_str_29:
    .string "<="
.LC_str_30:
    .string "<"
.LC_str_31:
    .string ">="
.LC_str_32:
    .string ">"
.LC_str_33:
    .string "+"
.LC_str_34:
    .string "->"
.LC_str_35:
    .string "-"
.LC_str_36:
    .string "*"
.LC_str_37:
    .string "/"
.LC_str_38:
    .string "%"
.LC_str_39:
    .string "?"
.LC_str_40:
    .string "("
.LC_str_41:
    .string ")"
.LC_str_42:
    .string "{"
.LC_str_43:
    .string "}"
.LC_str_44:
    .string "["
.LC_str_45:
    .string "]"
.LC_str_46:
    .string ","
.LC_str_47:
    .string ".."
.LC_str_48:
    .string "."
.LC_str_49:
    .string ";"
.LC_str_50:
    .string "_"
.LC_str_51:
    .string "Unexpected character"
.LC_str_52:
    .string ""
.LC_str_53:
    .string "error: "
.LC_str_54:
    .string "  --> "
.LC_str_55:
    .string "  actual token: "
.LC_str_56:
    .string "expected ')'"
.LC_str_57:
    .string "list"
.LC_str_58:
    .string "expected ']' to close list literal"
.LC_str_59:
    .string "lambda"
.LC_str_60:
    .string "expected '(' after lambda fn"
.LC_str_61:
    .string "expected parameter name"
.LC_str_62:
    .string "expected type annotation"
.LC_str_63:
    .string "expected ')' after lambda parameters"
.LC_str_64:
    .string "unexpected token in expression: "
.LC_str_65:
    .string "call"
.LC_str_66:
    .string "expected ')' after call arguments"
.LC_str_67:
    .string "expected field name"
.LC_str_68:
    .string "expected ':' after field name"
.LC_str_69:
    .string "expected '}' after struct fields"
.LC_str_70:
    .string "expected ']' after index"
.LC_str_71:
    .string "index"
.LC_str_72:
    .string "expected member identifier after '.'"
.LC_str_73:
    .string "expected identifier after 'let'"
.LC_str_74:
    .string "expected '=' in let binding"
.LC_str_75:
    .string "expected identifier after 'mut'"
.LC_str_76:
    .string "expected '=' in mut binding"
.LC_str_77:
    .string "block"
.LC_str_78:
    .string "expected '}' to close block"
.LC_str_79:
    .string "expected block '{'"
.LC_str_80:
    .string "expected '{' after match target"
.LC_str_81:
    .string "expected ')' after pattern parameters"
.LC_str_82:
    .string "expected '=>' after match pattern"
.LC_str_83:
    .string "arm"
.LC_str_84:
    .string "expected '}' to close match expression"
.LC_str_85:
    .string "expected loop variable after 'for'"
.LC_str_86:
    .string "expected 'in' after for variable"
.LC_str_87:
    .string "expected 'end' to close loop"
.LC_str_88:
    .string "expected function name"
.LC_str_89:
    .string "expected ']' after generic parameters"
.LC_str_90:
    .string "expected '(' after function name"
.LC_str_91:
    .string "expected parameter type annotation"
.LC_str_92:
    .string "expected ']' after generic type arguments"
.LC_str_93:
    .string "expected ')' after parameter list"
.LC_str_94:
    .string "expected return type annotation"
.LC_str_95:
    .string "expected 'end' to close function"
.LC_str_96:
    .string "expected type name"
.LC_str_97:
    .string "expected field type"
.LC_str_98:
    .string "expected 'end' after type declaration"
.LC_str_99:
    .string "expected enum name"
.LC_str_100:
    .string "expected '{' after enum name"
.LC_str_101:
    .string "expected variant name"
.LC_str_102:
    .string "expected ')' after variant payload types"
.LC_str_103:
    .string "expected '}' after enum variants"
.LC_str_104:
    .string "program"
.LC_str_105:
    .string "error"
.LC_str_106:
    .string "warning"
.LC_str_107:
    .string "note"
.LC_str_108:
    .string "help"
.LC_str_109:
    .string "info"
.LC_str_110:
    .string ": "
.LC_str_111:
    .string "\n"
.LC_str_112:
    .string "  = help: "
.LC_str_113:
    .string "Void"
.LC_str_114:
    .string "Int"
.LC_str_115:
    .string "Float"
.LC_str_116:
    .string "Bool"
.LC_str_117:
    .string "String"
.LC_str_118:
    .string "Struct"
.LC_str_119:
    .string "Enum"
.LC_str_120:
    .string "Function"
.LC_str_121:
    .string "Unknown"
.LC_str_122:
    .string "mismatched types: expected `"
.LC_str_123:
    .string "`, found `"
.LC_str_124:
    .string "`"
.LC_str_125:
    .string "ensure operand types match expected signature"
.LC_str_126:
    .string " "
.LC_str_127:
    .string "()"
.LC_str_128:
    .string "Division by zero"
.LC_str_129:
    .string "main"
.LC_str_130:
    .string "Rubix Interactive Shell (v1.0.0)"
.LC_str_131:
    .string "General-Purpose Language Environment"
.LC_str_132:
    .string "Type expressions, definitions, or 'exit' to quit."
.LC_str_133:
    .string "---"
.LC_str_134:
    .string "Ready."
.LC_str_135:
    .string "    "
.LC_str_136:
    .string ""
.LC_str_137:
    .string "rubix <command>"
.LC_str_138:
    .string ""
.LC_str_139:
    .string "Usage:"
.LC_str_140:
    .string ""
.LC_str_141:
    .string "All commands:"
.LC_str_142:
    .string "rubix run <file.bix>        compile and execute a Rubix file"
.LC_str_143:
    .string "rubix build <file.bix>      compile to standalone native binary"
.LC_str_144:
    .string "rubix check <file.bix>      typecheck and verify source code"
.LC_str_145:
    .string "rubix fmt <file.bix>        format source code"
.LC_str_146:
    .string "rubix init <name>           create a new Rubix project"
.LC_str_147:
    .string "rubix pkg <command>         manage packages and dependencies"
.LC_str_148:
    .string "rubix repl                  start interactive REPL"
.LC_str_149:
    .string "rubix doctor                verify toolchain diagnostics"
.LC_str_150:
    .string "rubix version               display version info"
.LC_str_151:
    .string "rubix help <term>           search help for a command"
.LC_str_152:
    .string ""
.LC_str_153:
    .string "rubix <command> -h          quick help on <command>"
.LC_str_154:
    .string "rubix -v                    display language version"
.LC_str_155:
    .string "rubix 1.0.0 (x86_64-linux)"
.LC_str_156:
    .string ""
.LC_str_157:
    .string ""
.LC_str_158:
    .string "error: missing required file path for 'check' command"
.LC_str_159:
    .string "usage: rubix check <file.bix>"
.LC_str_160:
    .string "error: file not found: `"
.LC_str_161:
    .string "check: FAILED ("
.LC_str_162:
    .string " syntax errors)"
.LC_str_163:
    .string " semantic errors)"
.LC_str_164:
    .string " type errors)"
.LC_str_165:
    .string "check: OK ("
.LC_str_166:
    .string " validated successfully, "
.LC_str_167:
    .string " AST nodes)"
.LC_str_168:
    .string "error: missing required file path for 'build' command"
.LC_str_169:
    .string "usage: rubix build <file.bix>"
.LC_str_170:
    .string "build: OK (verified "
.LC_str_171:
    .string "error: missing required file path for 'fmt' command"
.LC_str_172:
    .string "usage: rubix fmt <file.bix>"
.LC_str_173:
    .string "formatted: "
.LC_str_174:
    .string "error: missing project name"
.LC_str_175:
    .string "usage: rubix new <project_name>"
.LC_str_176:
    .string "Creating new Rubix project: "
.LC_str_177:
    .string "  Created "
.LC_str_178:
    .string "/src/main.bix"
.LC_str_179:
    .string "/rubix.pkg"
.LC_str_180:
    .string "error: missing required file path for 'run' command"
.LC_str_181:
    .string "usage: rubix run <file.bix>"
.LC_str_182:
    .string "Execution aborted: "
.LC_str_183:
    .string " syntax errors encountered."
.LC_str_184:
    .string "Rubix toolchain diagnostics:"
.LC_str_185:
    .string "  Lexer: OK"
.LC_str_186:
    .string "  Parser: OK"
.LC_str_187:
    .string "  Semantics: OK"
.LC_str_188:
    .string "  Typechecker: OK"
.LC_str_189:
    .string "  Optimizer: OK"
.LC_str_190:
    .string "  Codegen: OK"
.LC_str_191:
    .string "  Runtime: OK"
.LC_str_192:
    .string "  Diagnostics: OK"
.LC_str_193:
    .string "All subsystems operational."
.LC_str_194:
    .string "Running Rubix core engine self-tests..."
.LC_str_195:
    .string "let answer = 42"
.LC_str_196:
    .string "<test1>"
.LC_str_197:
    .string "  [PASS] Keyword tokenization"
.LC_str_198:
    .string "  [FAIL] Keyword tokenization"
.LC_str_199:
    .string "fn add(a: Integer, b: Integer): Integer { a + b }"
.LC_str_200:
    .string "<test2>"
.LC_str_201:
    .string "  [PASS] Function declaration parsing"
.LC_str_202:
    .string "  [FAIL] Function declaration parsing"
.LC_str_203:
    .string "fn test_match(x: Integer): Integer { match x { 0 => 10, _ => 20 } }"
.LC_str_204:
    .string "<test3>"
.LC_str_205:
    .string "  [PASS] Pattern match expression parsing"
.LC_str_206:
    .string "  [FAIL] Pattern match expression parsing"
.LC_str_207:
    .string "type Point { x: Integer, y: Integer }"
.LC_str_208:
    .string "<test4>"
.LC_str_209:
    .string "  [PASS] User-defined struct parsing"
.LC_str_210:
    .string "  [FAIL] User-defined struct parsing"
.LC_str_211:
    .string "All Rubix language unit tests passed successfully."
.LC_str_212:
    .string "--help"
.LC_str_213:
    .string "-h"
.LC_str_214:
    .string "version"
.LC_str_215:
    .string "--version"
.LC_str_216:
    .string "-v"
.LC_str_217:
    .string "doctor"
.LC_str_218:
    .string "test"
.LC_str_219:
    .string "repl"
.LC_str_220:
    .string "check"
.LC_str_221:
    .string "build"
.LC_str_222:
    .string "fmt"
.LC_str_223:
    .string "new"
.LC_str_224:
    .string "run"
.LC_str_225:
    .string "error: unknown command `"
.LC_str_226:
    .string "run 'rubix --help' for available commands"
.LC_str_dash_o:
    .string "-o"
.LC_str_out_ext:
    .string ".out"
.LC_str_all_cmds_1:
    .string "    build, check, clean, doctor, fmt, help, init, lsp,"
.LC_str_all_cmds_2:
    .string "    new, pkg, repl, run, selfhost, test, version"
.LC_str_cfg_1:
    .string "Specify configs in the toml file:"
.LC_str_cfg_2:
    .string "    rubix.toml (package) or ~/.rubix/config.toml"
.LC_str_cfg_3:
    .string "or on the command line via: rubix <command> --flag"
.LC_str_more_info:
    .string "More info: rubix help <command>"
.LC_str_pkg_path:
    .string "rubix@1.0.0"
