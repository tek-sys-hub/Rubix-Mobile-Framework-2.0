# Complete zero-C native runtime using direct Linux system calls

.data
.globl g_argc
.globl g_argv
g_argc: .quad 0
g_argv: .quad 0

# Heap memory bump allocator state (64MB pool)
.align 16
heap_base: .quad 0
heap_curr: .quad 0
heap_end:  .quad 0

# AST Arena state (1,000,000 nodes)
# Node structure: kind(8), line(8), col(8), child(8), sibling(8), type_id(8), text_ptr(8), pad(8) = 64 bytes per node
.globl g_node_count
g_node_count: .quad 0
node_arena_ptr: .quad 0

# Static buffers
out_buf: .space 64
str_char_buf: .space 2
empty_str: .string ""
newline_str: .string "\n"
str_true: .string "true"
str_false: .string "false"
str_unit: .string "()"
panic_prefix: .string "Rubix Runtime Panic: "
assert_fail_msg: .string "Assertion failed\n"

.text


.section .text.sys_read, "ax", @progbits
.globl sys_read
.type sys_read, @function
sys_read:
    movq $0, %rax       # SYS_read
    syscall
    ret

.section .text.sys_write, "ax", @progbits
.globl sys_write
.type sys_write, @function
sys_write:
    movq $1, %rax       # SYS_write
    syscall
    ret

.section .text.sys_open, "ax", @progbits
.globl sys_open
.type sys_open, @function
sys_open:
    movq $2, %rax       # SYS_open
    syscall
    ret

.section .text.sys_close, "ax", @progbits
.globl sys_close
.type sys_close, @function
sys_close:
    movq $3, %rax       # SYS_close
    syscall
    ret

.section .text.sys_mmap, "ax", @progbits
.globl sys_mmap
.type sys_mmap, @function
sys_mmap:
    movq %rcx, %r10     # In x86_64 syscalls, 4th arg is r10 (not rcx)
    movq $9, %rax       # SYS_mmap
    syscall
    ret

.section .text.sys_fork, "ax", @progbits
.globl sys_fork
.type sys_fork, @function
sys_fork:
    movq $57, %rax      # SYS_fork
    syscall
    ret

.section .text.sys_execve, "ax", @progbits
.globl sys_execve
.type sys_execve, @function
sys_execve:
    movq $59, %rax      # SYS_execve
    syscall
    ret

.section .text.sys_exit, "ax", @progbits
.globl sys_exit
.type sys_exit, @function
sys_exit:
    movq $60, %rax      # SYS_exit
    syscall
    ret

.section .text.sys_wait4, "ax", @progbits
.globl sys_wait4
.type sys_wait4, @function
sys_wait4:
    movq %rcx, %r10
    movq $61, %rax      # SYS_wait4
    syscall
    ret


.section .text.rubix_rt_init_heap, "ax", @progbits
.globl rubix_rt_init_heap
.type rubix_rt_init_heap, @function
rubix_rt_init_heap:
    movq heap_base(%rip), %rax
    cmpq $0, %rax
    jne .L_heap_already_init
    
    # mmap(0, 67108864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
    movq $0, %rdi
    movq $67108864, %rsi    # 64 MB
    movq $3, %rdx           # PROT_READ | PROT_WRITE
    movq $34, %r10          # MAP_PRIVATE | MAP_ANONYMOUS
    movq $-1, %r8
    movq $0, %r9
    movq $9, %rax           # SYS_mmap
    syscall
    
    cmpq $0, %rax
    jl .L_mmap_fail
    movq %rax, heap_base(%rip)
    movq %rax, heap_curr(%rip)
    addq $67108864, %rax
    movq %rax, heap_end(%rip)

    # Allocate Node Arena (64MB)
    movq $0, %rdi
    movq $67108864, %rsi
    movq $3, %rdx
    movq $34, %r10
    movq $-1, %r8
    movq $0, %r9
    movq $9, %rax
    syscall
    movq %rax, node_arena_ptr(%rip)
.L_heap_already_init:
    ret
.L_mmap_fail:
    movq $1, %rdi
    call sys_exit

.section .text.rubix_rt_alloc, "ax", @progbits
.globl rubix_rt_alloc
.section .text.alloc, "ax", @progbits
.globl alloc
.type rubix_rt_alloc, @function
.type alloc, @function
rubix_rt_alloc:
alloc:
    # Fast 3-instruction bump allocator
    addq $15, %rdi
    andq $-16, %rdi
    cmpq $16, %rdi
    jge .L_alloc_sz_ok
    movq $16, %rdi
