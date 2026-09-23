.text
.globl run_ast_optimizer
.type run_ast_optimizer, @function
run_ast_optimizer:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    subq $24, %rsp

    testq %rdi, %rdi
    jle .L_opt_quick_exit
    movq %rdi, %rbx         # rbx = root

    # Allocate 4096 bytes on heap for 16 candidates * 256 bytes
    # Slot layout (256 bytes per candidate):
    #   0..63:   fname (ASCII string, 64 bytes)
    #   64..71:  param_count (int64)
    #   72..79:  body_expr (int64 node ptr)
    #   80..87:  is_valid (int64 = 1)
    #   96..143: param_name[0] (48 bytes)
    #   144..191: param_name[1] (48 bytes)
    #   192..239: param_name[2] (48 bytes)
    movl $4096, %edi
    call malloc@PLT
    testq %rax, %rax
    je .L_opt_quick_exit
    movq %rax, 8(%rsp)      # table ptr on stack

    movq %rax, %rdi
    xorl %esi, %esi
    movl $4096, %edx
    call memset@PLT

    # ─────────────────────────────────────────────────────────────
    # Phase 1: Collect Multi-Parameter Inline Candidates
    # ─────────────────────────────────────────────────────────────
    xorl %r14d, %r14d       # r14d = candidate count (up to 16)
    movq %rbx, %rdi
    call node_child@PLT
    movq %rax, %r13         # r13 = fn_node

.L_cand_loop:
    testq %r13, %r13
    jle .L_phase1_5_tco
    cmpl $16, %r14d
    jge .L_phase1_5_tco

    movq %r13, %rdi
    call node_kind@PLT
    cmpq $2, %rax           # KIND_FUNCTION
    jne .L_cand_next

    # Check function name != "main" and != "rubix_main"
    movq %r13, %rdi
    call node_text@PLT
    movq %rax, %r12         # r12 = fname string

    leaq .LC_opt_main(%rip), %rsi
    movq %r12, %rdi
    call strcmp@PLT
    testl %eax, %eax
    je .L_cand_next

    leaq .LC_opt_rmain(%rip), %rsi
    movq %r12, %rdi
    call strcmp@PLT
    testl %eax, %eax
    je .L_cand_next

    # Scan children for parameters (kind 13) and body block (kind 3)
    movq %r13, %rdi
    call node_child@PLT
    movq %rax, %r15         # r15 = child
    xorq %r9, %r9           # r9 = body block
    xorl %r10d, %r10d       # r10d = param count

.L_fn_child_loop:
    testq %r15, %r15
    jle .L_fn_child_done
    movq %r15, %rdi
    call node_kind@PLT
    cmpq $13, %rax          # KIND_PARAM
    jne .L_check_block

    # Found parameter! If count < 3, record its name
    cmpl $3, %r10d
    jge .L_fn_child_next

    # candidate slot ptr = table_ptr + r14 * 256
    movslq %r14d, %rcx
    shlq $8, %rcx
    addq 8(%rsp), %rcx

    # param_name offset = 96 + r10 * 48
    movslq %r10d, %rdx
    imulq $48, %rdx, %rdx
    leaq 96(%rcx,%rdx), %rdi

    pushq %r10
    pushq %rdi
    movq %r15, %rdi
    call node_text@PLT     # rax = param name string
    movq %rax, %rsi
    popq %rdi
    call strcpy@PLT
    popq %r10

    incl %r10d
    jmp .L_fn_child_next

.L_check_block:
    cmpq $3, %rax           # KIND_BLOCK
    jne .L_fn_child_next
    movq %r15, %r9          # r9 = body block

.L_fn_child_next:
    movq %r15, %rdi
    call node_sibling@PLT
    movq %rax, %r15
    jmp .L_fn_child_loop

