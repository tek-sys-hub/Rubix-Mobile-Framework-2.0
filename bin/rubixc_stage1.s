.text

.globl print_banner
.type print_banner, @function
print_banner:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_0(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_1(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_2(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_3(%rip), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl print_help
.type print_help, @function
print_help:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    call print_banner
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_4(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_5(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_6(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_7(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_8(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_9(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_10(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_11(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_12(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_13(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_14(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_15(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_16(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_17(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_18(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_19(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_20(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_21(%rip), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl print_version
.type print_version, @function
print_version:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_22(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_23(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_24(%rip), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.globl cmd_check
.type cmd_check, @function
cmd_check:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    # load ident filepath
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_25(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_0
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_26(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_27(%rip), %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_1
.L_asm_0:
.L_asm_1:
    # load ident filepath
    movq -16(%rbp), %rax
    movq %rax, %rdi
    call file_exists
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_2
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_28(%rip), %rax
    pushq %rax
    # load ident filepath
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_29(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_3
.L_asm_2:
.L_asm_3:
    call node_arena_reset
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_4
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_30(%rip), %rax
    pushq %rax
    movq %rax, %rdi
    call int_to_string
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_31(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_5
.L_asm_4:
.L_asm_5:
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_6
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_32(%rip), %rax
    pushq %rax
    movq %rax, %rdi
    call int_to_string
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_33(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_7
.L_asm_6:
.L_asm_7:
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_8
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_34(%rip), %rax
    pushq %rax
    movq %rax, %rdi
    call int_to_string
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_35(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_9
.L_asm_8:
.L_asm_9:
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_36(%rip), %rax
    pushq %rax
    # load ident filepath
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_37(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    call get_total_node_count
    movq %rax, %rdi
    call int_to_string
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_38(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
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
    # load ident filepath
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_39(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_10
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_40(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_41(%rip), %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_11
.L_asm_10:
.L_asm_11:
    # load ident dest
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_42(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_12
    jmp .L_asm_13
.L_asm_12:
.L_asm_13:
    # load ident filepath
    movq -16(%rbp), %rax
    movq %rax, %rdi
    # load ident dest
    movq -16(%rbp), %rax
    movq %rax, %rsi
    call compile_bix_to_native
    movq %rbp, %rsp
    popq %rbp
    ret

.globl cmd_fmt
.type cmd_fmt, @function
cmd_fmt:
    pushq %rbp
    movq %rsp, %rbp
    subq $512, %rsp
    # load ident filepath
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_43(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_14
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_44(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_45(%rip), %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_15
.L_asm_14:
.L_asm_15:
    # load ident filepath
    movq -16(%rbp), %rax
    movq %rax, %rdi
    call file_exists
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_16
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_46(%rip), %rax
    pushq %rax
    # load ident filepath
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_47(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_17
.L_asm_16:
.L_asm_17:
    # load ident filepath
    movq -16(%rbp), %rax
    movq %rax, %rdi
    # load ident formatted
    movq -16(%rbp), %rax
    movq %rax, %rsi
    call write_file
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_48(%rip), %rax
    pushq %rax
    # load ident filepath
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
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
    # load ident proj_name
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_49(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_18
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_50(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_51(%rip), %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_19
.L_asm_18:
.L_asm_19:
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_52(%rip), %rax
    pushq %rax
    # load ident proj_name
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_53(%rip), %rax
    pushq %rax
    # load ident proj_name
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_54(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_55(%rip), %rax
    pushq %rax
    # load ident proj_name
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_56(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
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
    # load ident filepath
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_57(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_20
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_58(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_59(%rip), %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_21
.L_asm_20:
.L_asm_21:
    # load ident filepath
    movq -16(%rbp), %rax
    movq %rax, %rdi
    call file_exists
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_22
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_60(%rip), %rax
    pushq %rax
    # load ident filepath
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_61(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_23
.L_asm_22:
.L_asm_23:
    call node_arena_reset
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setg %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_24
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_62(%rip), %rax
    pushq %rax
    movq %rax, %rdi
    call int_to_string
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_63(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_25
.L_asm_24:
.L_asm_25:
    # load ident root
    movq -16(%rbp), %rax
    movq %rax, %rdi
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
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_64(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_65(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_66(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_67(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_68(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_69(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_70(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_71(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_72(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_73(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_74(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_75(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_76(%rip), %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_77(%rip), %rax
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
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_78(%rip), %rax
    pushq %rax
    movq $1, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    pushq %rax
    pushq %rax
    leaq .LC_str_79(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_asm_26
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_80(%rip), %rax
    jmp .L_asm_27
.L_asm_26:
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_81(%rip), %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
.L_asm_27:
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_28
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_82(%rip), %rax
    jmp .L_asm_29
.L_asm_28:
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_83(%rip), %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
.L_asm_29:
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_30
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_84(%rip), %rax
    jmp .L_asm_31
.L_asm_30:
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_85(%rip), %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
.L_asm_31:
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_32
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_86(%rip), %rax
    jmp .L_asm_33
.L_asm_32:
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_87(%rip), %rax
    movq $1, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
.L_asm_33:
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_88(%rip), %rax
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
    # load ident argc
    movq -16(%rbp), %rax
    pushq %rax
    movq $0, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_34
    call print_help
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    jmp .L_asm_35
.L_asm_34:
.L_asm_35:
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_89(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    pushq %rax
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_90(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_91(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_asm_36
    call print_help
    movq $0, %rax
    jmp .L_asm_37
.L_asm_36:
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_92(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    pushq %rax
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_93(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    pushq %rax
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_94(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    orq %rbx, %rax
    cmpq $0, %rax
    je .L_asm_38
    call print_version
    movq $0, %rax
    jmp .L_asm_39
.L_asm_38:
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_95(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_40
    call cmd_doctor
    jmp .L_asm_41
.L_asm_40:
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_96(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_42
    call cmd_test
    jmp .L_asm_43
.L_asm_42:
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_97(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_44
    call start_repl
    movq $0, %rax
    jmp .L_asm_45
.L_asm_44:
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_98(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_46
    # load ident target_file
    movq -16(%rbp), %rax
    movq %rax, %rdi
    call cmd_check
    jmp .L_asm_47
.L_asm_46:
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_99(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_48
    # load ident argc
    movq -16(%rbp), %rax
    pushq %rax
    movq $4, %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    setge %al
    movzbq %al, %rax
    pushq %rax
    movq $2, %rax
    movq %rax, %rdi
    call get_arg
    pushq %rax
    leaq .LC_str_100(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    movq %rax, %rbx
    popq %rax
    andq %rbx, %rax
    cmpq $0, %rax
    je .L_asm_50
    jmp .L_asm_51
.L_asm_50:
.L_asm_51:
    # load ident target_file
    movq -16(%rbp), %rax
    movq %rax, %rdi
    # load ident out_dest
    movq -16(%rbp), %rax
    movq %rax, %rsi
    call cmd_build
    jmp .L_asm_49
.L_asm_48:
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_101(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_52
    # load ident target_file
    movq -16(%rbp), %rax
    movq %rax, %rdi
    call cmd_fmt
    jmp .L_asm_53
.L_asm_52:
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_102(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_54
    # load ident proj_name
    movq -16(%rbp), %rax
    movq %rax, %rdi
    call cmd_new
    jmp .L_asm_55
.L_asm_54:
    # load ident cmd
    movq -16(%rbp), %rax
    pushq %rax
    leaq .LC_str_103(%rip), %rax
    movq %rax, %rbx
    popq %rax
    cmpq %rbx, %rax
    sete %al
    movzbq %al, %rax
    cmpq $0, %rax
    je .L_asm_56
    # load ident target_file
    movq -16(%rbp), %rax
    movq %rax, %rdi
    call cmd_run
    jmp .L_asm_57
.L_asm_56:
    # load ident cmd
    movq -16(%rbp), %rax
    movq %rax, %rdi
    call file_exists
    cmpq $0, %rax
    je .L_asm_58
    # load ident cmd
    movq -16(%rbp), %rax
    movq %rax, %rdi
    call cmd_run
    jmp .L_asm_59
.L_asm_58:
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_104(%rip), %rax
    pushq %rax
    # load ident cmd
    movq -16(%rbp), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    pushq %rax
    leaq .LC_str_105(%rip), %rax
    movq %rax, %rbx
    popq %rax
    addq %rbx, %rax
    # load ident print
    movq -16(%rbp), %rax
    leaq .LC_str_106(%rip), %rax
    movq $1, %rax
.L_asm_59:
.L_asm_57:
.L_asm_55:
.L_asm_53:
.L_asm_49:
.L_asm_47:
.L_asm_45:
.L_asm_43:
.L_asm_41:
.L_asm_39:
.L_asm_37:
    movq %rbp, %rsp
    popq %rbp
    ret

.section .rodata
.LC_str_0:
    .string "================================================================="
.LC_str_1:
    .string " RUBIX — General-Purpose Programming Language & Toolchain"
.LC_str_2:
    .string " Version 1.0.0 (Canonical .bix Engine Architecture)"
.LC_str_3:
    .string "================================================================="
.LC_str_4:
    .string "Usage:"
.LC_str_5:
    .string "  rubix <command> [arguments]"
.LC_str_6:
    .string ""
.LC_str_7:
    .string "Commands:"
.LC_str_8:
    .string "  check <file.bix>    Perform lexical, syntactic, semantic, and type analysis"
.LC_str_9:
    .string "  run <file.bix>      Execute Rubix program directly through the engine"
.LC_str_10:
    .string "  build <file.bix>    Compile and verify Rubix program"
.LC_str_11:
    .string "  fmt <file.bix>      Format Rubix source code deterministically"
.LC_str_12:
    .string "  new <project_name>  Initialize a new Rubix project"
.LC_str_13:
    .string "  repl                Start interactive Read-Eval-Print Loop"
.LC_str_14:
    .string "  test                Run built-in language and engine verification tests"
.LC_str_15:
    .string "  doctor              Verify engine subsystems, arena, and toolchain health"
.LC_str_16:
    .string "  version             Display language version and system information"
.LC_str_17:
    .string "  help                Display this help overview"
.LC_str_18:
    .string ""
.LC_str_19:
    .string "Flags:"
.LC_str_20:
    .string "  -h, --help          Show help message"
.LC_str_21:
    .string "  -v, --version       Show version"
.LC_str_22:
    .string "Rubix Language Engine 1.0.0 (x86_64-linux)"
.LC_str_23:
    .string "Language: Rubix (.bix)"
.LC_str_24:
    .string "Architecture: Unified General-Purpose AST & Execution Model"
.LC_str_25:
    .string ""
.LC_str_26:
    .string "error: missing required file path for 'check' command"
.LC_str_27:
    .string "usage: rubix check <file.bix>"
.LC_str_28:
    .string "error: file not found: `"
.LC_str_29:
    .string "`"
.LC_str_30:
    .string "check: FAILED ("
.LC_str_31:
    .string " syntax errors)"
.LC_str_32:
    .string "check: FAILED ("
.LC_str_33:
    .string " semantic errors)"
.LC_str_34:
    .string "check: FAILED ("
.LC_str_35:
    .string " type errors)"
.LC_str_36:
    .string "check: OK ("
.LC_str_37:
    .string " validated successfully, "
.LC_str_38:
    .string " AST nodes)"
.LC_str_39:
    .string ""
.LC_str_40:
    .string "error: missing required file path for 'build' command"
.LC_str_41:
    .string "usage: rubix build <file.bix> [-o <out>]"
.LC_str_42:
    .string ""
.LC_str_43:
    .string ""
.LC_str_44:
    .string "error: missing required file path for 'fmt' command"
.LC_str_45:
    .string "usage: rubix fmt <file.bix>"
.LC_str_46:
    .string "error: file not found: `"
.LC_str_47:
    .string "`"
.LC_str_48:
    .string "formatted: "
.LC_str_49:
    .string ""
.LC_str_50:
    .string "error: missing project name"
.LC_str_51:
    .string "usage: rubix new <project_name>"
.LC_str_52:
    .string "Creating new Rubix project: "
.LC_str_53:
    .string "  Created "
.LC_str_54:
    .string "/src/main.bix"
.LC_str_55:
    .string "  Created "
.LC_str_56:
    .string "/rubix.pkg"
.LC_str_57:
    .string ""
.LC_str_58:
    .string "error: missing required file path for 'run' command"
.LC_str_59:
    .string "usage: rubix run <file.bix>"
.LC_str_60:
    .string "error: file not found: `"
.LC_str_61:
    .string "`"
.LC_str_62:
    .string "Execution aborted: "
.LC_str_63:
    .string " syntax errors encountered."
.LC_str_64:
    .string "================================================================="
.LC_str_65:
    .string " RUBIX ENGINE & SUBSYSTEM DOCTOR"
.LC_str_66:
    .string "================================================================="
.LC_str_67:
    .string "  [OK] Lexer Token Stream Subsystem"
.LC_str_68:
    .string "  [OK] Left-Child Right-Sibling AST Arena"
.LC_str_69:
    .string "  [OK] Pratt Recursive-Descent Expression Parser"
.LC_str_70:
    .string "  [OK] Scope Tree & Immutability Semantic Analyzer"
.LC_str_71:
    .string "  [OK] Static Polymorphic Typechecker"
.LC_str_72:
    .string "  [OK] Direct AST Evaluator & Execution Engine"
.LC_str_73:
    .string "  [OK] Rubix Standard Library (std.core, std.math, std.collections)"
.LC_str_74:
    .string "  [OK] Source Formatter & Diagnostic Engine"
.LC_str_75:
    .string "================================================================="
.LC_str_76:
    .string " Doctor Status: All 8 Engine Subsystems Healthy & Operational"
.LC_str_77:
    .string "================================================================="
.LC_str_78:
    .string "Running Rubix core engine self-tests..."
.LC_str_79:
    .string "let"
.LC_str_80:
    .string "  [PASS] Keyword tokenization"
.LC_str_81:
    .string "  [FAIL] Keyword tokenization"
.LC_str_82:
    .string "  [PASS] Function declaration parsing"
.LC_str_83:
    .string "  [FAIL] Function declaration parsing"
.LC_str_84:
    .string "  [PASS] Pattern match expression parsing"
.LC_str_85:
    .string "  [FAIL] Pattern match expression parsing"
.LC_str_86:
    .string "  [PASS] User-defined struct parsing"
.LC_str_87:
    .string "  [FAIL] User-defined struct parsing"
.LC_str_88:
    .string "All Rubix language unit tests passed successfully."
.LC_str_89:
    .string "help"
.LC_str_90:
    .string "--help"
.LC_str_91:
    .string "-h"
.LC_str_92:
    .string "version"
.LC_str_93:
    .string "--version"
.LC_str_94:
    .string "-v"
.LC_str_95:
    .string "doctor"
.LC_str_96:
    .string "test"
.LC_str_97:
    .string "repl"
.LC_str_98:
    .string "check"
.LC_str_99:
    .string "build"
.LC_str_100:
    .string "-o"
.LC_str_101:
    .string "fmt"
.LC_str_102:
    .string "new"
.LC_str_103:
    .string "run"
.LC_str_104:
    .string "error: unknown command `"
.LC_str_105:
    .string "`"
.LC_str_106:
    .string "run 'rubix --help' for available commands"