.L_alloc_sz_ok:
    movq heap_curr(%rip), %rax
    cmpq $0, %rax
    je .L_alloc_init
    leaq (%rax, %rdi), %rdx
    cmpq heap_end(%rip), %rdx
    jae .L_oom
    movq %rdx, heap_curr(%rip)
    ret
.L_alloc_init:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rdi
    call rubix_rt_init_heap
    popq %rdi
    movq heap_curr(%rip), %rax
    leaq (%rax, %rdi), %rdx
    movq %rdx, heap_curr(%rip)
    movq %rbp, %rsp
    popq %rbp
    ret
.L_oom:
    leaq panic_prefix(%rip), %rdi
    call rubix_rt_panic
    movq $0, %rax
    ret

.section .text.rubix_rt_free, "ax", @progbits
.globl rubix_rt_free
.section .text.free, "ax", @progbits
.globl free
rubix_rt_free:
free:
    ret


.section .text.rubix_rt_init, "ax", @progbits
.globl rubix_rt_init
rubix_rt_init:
    movq %rdi, g_argc(%rip)
    movq %rsi, g_argv(%rip)
    call rubix_rt_init_heap
    ret

.section .text.rubix_rt_get_arg_count, "ax", @progbits
.globl rubix_rt_get_arg_count
.section .text.get_arg_count, "ax", @progbits
.globl get_arg_count
rubix_rt_get_arg_count:
get_arg_count:
    movq g_argc(%rip), %rax
    cmpq $1, %rax
    jle .L_zero_args
    subq $1, %rax
    ret
.L_zero_args:
    movq $0, %rax
    ret

.section .text.rubix_rt_get_arg, "ax", @progbits
.globl rubix_rt_get_arg
.section .text.get_arg, "ax", @progbits
.globl get_arg
rubix_rt_get_arg:
get_arg:
    # arg0: idx
    addq $1, %rdi           # skip argv[0]
    movq g_argc(%rip), %rax
    cmpq %rax, %rdi
    jge .L_arg_oob
    movq g_argv(%rip), %rax
    cmpq $0, %rax
    je .L_arg_oob
    movq (%rax, %rdi, 8), %rax
    ret
.L_arg_oob:
    leaq empty_str(%rip), %rax
    ret


.section .text.rubix_rt_str_len, "ax", @progbits
.globl rubix_rt_str_len
.section .text.string_length, "ax", @progbits
.globl string_length
rubix_rt_str_len:
string_length:
    cmpq $0, %rdi
    je .L_strlen_zero
    movq %rdi, %rax
.L_strlen_loop:
    cmpb $0, (%rax)
    je .L_strlen_done
    incq %rax
    jmp .L_strlen_loop
.L_strlen_done:
    subq %rdi, %rax
    ret
.L_strlen_zero:
    movq $0, %rax
    ret

.section .text.rubix_rt_str_eq, "ax", @progbits
.globl rubix_rt_str_eq
rubix_rt_str_eq:
    cmpq %rdi, %rsi
    je .L_streq_true
    cmpq $0, %rdi
    je .L_streq_false
    cmpq $0, %rsi
    je .L_streq_false
.L_streq_loop:
    movb (%rdi), %al
    movb (%rsi), %cl
    cmpb %cl, %al
    jne .L_streq_false
    cmpb $0, %al
    je .L_streq_true
    incq %rdi
    incq %rsi
    jmp .L_streq_loop
.L_streq_true:
    movq $1, %rax
    ret
.L_streq_false:
    movq $0, %rax
    ret

.section .text.rubix_rt_str_concat, "ax", @progbits
.globl rubix_rt_str_concat
rubix_rt_str_concat:
    pushq %rbp
    movq %rsp, %rbp
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    
    movq %rdi, %r12     # src a
    movq %rsi, %r13     # src b
    
    movq %r12, %rdi
    call rubix_rt_str_len
    movq %rax, %r14     # len a
    
    movq %r13, %rdi
    call rubix_rt_str_len
    movq %rax, %r15     # len b
    
    leaq 1(%r14, %r15), %rdi
    call rubix_rt_alloc
    
    pushq %rax          # save dest ptr
    
    # Fast microcode copy a
    movq %rax, %rdi
    movq %r12, %rsi
    movq %r14, %rcx
    rep movsb
    
    # Fast microcode copy b (including null terminator)
    movq %r13, %rsi
    leaq 1(%r15), %rcx
    rep movsb
    
    popq %rax
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret

.section .text.rubix_rt_str_char_at, "ax", @progbits
.globl rubix_rt_str_char_at
.section .text.char_at, "ax", @progbits
.globl char_at
rubix_rt_str_char_at:
char_at:
    # rdi: str, rsi: idx
    cmpq $0, %rdi
    je .L_char_empty
    movb (%rdi, %rsi), %al
    movb %al, str_char_buf(%rip)
    movb $0, str_char_buf+1(%rip)
    leaq str_char_buf(%rip), %rax
    ret
.L_char_empty:
    leaq empty_str(%rip), %rax
    ret

.section .text.rubix_rt_str_byte_at, "ax", @progbits
.globl rubix_rt_str_byte_at
.section .text.byte_at, "ax", @progbits
.globl byte_at
rubix_rt_str_byte_at:
byte_at:
    cmpq $0, %rdi
    je .L_byte_zero
    movzbq (%rdi, %rsi), %rax
    ret
.L_byte_zero:
    movq $0, %rax
    ret

.section .text.rubix_rt_str_substring, "ax", @progbits
.globl rubix_rt_str_substring
.section .text.substring, "ax", @progbits
.globl substring
rubix_rt_str_substring:
substring:
    # rdi: s, rsi: start, rdx: end
    pushq %rbp
    movq %rsp, %rbp
    pushq %r12
    pushq %r13
    pushq %r14
    
    movq %rdi, %r12     # s
    movq %rsi, %r13     # start
    movq %rdx, %r14
    subq %rsi, %r14     # len = end - start
    
    cmpq $0, %r14
    jle .L_sub_empty
    
    movq %r14, %rdi
    addq $1, %rdi
    call rubix_rt_alloc
    
    movq $0, %rcx
.L_sub_copy:
    cmpq %r14, %rcx
    jge .L_sub_finish
    movq %r13, %rdx
    addq %rcx, %rdx
    movb (%r12, %rdx), %r8b
    movb %r8b, (%rax, %rcx)
    incq %rcx
    jmp .L_sub_copy
.L_sub_finish:
    movb $0, (%rax, %rcx)
    popq %r14
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret
.L_sub_empty:
    leaq empty_str(%rip), %rax
    popq %r14
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret

.section .text.rubix_rt_int_to_str, "ax", @progbits
.globl rubix_rt_int_to_str
.section .text.int_to_string, "ax", @progbits
.globl int_to_string
.section .text.text, "ax", @progbits
.globl text
rubix_rt_int_to_str:
int_to_string:
text:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    
    movq %rdi, %rax
    movq $0, %rbx       # negative flag
    cmpq $0, %rax
    jge .L_pos_int
    negq %rax
    movq $1, %rbx
.L_pos_int:
    leaq out_buf+32(%rip), %rdi
    movb $0, (%rdi)
    movq $10, %rcx
.L_int_loop:
    decq %rdi
    movq $0, %rdx
    divq %rcx
    addb $48, %dl
    movb %dl, (%rdi)
    cmpq $0, %rax
    jne .L_int_loop
    
    cmpq $1, %rbx
    jne .L_int_str_copy
    decq %rdi
    movb $45, (%rdi)    # '-'
.L_int_str_copy:
    # duplicate string into heap
    pushq %rdi
    call rubix_rt_str_len
    movq %rax, %rcx
    popq %rsi
    
    pushq %rsi
    pushq %rcx
    movq %rcx, %rdi
    addq $1, %rdi
    call rubix_rt_alloc
    popq %rcx
    popq %rsi
    
    movq $0, %rdx
.L_int_dup:
    cmpq %rcx, %rdx
    jge .L_int_dup_end
    movb (%rsi, %rdx), %r8b
    movb %r8b, (%rax, %rdx)
    incq %rdx
    jmp .L_int_dup
.L_int_dup_end:
    movb $0, (%rax, %rdx)
    popq %rbx
    movq %rbp, %rsp
    popq %rbp
    ret

.section .text.rubix_rt_str_to_int, "ax", @progbits
.globl rubix_rt_str_to_int
.section .text.string_to_int, "ax", @progbits
.globl string_to_int
rubix_rt_str_to_int:
string_to_int:
    movq $0, %rax
    cmpq $0, %rdi
    je .L_atoi_done
    movq $1, %rcx       # sign
    cmpb $45, (%rdi)    # '-'
    jne .L_atoi_loop
    movq $-1, %rcx
    incq %rdi