.L_fn_child_done:
    testl %r10d, %r10d
    jle .L_cand_next        # 0 params -> skip
    cmpl $3, %r10d
    jg .L_cand_next         # > 3 params -> skip
    testq %r9, %r9
    je .L_cand_next         # no body -> skip

    # Check body block has exactly 1 statement expression
    movq %r9, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_cand_next
    movq %rax, %r15         # r15 = body expression

    movq %r15, %rdi
    call node_sibling@PLT
    testq %rax, %rax
    jne .L_cand_next        # multiple statements -> skip

    # Check expression does not call fname (non-recursive)
    movq %r15, %rdi
    movq %r12, %rsi
    call check_calls_func
    testl %eax, %eax
    jne .L_cand_next        # recursive -> skip

    # Register candidate in table!
    movslq %r14d, %rcx
    shlq $8, %rcx
    addq 8(%rsp), %rcx      # rcx = candidate slot

    # Save fname in slot[0..63]
    movq %rcx, %rdi
    movq %r12, %rsi
    call strcpy@PLT

    # Save param_count in slot[64]
    movslq %r14d, %rcx
    shlq $8, %rcx
    addq 8(%rsp), %rcx
    movslq %r10d, %rax
    movq %rax, 64(%rcx)

    # Save body_expr in slot[72]
    movq %r15, 72(%rcx)

    # slot[80] = 1 (valid)
    movq $1, 80(%rcx)
    incl %r14d

.L_cand_next:
    movq %r13, %rdi
    call node_sibling@PLT
    movq %rax, %r13
    jmp .L_cand_loop

    # ─────────────────────────────────────────────────────────────
    # Phase 1.5: Detect and Mark Self-TCO (Tail-Call Optimization)
    # ─────────────────────────────────────────────────────────────
.L_phase1_5_tco:
    movq %rbx, %rdi
    call node_child@PLT
    movq %rax, %r13         # r13 = fn_node

.L_tco_loop:
    testq %r13, %r13
    jle .L_phase2_start
    movq %r13, %rdi
    call detect_and_mark_self_tco
    movq %r13, %rdi
    call node_sibling@PLT
    movq %rax, %r13
    jmp .L_tco_loop

    # ─────────────────────────────────────────────────────────────
    # Phase 2: Traverse and Apply Inlining + Constant Folding
    # ─────────────────────────────────────────────────────────────
.L_phase2_start:
    movq %rbx, %rdi
    movq 8(%rsp), %rsi
    movl %r14d, %edx
    call optimize_node_recursive

    # Free table
    movq 8(%rsp), %rdi
    call free@PLT

.L_opt_quick_exit:
    addq $24, %rsp
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

# Self-TCO Detection Helper
.type detect_and_mark_self_tco, @function
detect_and_mark_self_tco:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    subq $24, %rsp

    movq %rdi, %rbx         # rbx = fn_node
    testq %rbx, %rbx
    jle .L_tco_done

    movq %rbx, %rdi
    call node_kind@PLT
    cmpq $2, %rax           # KIND_FUNCTION
    jne .L_tco_done

    movq %rbx, %rdi
    call node_text@PLT
    movq %rax, %r12         # r12 = fname string

    # Skip main and rubix_main
    leaq .LC_opt_main(%rip), %rsi
    movq %r12, %rdi
    call strcmp@PLT
    testl %eax, %eax
    je .L_tco_done

    leaq .LC_opt_rmain(%rip), %rsi
    movq %r12, %rdi
    call strcmp@PLT
    testl %eax, %eax
    je .L_tco_done

    # Find body block (kind 3)
    movq %rbx, %rdi
    call node_child@PLT
    movq %rax, %r13
.L_tco_find_block:
    testq %r13, %r13
    jle .L_tco_done
    movq %r13, %rdi
    call node_kind@PLT
    cmpq $3, %rax           # KIND_BLOCK
    je .L_tco_found_block
    movq %r13, %rdi
    call node_sibling@PLT
    movq %rax, %r13
    jmp .L_tco_find_block

.L_tco_found_block:
    # Find last statement in body block
    movq %r13, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_tco_done
    movq %rax, %r14
.L_tco_last_stmt_loop:
    movq %r14, %rdi
    call node_sibling@PLT
    testq %rax, %rax
    jle .L_tco_check_stmt
    movq %rax, %r14
    jmp .L_tco_last_stmt_loop