.L_atoi_loop:
    movzbq (%rdi), %rdx
    cmpq $48, %rdx
    jl .L_atoi_sign
    cmpq $57, %rdx
    jg .L_atoi_sign
    subq $48, %rdx
    imulq $10, %rax
    addq %rdx, %rax
    incq %rdi
    jmp .L_atoi_loop
.L_atoi_sign:
    imulq %rcx, %rax
.L_atoi_done:
    ret

.section .text.rubix_rt_str_starts_with, "ax", @progbits
.globl rubix_rt_str_starts_with
.section .text.starts_with, "ax", @progbits
.globl starts_with
rubix_rt_str_starts_with:
starts_with:
    cmpq $0, %rdi
    je .L_sw_false
    cmpq $0, %rsi
    je .L_sw_false
.L_sw_loop:
    movb (%rsi), %cl
    cmpb $0, %cl
    je .L_sw_true
    movb (%rdi), %al
    cmpb %cl, %al
    jne .L_sw_false
    incq %rdi
    incq %rsi
    jmp .L_sw_loop
.L_sw_true:
    movq $1, %rax
    ret
.L_sw_false:
    movq $0, %rax
    ret

.section .text.rubix_rt_str_contains, "ax", @progbits
.globl rubix_rt_str_contains
.section .text.contains, "ax", @progbits
.globl contains
rubix_rt_str_contains:
contains:
    pushq %rbp
    movq %rsp, %rbp
    pushq %r12
    pushq %r13
    
    movq %rdi, %r12     # s
    movq %rsi, %r13     # sub
    
    cmpq $0, %r12
    je .L_cont_false
    cmpq $0, %r13
    je .L_cont_false
.L_cont_outer:
    cmpb $0, (%r12)
    je .L_cont_false
    movq %r12, %rdi
    movq %r13, %rsi
    call rubix_rt_str_starts_with
    cmpq $1, %rax
    je .L_cont_true
    incq %r12
    jmp .L_cont_outer
.L_cont_true:
    movq $1, %rax
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret
.L_cont_false:
    movq $0, %rax
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret

.section .text.rubix_rt_str_ends_with, "ax", @progbits
.globl rubix_rt_str_ends_with
.section .text.ends_with, "ax", @progbits
.globl ends_with
rubix_rt_str_ends_with:
ends_with:
    pushq %rbp
    movq %rsp, %rbp
    pushq %r12
    pushq %r13
    
    movq %rdi, %r12
    movq %rsi, %r13
    
    movq %r12, %rdi
    call rubix_rt_str_len
    movq %rax, %r8      # len s
    
    movq %r13, %rdi
    call rubix_rt_str_len
    movq %rax, %r9      # len suffix
    
    cmpq %r9, %r8
    jl .L_ew_false
    subq %r9, %r8
    addq %r8, %r12
    movq %r12, %rdi
    movq %r13, %rsi
    call rubix_rt_str_eq
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret
.L_ew_false:
    movq $0, %rax
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret


.section .text.rubix_rt_poly_len, "ax", @progbits
.globl rubix_rt_poly_len
.section .text.length, "ax", @progbits
.globl length
rubix_rt_poly_len:
length:
    cmpq $0, %rdi
    je .L_plen_zero
    cmpq $0x400000, %rdi
    jae .L_plen_str
    movq (%rdi), %rax
    ret
.L_plen_str:
    call rubix_rt_str_len
    ret
.L_plen_zero:
    movq $0, %rax
    ret

.section .text.rubix_rt_poly_eq, "ax", @progbits
.globl rubix_rt_poly_eq
rubix_rt_poly_eq:
    cmpq %rdi, %rsi
    je .L_peq_true
    cmpq $0x400000, %rdi
    jb .L_peq_false
    cmpq $0x400000, %rsi
    jb .L_peq_false
    call rubix_rt_str_eq
    ret
.L_peq_true:
    movq $1, %rax
    ret
.L_peq_false:
    movq $0, %rax
    ret

.section .text.rubix_rt_poly_add, "ax", @progbits
.globl rubix_rt_poly_add
rubix_rt_poly_add:
    cmpq $0x400000, %rdi
    jae .L_padd_str
    cmpq $0x400000, %rsi
    jae .L_padd_str
    movq %rdi, %rax
    addq %rsi, %rax
    ret
.L_padd_str:
    # Convert non-string to string if needed
    pushq %rbp
    movq %rsp, %rbp
    pushq %r12
    pushq %r13
    
    movq %rdi, %r12
    movq %rsi, %r13
    
    cmpq $0x400000, %r12
    jae .L_a_is_str
    movq %r12, %rdi
    call rubix_rt_int_to_str
    movq %rax, %r12
.L_a_is_str:
    cmpq $0x400000, %r13
    jae .L_b_is_str
    movq %r13, %rdi
    call rubix_rt_int_to_str
    movq %rax, %r13
.L_b_is_str:
    movq %r12, %rdi
    movq %r13, %rsi
    call rubix_rt_str_concat
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret


.section .text.rubix_rt_print_str, "ax", @progbits
.globl rubix_rt_print_str
rubix_rt_print_str:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rdi
    call rubix_rt_str_len
    movq %rax, %rdx     # count
    popq %rsi           # buf
    movq $1, %rdi       # stdout
    call sys_write
    
    movq $1, %rdi
    leaq newline_str(%rip), %rsi
    movq $1, %rdx
    call sys_write
    
    movq %rbp, %rsp
    popq %rbp
    ret

.section .text.rubix_rt_print_int, "ax", @progbits
.globl rubix_rt_print_int
rubix_rt_print_int:
    pushq %rbp
    movq %rsp, %rbp
    call rubix_rt_int_to_str
    movq %rax, %rdi
    call rubix_rt_print_str
    movq %rbp, %rsp
    popq %rbp
    ret

.section .text.rubix_rt_print_poly, "ax", @progbits
.globl rubix_rt_print_poly
.section .text.print_poly, "ax", @progbits
.globl print_poly
rubix_rt_print_poly:
print_poly:
    movq heap_base(%rip), %rax
    cmpq $0, %rax
    je .L_pp_int
    cmpq %rax, %rdi
    jb .L_check_rodata
    cmpq heap_end(%rip), %rdi
    ja .L_pp_int
    jmp .L_pp_str
.L_check_rodata:
    cmpq $0x400000, %rdi
    jb .L_pp_int
    cmpq $0x800000, %rdi
    ja .L_pp_int
    jmp .L_pp_str
.L_pp_int:
    call rubix_rt_print_int
    ret
.L_pp_str:
    call rubix_rt_print_str
    ret

.section .text.rubix_rt_panic, "ax", @progbits
.globl rubix_rt_panic
rubix_rt_panic:
    pushq %rdi
    movq $2, %rdi       # stderr
    leaq panic_prefix(%rip), %rsi
    movq $21, %rdx
    call sys_write
    popq %rdi
    
    call rubix_rt_print_str
    movq $1, %rdi
    call sys_exit

.section .text.rubix_rt_exit, "ax", @progbits
.globl rubix_rt_exit
rubix_rt_exit:
    call sys_exit

.section .text.assert_eq_int, "ax", @progbits
.globl assert_eq_int
assert_eq_int:
    cmpq %rdi, %rsi
    jne .L_assert_failed
    ret
.L_assert_failed:
    movq $2, %rdi
    leaq assert_fail_msg(%rip), %rsi
    movq $17, %rdx
    call sys_write
    movq $1, %rdi
    call sys_exit


.section .text.rubix_rt_read_file, "ax", @progbits
.globl rubix_rt_read_file
.section .text.read_file, "ax", @progbits
.globl read_file
rubix_rt_read_file:
read_file:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    
    # open(path, O_RDONLY, 0)
    movq $0, %rsi       # O_RDONLY
    movq $0, %rdx
    call sys_open
    
    cmpq $0, %rax
    jl .L_rf_fail
    movq %rax, %r12     # fd
    
    # Allocate 4MB file read buffer
    movq $4194304, %rdi
    call rubix_rt_alloc
    movq %rax, %rbx     # buffer
    
    # read(fd, buf, 4194304)
    movq %r12, %rdi
    movq %rbx, %rsi
    movq $4194304, %rdx
    call sys_read
    
    # Null-terminate
    movb $0, (%rbx, %rax)
    
    # close(fd)
    movq %r12, %rdi
    call sys_close
    
    movq %rbx, %rax
    popq %r12
    popq %rbx
    movq %rbp, %rsp
    popq %rbp
    ret
.L_rf_fail:
    leaq empty_str(%rip), %rax
    popq %r12
    popq %rbx
    movq %rbp, %rsp
    popq %rbp
    ret