.L_tco_check_stmt:
    # r14 = last statement in body block
    movq %r14, %rdi
    call node_kind@PLT
    cmpq $4, %rax           # KIND_IF
    je .L_tco_check_if

    cmpq $15, %rax          # KIND_CALL
    je .L_tco_check_direct_call

    cmpq $19, %rax          # KIND_RETURN
    je .L_tco_check_return
    jmp .L_tco_done

.L_tco_check_return:
    movq %r14, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_tco_done
    movq %rax, %r14
    movq %r14, %rdi
    call node_kind@PLT
    cmpq $15, %rax
    jne .L_tco_done

.L_tco_check_direct_call:
    # Check if callee == fname
    movq %r14, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_tco_done
    movq %rax, %rdi
    call node_text@PLT
    movq %r12, %rsi
    movq %rax, %rdi
    call strcmp@PLT
    testl %eax, %eax
    jne .L_tco_done

    # MATCH! Mark call text as "tail_call"
    movq %r14, %rdi
    leaq .LC_tco_name(%rip), %rsi
    call node_set_text@PLT
    jmp .L_tco_done

.L_tco_check_if:
    # r14 is KIND_IF: child = cond, sibling = then, sibling = else
    movq %r14, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_tco_done
    movq %rax, %rdi
    call node_sibling@PLT
    testq %rax, %rax
    jle .L_tco_done
    movq %rax, %r15         # then_branch

    movq %r15, %rdi
    call node_sibling@PLT
    movq %rax, 8(%rsp)      # else_branch

    # Check then_branch
    movq %r15, %rdi
    movq %r12, %rsi
    call check_and_mark_tail_branch

    # Check else_branch
    movq 8(%rsp), %rdi
    testq %rdi, %rdi
    jle .L_tco_done
    movq %r12, %rsi
    call check_and_mark_tail_branch

.L_tco_done:
    addq $24, %rsp
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

.type check_and_mark_tail_branch, @function
check_and_mark_tail_branch:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    subq $8, %rsp

    testq %rdi, %rdi
    jle .L_cmt_done
    movq %rdi, %rbx         # rbx = branch_node
    movq %rsi, %r12         # r12 = fname

    movq %rbx, %rdi
    call node_kind@PLT
    cmpq $15, %rax          # direct CALL
    je .L_cmt_call

    cmpq $3, %rax           # BLOCK
    je .L_cmt_block
    jmp .L_cmt_done

.L_cmt_block:
    movq %rbx, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_cmt_done
    movq %rax, %r13
.L_cmt_block_loop:
    movq %r13, %rdi
    call node_sibling@PLT
    testq %rax, %rax
    jle .L_cmt_block_last
    movq %rax, %r13
    jmp .L_cmt_block_loop

.L_cmt_block_last:
    movq %r13, %rdi
    call node_kind@PLT
    cmpq $15, %rax
    jne .L_cmt_done
    movq %r13, %rbx         # rbx = call node

.L_cmt_call:
    movq %rbx, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_cmt_done
    movq %rax, %rdi
    call node_text@PLT
    movq %r12, %rsi
    movq %rax, %rdi
    call strcmp@PLT
    testl %eax, %eax
    jne .L_cmt_done

    # MATCH! Mark call text as "tail_call"
    movq %rbx, %rdi
    leaq .LC_tco_name(%rip), %rsi
    call node_set_text@PLT

.L_cmt_done:
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

# Helper: check if subtree calls target_name
.type check_calls_func, @function
check_calls_func:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    subq $8, %rsp

    testq %rdi, %rdi
    jle .L_ccf_no
    movq %rdi, %rbx         # rbx = node
    movq %rsi, %r12         # r12 = target_name

    movq %rbx, %rdi
    call node_kind@PLT
    cmpq $15, %rax          # KIND_CALL
    jne .L_ccf_recurse

    # In call, child 1 is callee
    movq %rbx, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_ccf_recurse
    movq %rax, %rdi
    call node_text@PLT
    movq %r12, %rsi
    movq %rax, %rdi
    call strcmp@PLT
    testl %eax, %eax
    je .L_ccf_yes

.L_ccf_recurse:
    movq %rbx, %rdi
    call node_child@PLT
    movq %rax, %r13