.section .text.rubix_rt_write_file, "ax", @progbits
.globl rubix_rt_write_file
.section .text.write_file, "ax", @progbits
.globl write_file
rubix_rt_write_file:
write_file:
    pushq %rbp
    movq %rsp, %rbp
    pushq %r12
    pushq %r13
    
    movq %rsi, %r13     # content
    
    # open(path, O_WRONLY|O_CREAT|O_TRUNC, 0644)
    # O_WRONLY(1) | O_CREAT(64) | O_TRUNC(512) = 577 (0x241)
    movq $577, %rsi
    movq $420, %rdx     # 0644
    call sys_open
    
    cmpq $0, %rax
    jl .L_wf_fail
    movq %rax, %r12     # fd
    
    movq %r13, %rdi
    call rubix_rt_str_len
    movq %rax, %rdx     # len
    
    movq %r12, %rdi
    movq %r13, %rsi
    call sys_write
    
    movq %r12, %rdi
    call sys_close
    
    movq $1, %rax
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret
.L_wf_fail:
    movq $0, %rax
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret

.section .text.rubix_rt_file_exists, "ax", @progbits
.globl rubix_rt_file_exists
.section .text.file_exists, "ax", @progbits
.globl file_exists
rubix_rt_file_exists:
file_exists:
    # open(path, O_RDONLY, 0)
    movq $0, %rsi
    movq $0, %rdx
    call sys_open
    cmpq $0, %rax
    jl .L_fe_no
    movq %rax, %rdi
    call sys_close
    movq $1, %rax
    ret
.L_fe_no:
    movq $0, %rax
    ret


.section .text.rubix_rt_system, "ax", @progbits
.globl rubix_rt_system
.section .text.run_command_host, "ax", @progbits
.globl run_command_host
rubix_rt_system:
run_command_host:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    
    movq %rdi, %r12     # cmd string
    
    call sys_fork
    cmpq $0, %rax
    jl .L_fork_err
    je .L_child_exec
    
    # Parent: wait4(pid, &status, 0, NULL)
    movq %rax, %rdi
    leaq out_buf(%rip), %rsi
    movq $0, %rdx
    movq $0, %rcx
    call sys_wait4
    
    movl out_buf(%rip), %eax
    sarl $8, %eax
    movslq %eax, %rax
    popq %r12
    popq %rbx
    movq %rbp, %rsp
    popq %rbp
    ret

.L_child_exec:
    # execve("/bin/sh", ["/bin/sh", "-c", cmd, NULL], g_environ)
    # Prepare argv array on stack
    subq $48, %rsp
    leaq .L_sh_path(%rip), %rdi
    movq %rdi, (%rsp)
    leaq .L_sh_flag(%rip), %rdi
    movq %rdi, 8(%rsp)
    movq %r12, 16(%rsp)
    movq $0, 24(%rsp)
    
    leaq .L_sh_path(%rip), %rdi
    movq %rsp, %rsi
    movq g_environ(%rip), %rdx
    call sys_execve
    movq $127, %rdi
    call sys_exit

.L_fork_err:
    movq $-1, %rax
    popq %r12
    popq %rbx
    movq %rbp, %rsp
    popq %rbp
    ret

.L_sh_path: .string "/bin/sh"
.L_sh_flag: .string "-c"


.section .text.node_new, "ax", @progbits
.globl node_new
node_new:
    # rdi: kind, rsi: line, rdx: col, rcx: text
    movq g_node_count(%rip), %rax
    incq %rax
    movq %rax, g_node_count(%rip)
    
    movq node_arena_ptr(%rip), %r8
    # each node = 64 bytes -> %rax * 64
    shlq $6, %rax
    addq %r8, %rax
    
    movq %rdi, 0(%rax)      # kind
    movq %rsi, 8(%rax)      # line
    movq %rdx, 16(%rax)     # col
    movq %rcx, 24(%rax)     # text
    movq $0, 32(%rax)       # child
    movq $0, 40(%rax)       # sibling
    movq $0, 48(%rax)       # type_id
    
    movq g_node_count(%rip), %rax
    ret

.section .text.node_kind, "ax", @progbits
.globl node_kind
node_kind:
    cmpq $0, %rdi
    jle .L_nk_zero
    cmpq g_node_count(%rip), %rdi
    jg .L_nk_zero
    movq node_arena_ptr(%rip), %rax
    shlq $6, %rdi
    addq %rdi, %rax
    movq 0(%rax), %rax
    ret
.L_nk_zero:
    movq $0, %rax
    ret

.section .text.node_text, "ax", @progbits
.globl node_text
node_text:
    cmpq $0, %rdi
    jle .L_nt_empty
    cmpq g_node_count(%rip), %rdi
    jg .L_nt_empty
    movq node_arena_ptr(%rip), %rax
    shlq $6, %rdi
    addq %rdi, %rax
    movq 24(%rax), %rax
    cmpq $0, %rax
    je .L_nt_empty
    ret
.L_nt_empty:
    leaq empty_str(%rip), %rax
    ret

.section .text.node_line, "ax", @progbits
.globl node_line
node_line:
    cmpq $0, %rdi
    jle .L_nl_zero
    movq node_arena_ptr(%rip), %rax
    shlq $6, %rdi
    addq %rdi, %rax
    movq 8(%rax), %rax
    ret
.L_nl_zero:
    movq $0, %rax
    ret

.section .text.node_col, "ax", @progbits
.globl node_col
node_col:
    cmpq $0, %rdi
    jle .L_ncol_zero
    movq node_arena_ptr(%rip), %rax
    shlq $6, %rdi
    addq %rdi, %rax
    movq 16(%rax), %rax
    ret
.L_ncol_zero:
    movq $0, %rax
    ret

.section .text.node_child, "ax", @progbits
.globl node_child
node_child:
    cmpq $0, %rdi
    jle .L_nc_zero
    movq node_arena_ptr(%rip), %rax
    shlq $6, %rdi
    addq %rdi, %rax
    movq 32(%rax), %rax
    ret
.L_nc_zero:
    movq $0, %rax
    ret

.section .text.node_sibling, "ax", @progbits
.globl node_sibling
node_sibling:
    cmpq $0, %rdi
    jle .L_ns_zero
    movq node_arena_ptr(%rip), %rax
    shlq $6, %rdi
    addq %rdi, %rax
    movq 40(%rax), %rax
    ret
.L_ns_zero:
    movq $0, %rax
    ret

.section .text.node_set_sibling, "ax", @progbits
.globl node_set_sibling
node_set_sibling:
    cmpq $0, %rdi
    jle .L_nss_done
    movq node_arena_ptr(%rip), %rax
    shlq $6, %rdi
    addq %rdi, %rax
    movq %rsi, 40(%rax)
.L_nss_done:
    ret

.section .text.node_add_child, "ax", @progbits
.globl node_add_child
node_add_child:
    # rdi: parent, rsi: child
    cmpq $0, %rdi
    jle .L_nac_done
    cmpq $0, %rsi
    jle .L_nac_done
    
    movq node_arena_ptr(%rip), %rax
    shlq $6, %rdi
    addq %rdi, %rax
    
    movq 32(%rax), %rcx      # parent.child
    cmpq $0, %rcx
    jne .L_nac_find_tail
    movq %rsi, 32(%rax)
    ret
.L_nac_find_tail:
    movq node_arena_ptr(%rip), %r8
.L_nac_loop:
    shlq $6, %rcx
    addq %r8, %rcx
    movq 40(%rcx), %rdx     # cur.sibling
    cmpq $0, %rdx
    je .L_nac_set_tail
    movq %rdx, %rcx
    jmp .L_nac_loop
.L_nac_set_tail:
    movq %rsi, 40(%rcx)
.L_nac_done:
    ret

.section .text.node_set_type, "ax", @progbits
.globl node_set_type
node_set_type:
    cmpq $0, %rdi
    jle .L_nst_done
    movq node_arena_ptr(%rip), %rax
    shlq $6, %rdi
    addq %rdi, %rax
    movq %rsi, 48(%rax)
.L_nst_done:
    ret

.section .text.node_get_type, "ax", @progbits
.globl node_get_type
node_get_type:
    cmpq $0, %rdi
    jle .L_ngt_zero
    movq node_arena_ptr(%rip), %rax
    shlq $6, %rdi
    addq %rdi, %rax
    movq 48(%rax), %rax
    ret
.L_ngt_zero:
    movq $0, %rax
    ret

.section .text.node_count, "ax", @progbits
.globl node_count
node_count:
    movq g_node_count(%rip), %rax
    ret

.section .text.node_arena_reset, "ax", @progbits
.globl node_arena_reset
node_arena_reset:
    movq $0, g_node_count(%rip)
    ret


.section .text.rubix_variant_new, "ax", @progbits
.globl rubix_variant_new
rubix_variant_new:
    # rdi: tag, rsi: v1, rdx: v2, rcx: v3
    pushq %rbp
    movq %rsp, %rbp
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    
    movq $32, %rdi
    call rubix_rt_alloc
    
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    
    movq %rdi, 0(%rax)
    movq %rsi, 8(%rax)
    movq %rdx, 16(%rax)
    movq %rcx, 24(%rax)
    
    movq %rbp, %rsp
    popq %rbp
    ret