.L_ccf_loop:
    testq %r13, %r13
    jle .L_ccf_no
    movq %r13, %rdi
    movq %r12, %rsi
    call check_calls_func
    testl %eax, %eax
    jne .L_ccf_yes
    movq %r13, %rdi
    call node_sibling@PLT
    movq %rax, %r13
    jmp .L_ccf_loop

.L_ccf_yes:
    movl $1, %eax
    jmp .L_ccf_done
.L_ccf_no:
    xorl %eax, %eax
.L_ccf_done:
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

# Recursive Optimizer (Inlining + Constant Folding)
.type optimize_node_recursive, @function
optimize_node_recursive:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    subq $56, %rsp

    testq %rdi, %rdi
    jle .L_onr_done
    movq %rdi, %rbx         # rbx = node
    movq %rsi, %r12         # r12 = candidates table
    movl %edx, %r13d        # r13d = candidate count

    # 1. Optimize children first (post-order)
    movq %rbx, %rdi
    call node_child@PLT
    movq %rax, %r14
.L_onr_child_loop:
    testq %r14, %r14
    jle .L_onr_self
    movq %r14, %rdi
    movq %r12, %rsi
    movl %r13d, %edx
    call optimize_node_recursive
    movq %r14, %rdi
    call node_sibling@PLT
    movq %rax, %r14
    jmp .L_onr_child_loop

.L_onr_self:
    movq %rbx, %rdi
    call node_kind@PLT
    movq %rax, %r14         # r14 = kind

    # If KIND_CALL (15): try inlining!
    cmpq $15, %r14
    je .L_onr_try_inline

    # If KIND_BINARY_EXPR (7): try constant folding!
    cmpq $7, %r14
    je .L_onr_try_fold
    jmp .L_onr_done

.L_onr_try_inline:
    testl %r13d, %r13d
    jle .L_onr_done

    # callee = node_child(call_node)
    movq %rbx, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_onr_done
    movq %rax, 8(%rsp)      # 8(%rsp) = callee node

    movq %rax, %rdi
    call node_text@PLT
    movq %rax, %r15         # r15 = callee name string

    xorl %ecx, %ecx
.L_onr_match_loop:
    cmpl %r13d, %ecx
    jge .L_onr_done
    movslq %ecx, %rax
    shlq $8, %rax           # * 256
    leaq (%r12,%rax), %rdx  # rdx = candidate ptr

    pushq %rcx
    pushq %rdx
    movq %rdx, %rsi
    movq %r15, %rdi
    call strcmp@PLT
    popq %rdx
    popq %rcx
    testl %eax, %eax
    je .L_onr_do_inline
    incl %ecx
    jmp .L_onr_match_loop

.L_onr_do_inline:
    # Found candidate at %rdx!
    # Extract arguments from call_node:
    # arg0 = node_sibling(callee)
    # arg1 = node_sibling(arg0)
    # arg2 = node_sibling(arg1)
    movq 8(%rsp), %rdi
    pushq %rdx
    call node_sibling@PLT
    popq %rdx
    testq %rax, %rax
    jle .L_onr_done
    movq %rax, %r15         # r15 = arg0

    xorq %r10, %r10         # r10 = arg1
    xorq %r11, %r11         # r11 = arg2

    movq 64(%rdx), %rcx     # param_count
    cmpq $2, %rcx
    jl .L_onr_args_ready

    # Need arg1
    movq %r15, %rdi
    pushq %rdx
    call node_sibling@PLT
    popq %rdx
    testq %rax, %rax
    jle .L_onr_done
    movq %rax, %r10         # r10 = arg1

    movq 64(%rdx), %rcx
    cmpq $3, %rcx
    jl .L_onr_args_ready

    # Need arg2
    movq %r10, %rdi
    pushq %rdx
    call node_sibling@PLT
    popq %rdx
    testq %rax, %rax
    jle .L_onr_done
    movq %rax, %r11         # r11 = arg2

.L_onr_args_ready:
    # Set up call: clone_and_subst_multi(cand_ptr, arg0, arg1, arg2, body_expr)
    movq %rdx, %rdi         # rdi = cand_ptr
    movq %r15, %rsi         # rsi = arg0
    movq %r10, %rdx         # rdx = arg1
    movq %r11, %rcx         # rcx = arg2
    movq 72(%rdi), %r8      # r8  = body_expr
    call clone_and_subst_multi
    testq %rax, %rax
    jle .L_onr_done

    movq %rax, %r15         # r15 = inlined node replacement

    # node_set_kind(call_node, node_kind(inlined))
    movq %r15, %rdi
    call node_kind@PLT
    movq %rbx, %rdi
    movq %rax, %rsi
    call node_set_kind@PLT

    # node_set_text(call_node, node_text(inlined))
    movq %r15, %rdi
    call node_text@PLT
    movq %rbx, %rdi
    movq %rax, %rsi
    call node_set_text@PLT

    # node_set_child(call_node, node_child(inlined))
    movq %r15, %rdi
    call node_child@PLT
    movq %rbx, %rdi
    movq %rax, %rsi
    call node_set_child@PLT

    # Fold constants in caller immediately!
    movq %rbx, %rdi
    call try_fold_node
    jmp .L_onr_done

.L_onr_try_fold:
    movq %rbx, %rdi
    call try_fold_node

.L_onr_done:
    addq $56, %rsp
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

# Multi-Argument Substitution Engine
# clone_and_subst_multi(cand_ptr, arg0, arg1, arg2, expr_node)
.type clone_and_subst_multi, @function
clone_and_subst_multi:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    subq $40, %rsp

    movq %rdi, 8(%rsp)      # 8(%rsp) = cand_ptr
    movq %rsi, 16(%rsp)     # 16(%rsp) = arg0
    movq %rdx, 24(%rsp)     # 24(%rsp) = arg1
    movq %rcx, 32(%rsp)     # 32(%rsp) = arg2
    movq %r8, %rbx          # rbx = expr_node

    testq %rbx, %rbx
    jle .L_csm_null

    movq %rbx, %rdi
    call node_kind@PLT
    cmpq $8, %rax           # KIND_IDENT
    jne .L_csm_regular

    # Check identifier against parameters
    movq %rbx, %rdi
    call node_text@PLT
    movq %rax, %r12         # r12 = ident name

    movq 8(%rsp), %rcx      # cand_ptr
    movq 64(%rcx), %r13     # param_count

    # Check param 0
    leaq 96(%rcx), %rsi
    movq %r12, %rdi
    call strcmp@PLT
    testl %eax, %eax
    jne .L_csm_check_p1
    # Match param 0! Return cloned arg0
    movq 16(%rsp), %rdi
    call clone_node_tree
    jmp .L_csm_ret

.L_csm_check_p1:
    cmpq $2, %r13
    jl .L_csm_regular
    movq 8(%rsp), %rcx
    leaq 144(%rcx), %rsi
    movq %r12, %rdi
    call strcmp@PLT
    testl %eax, %eax
    jne .L_csm_check_p2
    # Match param 1! Return cloned arg1
    movq 24(%rsp), %rdi
    call clone_node_tree
    jmp .L_csm_ret

.L_csm_check_p2:
    cmpq $3, %r13
    jl .L_csm_regular
    movq 8(%rsp), %rcx
    leaq 192(%rcx), %rsi
    movq %r12, %rdi
    call strcmp@PLT
    testl %eax, %eax
    jne .L_csm_regular
    # Match param 2! Return cloned arg2
    movq 32(%rsp), %rdi
    call clone_node_tree
    jmp .L_csm_ret

.L_csm_regular:
    # Create clone of current node
    movq %rbx, %rdi
    call node_kind@PLT
    movq %rax, %r14         # kind

    movq %rbx, %rdi
    call node_line@PLT
    movq %rax, %r15         # line

    movq %rbx, %rdi
    call node_col@PLT
    movq %rax, (%rsp)       # col

    movq %rbx, %rdi
    call node_text@PLT
    movq %rax, %rcx         # text
    movq (%rsp), %rdx       # col
    movq %r15, %rsi         # line
    movq %r14, %rdi         # kind
    call node_new@PLT
    movq %rax, %r14         # r14 = new_parent

    # Clone children recursively
    movq %rbx, %rdi
    call node_child@PLT
    movq %rax, %r15         # r15 = child