.section .text.Ok, "ax", @progbits
.globl Ok
Ok:
    movq %rdi, %rsi
    movq $1, %rdi
    movq $0, %rdx
    movq $0, %rcx
    jmp rubix_variant_new

.section .text.Err, "ax", @progbits
.globl Err
Err:
    movq %rdi, %rsi
    movq $2, %rdi
    movq $0, %rdx
    movq $0, %rcx
    jmp rubix_variant_new

.section .text.Some, "ax", @progbits
.globl Some
Some:
    movq %rdi, %rsi
    movq $1, %rdi
    movq $0, %rdx
    movq $0, %rcx
    jmp rubix_variant_new

.section .text.None, "ax", @progbits
.globl None
None:
    movq $0, %rdi
    movq $0, %rsi
    movq $0, %rdx
    movq $0, %rcx
    jmp rubix_variant_new

.section .text.Success, "ax", @progbits
.globl Success
Success:
    movq %rdi, %rsi
    movq $1, %rdi
    movq $0, %rdx
    movq $0, %rcx
    jmp rubix_variant_new

.section .text.Failure, "ax", @progbits
.globl Failure
Failure:
    movq %rdi, %rsi
    movq $2, %rdi
    movq $0, %rdx
    movq $0, %rcx
    jmp rubix_variant_new

.section .text.Process, "ax", @progbits
.globl Process
Process:
    movq %rdi, %rsi
    movq $1, %rdi
    movq $0, %rdx
    movq $0, %rcx
    jmp rubix_variant_new

.section .text.Circle, "ax", @progbits
.globl Circle
Circle:
    movq %rdi, %rsi
    movq $1, %rdi
    movq $0, %rdx
    movq $0, %rcx
    jmp rubix_variant_new

.section .text.Rectangle, "ax", @progbits
.globl Rectangle
Rectangle:
    movq %rdi, %rsi     # w
    movq %rsi, %rdx     # h
    movq $2, %rdi       # tag
    movq $0, %rcx
    jmp rubix_variant_new


.section .text.sys_clone, "ax", @progbits
.globl sys_clone
.type sys_clone, @function
sys_clone:
    # args: rdi = flags, rsi = stack_top, rdx = ptid, r10 = ctid, r8 = tls
    movq %rcx, %r10
    movq $56, %rax       # SYS_clone
    syscall
    ret

.section .text.sys_futex, "ax", @progbits
.globl sys_futex
.type sys_futex, @function
sys_futex:
    # args: rdi = uaddr, rsi = op, rdx = val, r10 = timeout, r8 = uaddr2, r9 = val3
    movq %rcx, %r10
    movq $202, %rax      # SYS_futex
    syscall
    ret

.section .text.sys_nanosleep, "ax", @progbits
.globl sys_nanosleep
.type sys_nanosleep, @function
sys_nanosleep:
    movq $35, %rax       # SYS_nanosleep
    syscall
    ret

.section .text.sys_sched_yield, "ax", @progbits
.globl sys_sched_yield
.type sys_sched_yield, @function
sys_sched_yield:
    movq $24, %rax       # SYS_sched_yield
    syscall
    ret

.section .text.rubix_atomic_load, "ax", @progbits
.globl rubix_atomic_load
.type rubix_atomic_load, @function
rubix_atomic_load:
    movq (%rdi), %rax
    mfence
    ret

.section .text.rubix_atomic_store, "ax", @progbits
.globl rubix_atomic_store
.type rubix_atomic_store, @function
rubix_atomic_store:
    xchgq %rsi, (%rdi)
    ret

.section .text.rubix_atomic_add, "ax", @progbits
.globl rubix_atomic_add
.type rubix_atomic_add, @function
rubix_atomic_add:
    lock addq %rsi, (%rdi)
    movq (%rdi), %rax
    ret

.section .text.rubix_atomic_cas, "ax", @progbits
.globl rubix_atomic_cas
.type rubix_atomic_cas, @function
rubix_atomic_cas:
    # rdi = ptr, rsi = expected, rdx = desired
    movq %rsi, %rax
    lock cmpxchgq %rdx, (%rdi)
    setz %al
    movzbq %al, %rax
    ret


.globl g_environ
.data
g_environ:
    .quad 0
.text

.section .text.main, "ax", @progbits
.globl main
.type main, @function
main:
    pushq %rbp
    movq %rsp, %rbp
    movq %rdx, g_environ(%rip)
    call rubix_rt_init
    call rubix_main
    movq %rbp, %rsp
    popq %rbp
    ret