.L_csm_child_loop:
    testq %r15, %r15
    jle .L_csm_return_new

    movq 8(%rsp), %rdi      # cand_ptr
    movq 16(%rsp), %rsi     # arg0
    movq 24(%rsp), %rdx     # arg1
    movq 32(%rsp), %rcx     # arg2
    movq %r15, %r8          # child
    call clone_and_subst_multi
    testq %rax, %rax
    jle .L_csm_child_next
    movq %r14, %rdi
    movq %rax, %rsi
    call node_add_child@PLT

.L_csm_child_next:
    movq %r15, %rdi
    call node_sibling@PLT
    movq %rax, %r15
    jmp .L_csm_child_loop

.L_csm_return_new:
    movq %r14, %rax
    jmp .L_csm_ret
.L_csm_null:
    xorq %rax, %rax
.L_csm_ret:
    addq $40, %rsp
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

# Clone entire AST node tree
.type clone_node_tree, @function
clone_node_tree:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    subq $16, %rsp

    testq %rdi, %rdi
    jle .L_cnt_null
    movq %rdi, %rbx

    movq %rbx, %rdi
    call node_kind@PLT
    movq %rax, %r12

    movq %rbx, %rdi
    call node_line@PLT
    movq %rax, %r13

    movq %rbx, %rdi
    call node_col@PLT
    movq %rax, (%rsp)

    movq %rbx, %rdi
    call node_text@PLT
    movq %rax, %rcx
    movq (%rsp), %rdx
    movq %r13, %rsi
    movq %r12, %rdi
    call node_new@PLT
    movq %rax, %r14         # r14 = new_node

    # Clone children
    movq %rbx, %rdi
    call node_child@PLT
    movq %rax, %r12
.L_cnt_child_loop:
    testq %r12, %r12
    jle .L_cnt_done
    movq %r12, %rdi
    call clone_node_tree
    movq %r14, %rdi
    movq %rax, %rsi
    call node_add_child@PLT
    movq %r12, %rdi
    call node_sibling@PLT
    movq %rax, %r12
    jmp .L_cnt_child_loop

.L_cnt_done:
    movq %r14, %rax
    jmp .L_cnt_ret
.L_cnt_null:
    xorq %rax, %rax
.L_cnt_ret:
    addq $16, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

# Constant Folding Helper
.type try_fold_node, @function
try_fold_node:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    subq $24, %rsp

    movq %rdi, %rbx
    testq %rbx, %rbx
    jle .L_tfn_done

    movq %rbx, %rdi
    call node_kind@PLT
    cmpq $7, %rax           # KIND_BINARY_EXPR
    jne .L_tfn_done

    movq %rbx, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_tfn_done
    movq %rax, %r12         # left

    movq %r12, %rdi
    call node_sibling@PLT
    testq %rax, %rax
    jle .L_tfn_done
    movq %rax, %r13         # right

    movq %r12, %rdi
    call node_kind@PLT
    cmpq $9, %rax           # KIND_LITERAL
    jne .L_tfn_done

    movq %r13, %rdi
    call node_kind@PLT
    cmpq $9, %rax           # KIND_LITERAL
    jne .L_tfn_done

    # Evaluate constants!
    movq %r12, %rdi
    call node_text@PLT
    movq %rax, %rdi
    call string_to_int@PLT
    movq %rax, %r14         # v1

    movq %r13, %rdi
    call node_text@PLT
    movq %rax, %rdi
    call string_to_int@PLT
    movq %rax, %r15         # v2

    movq %rbx, %rdi
    call node_text@PLT
    movzbl (%rax), %ecx

    cmpb $43, %cl           # '+'
    je .L_tfn_add
    cmpb $45, %cl           # '-'
    je .L_tfn_sub
    cmpb $42, %cl           # '*'
    je .L_tfn_mul
    cmpb $47, %cl           # '/'
    je .L_tfn_div
    jmp .L_tfn_done

.L_tfn_add:
    movq %r14, %rax
    addq %r15, %rax
    jmp .L_tfn_apply
.L_tfn_sub:
    movq %r14, %rax
    subq %r15, %rax
    jmp .L_tfn_apply
.L_tfn_mul:
    movq %r14, %rax
    imulq %r15, %rax
    jmp .L_tfn_apply
.L_tfn_div:
    testq %r15, %r15
    je .L_tfn_done
    movq %r14, %rax
    cqto
    idivq %r15

.L_tfn_apply:
    movq %rax, %rdi
    call int_to_string@PLT
    movq %rax, %r14

    movq %rbx, %rdi
    movq $9, %rsi
    call node_set_kind@PLT

    movq %rbx, %rdi
    movq %r14, %rsi
    call node_set_text@PLT

    movq %rbx, %rdi
    xorq %rsi, %rsi
    call node_set_child@PLT

.L_tfn_done:
    addq $24, %rsp
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

# Shrink-Wrapped Guard Helper
.globl check_and_emit_guard_fastpath
.type check_and_emit_guard_fastpath, @function
check_and_emit_guard_fastpath:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    subq $24, %rsp

    movq %rdi, %rbx         # rbx = FILE*
    movq %rsi, %r12         # r12 = func_node
    movl %edx, %r13d        # r13d = label_id

    # 1. Find param name
    movq %r12, %rdi
    call node_child@PLT
    movq %rax, %r14
.L_ce_param_loop:
    testq %r14, %r14
    jle .L_ce_fail
    movq %r14, %rdi
    call node_kind@PLT
    cmpq $13, %rax          # KIND_PARAM
    je .L_ce_found_param
    movq %r14, %rdi
    call node_sibling@PLT
    movq %rax, %r14
    jmp .L_ce_param_loop

.L_ce_found_param:
    movq %r14, %rdi
    call node_text@PLT
    movq %rax, %r15         # r15 = param name string

    # 2. Find body block (kind 3)
    movq %r12, %rdi
    call node_child@PLT
    movq %rax, %r14
.L_ce_block_loop:
    testq %r14, %r14
    jle .L_ce_fail
    movq %r14, %rdi
    call node_kind@PLT
    cmpq $3, %rax           # KIND_BLOCK
    je .L_ce_found_block
    movq %r14, %rdi
    call node_sibling@PLT
    movq %rax, %r14
    jmp .L_ce_block_loop

.L_ce_found_block:
    # 3. Check first stmt in block
    movq %r14, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_ce_fail
    movq %rax, %r14         # r14 = first stmt

    movq %r14, %rdi
    call node_kind@PLT
    cmpq $4, %rax           # KIND_IF
    jne .L_ce_fail

    # 4. Check if condition is "<="
    movq %r14, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_ce_fail
    movq %rax, %r14         # r14 = cond

    movq %r14, %rdi
    call node_kind@PLT
    cmpq $7, %rax           # KIND_BINARY_EXPR
    jne .L_ce_fail

    movq %r14, %rdi
    call node_text@PLT
    movq %rax, %rdi
    leaq .LC_guard_le(%rip), %rsi   # "<="
    call strcmp@PLT
    testl %eax, %eax
    jne .L_ce_fail

    # Check right child of cond is literal "1" or "0"
    movq %r14, %rdi
    call node_child@PLT     # left
    testq %rax, %rax
    jle .L_ce_fail
    movq %rax, %rdi
    call node_sibling@PLT   # right
    testq %rax, %rax
    jle .L_ce_fail
    movq %rax, %rdi
    call node_text@PLT
    movzbl (%rax), %eax
    cmpb $49, %al           # '1'
    je .L_ce_emit
    cmpb $48, %al           # '0'
    jne .L_ce_fail

.L_ce_emit:
    # Emit shrink-wrapped guard
    movq %rbx, %rdi
    leaq .LC_guard_fmt(%rip), %rsi
    movl %r13d, %edx
    movl %r13d, %ecx
    xorl %eax, %eax
    call fprintf@PLT
    movl $1, %eax
    jmp .L_ce_done

.L_ce_fail:
    xorl %eax, %eax
.L_ce_done:
    addq $24, %rsp
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

.globl emit_tco_loop_header
.type emit_tco_loop_header, @function
emit_tco_loop_header:
    pushq %rbp
    movq %rsp, %rbp
    movl %esi, %edx
    leaq .LC_tco_loop_fmt(%rip), %rsi
    xorl %eax, %eax
    call fprintf@PLT
    popq %rbp
    ret

.globl emit_self_tail_call
.type emit_self_tail_call, @function
emit_self_tail_call:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    subq $56, %rsp

    movq %rdi, %rbx         # rbx = ctx
    movq %rsi, %r12         # r12 = call_node
    movl %edx, %r13d        # r13d = label_id
    movq (%rbx), %r14       # r14 = fp

    # callee is first child
    movq %r12, %rdi
    call node_child@PLT
    testq %rax, %rax
    jle .L_stc_done
    movq %rax, %r15         # r15 = callee

    # Scan and count arguments
    xorl %r10d, %r10d       # r10d = arg_count
    movq %r15, %rdi
    call node_sibling@PLT
    movq %rax, %r15         # r15 = arg0

.L_stc_eval_loop:
    testq %r15, %r15
    jle .L_stc_eval_done
    cmpl $3, %r10d
    jge .L_stc_eval_done

    # Evaluate argument: gen_node_x86.part.0(ctx, arg)
    pushq %r10
    pushq %r15
    movq %r15, %rsi
    movq %rbx, %rdi
    call gen_node_x86.part.0@PLT

    # Result in %rax. Push to stack: pushq %rax
    movq %r14, %rdi
    leaq .LC_tco_push(%rip), %rsi
    xorl %eax, %eax
    call fprintf@PLT
    popq %r15
    popq %r10

    incl %r10d
    movq %r15, %rdi
    call node_sibling@PLT
    movq %rax, %r15
    jmp .L_stc_eval_loop

.L_stc_eval_done:
    testl %r10d, %r10d
    jle .L_stc_done

    # Pop arguments into parameter registers / slots in reverse order
    cmpl $1, %r10d
    je .L_stc_pop1
    cmpl $2, %r10d
    je .L_stc_pop2
    cmpl $3, %r10d
    je .L_stc_pop3
    jmp .L_stc_emit_jump

.L_stc_pop1:
    movq %r14, %rdi
    leaq .LC_tco_pop1(%rip), %rsi
    xorl %eax, %eax
    call fprintf@PLT
    jmp .L_stc_emit_jump

.L_stc_pop2:
    movq %r14, %rdi
    leaq .LC_tco_pop2(%rip), %rsi
    xorl %eax, %eax
    call fprintf@PLT
    jmp .L_stc_emit_jump

.L_stc_pop3:
    movq %r14, %rdi
    leaq .LC_tco_pop3(%rip), %rsi
    xorl %eax, %eax
    call fprintf@PLT

.L_stc_emit_jump:
    # Emit jmp .L_tco_loop_%d
    movq %r14, %rdi
    leaq .LC_tco_jmp_fmt(%rip), %rsi
    movl %r13d, %edx
    xorl %eax, %eax
    call fprintf@PLT

.L_stc_done:
    movl $1, %eax
    addq $56, %rsp
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

.section .rodata
.LC_opt_main:    .string "main"
.LC_opt_rmain:   .string "rubix_main"
.LC_tco_name:    .string "tail_call"
.LC_guard_le:    .string "<="
.LC_guard_fmt:   .string "    cmpq $1, %%rdi\n    jg .L_prologue_%d\n    movq %%rdi, %%rax\n    ret\n.L_prologue_%d:\n"
.LC_tco_push:    .string "    pushq %%rax\n"
.LC_tco_pop1:    .string "    popq %%rdi\n    movq %%rdi, -8(%%rbp)\n"
.LC_tco_pop2:    .string "    popq %%rsi\n    movq %%rsi, -16(%%rbp)\n    popq %%rdi\n    movq %%rdi, -8(%%rbp)\n"
.LC_tco_pop3:    .string "    popq %%rdx\n    movq %%rdx, -24(%%rbp)\n    popq %%rsi\n    movq %%rsi, -16(%%rbp)\n    popq %%rdi\n    movq %%rdi, -8(%%rbp)\n"
.LC_tco_jmp_fmt: .string "    jmp .L_tco_loop_%d\n"
.LC_tco_loop_fmt:.string ".L_tco_loop_%d:\n"

