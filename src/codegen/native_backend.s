	.file	"native_backend_full.c"
	.text
	.p2align 4
	.type	count_vars.part.0, @function
count_vars.part.0:
	pushq	%rbp
	pushq	%rbx
	movq	%rdi, %rbx
	subq	$8, %rsp
	call	node_kind@PLT
	movq	%rbx, %rdi
	leaq	-20(%rax), %rdx
	cmpq	$1, %rdx
	setbe	%bpl
	cmpq	$13, %rax
	sete	%al
	orl	%eax, %ebp
	movzbl	%bpl, %ebp
	call	node_child@PLT
	testq	%rax, %rax
	jle	.L1
	movq	%rax, %rbx
.L3:
	movq	%rbx, %rdi
	call	count_vars.part.0
	movq	%rbx, %rdi
	addl	%eax, %ebp
	call	node_sibling@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	jg	.L3
.L1:
	addq	$8, %rsp
	movl	%ebp, %eax
	popq	%rbx
	popq	%rbp
	ret
	.size	count_vars.part.0, .-count_vars.part.0
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"error: cannot reassign to immutable variable `%s`\n"
	.align 8
.LC1:
	.string	"  = help: declare variable with 'mut' if reassignment is intended\n"
	.align 8
.LC2:
	.string	"error: attempted division by zero literal\n"
	.align 8
.LC3:
	.string	"  = help: divisor cannot be zero\n"
	.align 8
.LC4:
	.string	"error: type `%s` has no field `%s`\n"
	.text
	.p2align 4
	.type	validate_node_tree.part.0, @function
validate_node_tree.part.0:
	subq	$88, %rsp
	movq	%rbx, 40(%rsp)
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	movq	%r12, 56(%rsp)
	movq	%rsi, %r12
	movq	%rbp, 48(%rsp)
	movq	%r14, 72(%rsp)
	movq	%rdx, %r14
	call	node_kind@PLT
	movq	%r12, %rdi
	movq	%rax, %rbp
	call	node_text@PLT
	movq	%rax, 8(%rsp)
	cmpq	$14, %rbp
	je	.L79
	cmpq	$2, %rbp
	je	.L80
	cmpq	$20, %rbp
	je	.L81
	cmpq	$21, %rbp
	je	.L82
.L18:
	cmpq	$6, %rbp
	jne	.L15
	cmpq	$3, %r14
	jne	.L15
	movq	%r12, %rdi
	call	node_child@PLT
	testq	%rax, %rax
	jle	.L9
	movq	%rax, %rdi
	movq	%r13, 64(%rsp)
	call	node_text@PLT
	movq	%rax, %r14
	movl	33792(%rbx), %eax
	movl	%eax, %r13d
	subl	$1, %r13d
	js	.L76
	imulq	$132, %rax, %rax
	movq	%r15, 80(%rsp)
	leaq	-132(%rbx,%rax), %r15
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L19:
	subl	$1, %r13d
	subq	$132, %r15
	cmpl	$-1, %r13d
	je	.L77
.L20:
	movq	%r14, %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L19
	movl	%r13d, %eax
	imulq	$132, %rax, %rax
	movl	64(%rbx,%rax), %eax
	testl	%eax, %eax
	je	.L83
	.p2align 4
	.p2align 3
.L77:
	movq	%r12, %rdi
	movq	64(%rsp), %r13
	movq	80(%rsp), %r15
	call	node_child@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	jg	.L33
.L7:
	movq	40(%rsp), %rbx
	movq	48(%rsp), %rbp
	movq	56(%rsp), %r12
	movq	72(%rsp), %r14
	addq	$88, %rsp
	ret
	.p2align 4,,10
	.p2align 3
.L80:
	movl	$0, 33792(%rbx)
	.p2align 4
	.p2align 3
.L9:
	movq	%r12, %rdi
	call	node_child@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	jle	.L7
	.p2align 4
	.p2align 3
.L33:
	movq	%r12, %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	validate_node_tree.part.0
	movq	%r12, %rdi
	call	node_sibling@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	jg	.L33
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L79:
	movq	%r12, %rdi
	call	node_child@PLT
	testq	%rax, %rax
	jle	.L9
	movq	%r12, %rdi
	movq	%r13, 64(%rsp)
	call	node_child@PLT
	movq	%rax, %rdi
	movq	%rax, %r13
	call	node_kind@PLT
	cmpq	$13, %rax
	je	.L84
	.p2align 4
	.p2align 3
.L76:
	movq	64(%rsp), %r13
	jmp	.L9
	.p2align 4,,10
	.p2align 3
.L82:
	movq	%r12, %rdi
	call	node_child@PLT
	testq	%rax, %rax
	jle	.L9
	cmpl	$255, 33792(%rbx)
	jg	.L9
	movq	%rax, %rdi
	call	node_text@PLT
	movslq	33792(%rbx), %rdi
	movl	$63, %edx
	movq	%rax, %rsi
	imulq	$132, %rdi, %rdi
	addq	%rbx, %rdi
	call	strncpy@PLT
	movslq	33792(%rbx), %rax
	movq	%rax, %rdx
	imulq	$132, %rax, %rax
	addl	$1, %edx
	movl	$1, 64(%rbx,%rax)
	movb	$0, 68(%rbx,%rax)
	movl	%edx, 33792(%rbx)
	jmp	.L9
	.p2align 4,,10
	.p2align 3
.L81:
	movq	%r12, %rdi
	movq	%r13, 64(%rsp)
	call	node_child@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	jle	.L76
	cmpl	$255, 33792(%rbx)
	jg	.L76
	movq	%rax, %rdi
	call	node_text@PLT
	movslq	33792(%rbx), %rdi
	movl	$63, %edx
	movq	%rax, %rsi
	imulq	$132, %rdi, %rdi
	addq	%rbx, %rdi
	call	strncpy@PLT
	movslq	33792(%rbx), %rax
	movq	%r13, %rdi
	imulq	$132, %rax, %rax
	movl	$0, 64(%rbx,%rax)
	movb	$0, 68(%rbx,%rax)
	call	node_sibling@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	jg	.L85
.L17:
	addl	$1, 33792(%rbx)
	movq	64(%rsp), %r13
	jmp	.L9
.L15:
	movq	%r13, 64(%rsp)
	cmpq	$7, %rbp
	jne	.L11
	movq	8(%rsp), %rcx
	movzbl	(%rcx), %eax
	cmpl	$47, %eax
	jne	.L34
	cmpb	$0, 1(%rcx)
	jne	.L34
.L22:
	movq	%r12, %rdi
	call	node_child@PLT
	movq	%rax, %rdi
	call	node_sibling@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	jle	.L76
	movq	%rax, %rdi
	call	node_kind@PLT
	cmpq	$9, %rax
	jne	.L76
	movq	%r13, %rdi
	call	node_text@PLT
	cmpb	$48, (%rax)
	jne	.L76
	cmpb	$0, 1(%rax)
	jne	.L76
	movq	stderr(%rip), %rcx
	movl	$42, %edx
	movl	$1, %esi
	leaq	.LC2(%rip), %rdi
	call	fwrite@PLT
	movl	$33, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
	addl	$1, 103688(%rbx)
	movq	64(%rsp), %r13
	jmp	.L9
	.p2align 4,,10
	.p2align 3
.L34:
	cmpl	$37, %eax
	jne	.L76
	movq	8(%rsp), %rax
	cmpb	$0, 1(%rax)
	je	.L22
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L78:
	movq	80(%rsp), %r15
.L11:
	cmpq	$17, %rbp
	jne	.L76
	cmpq	$15, %r14
	je	.L76
	movq	%r12, %rdi
	call	node_child@PLT
	testq	%rax, %rax
	jle	.L76
	movq	%rax, %rdi
	call	node_text@PLT
	movq	%rax, 16(%rsp)
	movl	33792(%rbx), %eax
	movl	%eax, %edx
	subl	$1, %edx
	js	.L76
	leaq	-1(%rax), %rcx
	leaq	-2(%rax), %r14
	movl	%edx, %edx
	movq	%r15, 80(%rsp)
	imulq	$-132, %rax, %rax
	subq	%rdx, %r14
	imulq	$132, %rdx, %rdx
	imulq	$132, %rcx, %r13
	addq	%rbx, %rax
	imulq	$132, %r14, %r14
	addq	%rdx, %rax
	movq	%rax, 24(%rsp)
	.p2align 4
	.p2align 3
.L27:
	movq	16(%rsp), %rsi
	leaq	(%rbx,%r13), %rdi
	call	strcmp@PLT
	movl	%eax, %r15d
	testl	%eax, %eax
	jne	.L25
	movq	24(%rsp), %rax
	cmpb	$0, 200(%rax,%r13)
	jne	.L86
.L25:
	subq	$132, %r13
	cmpq	%r13, %r14
	jne	.L27
	jmp	.L77
.L86:
	movl	103684(%rbx), %eax
	movl	%eax, 24(%rsp)
	testl	%eax, %eax
	jle	.L77
	leaq	33796(%rbx), %rax
	leaq	68(%rbx,%r13), %r13
	xorl	%r14d, %r14d
	movq	%rax, 16(%rsp)
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L28:
	addl	$1, %r15d
	addq	$1092, %r14
	cmpl	24(%rsp), %r15d
	je	.L77
.L31:
	movq	16(%rsp), %rax
	movq	%r13, %rsi
	leaq	(%rax,%r14), %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L28
	movl	%r15d, %eax
	imulq	$1092, %rax, %rax
	movl	34884(%rbx,%rax), %eax
	testl	%eax, %eax
	jle	.L29
	leaq	33860(%rbx,%r14), %r15
	salq	$6, %rax
	leaq	(%rax,%r15), %r14
	jmp	.L30
	.p2align 4,,10
	.p2align 3
.L87:
	addq	$64, %r15
	cmpq	%r14, %r15
	je	.L29
.L30:
	movq	8(%rsp), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L87
	jmp	.L77
.L83:
	movq	stderr(%rip), %rdi
	movq	%r14, %rdx
	leaq	.LC0(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	$66, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC1(%rip), %rdi
	call	fwrite@PLT
	movq	64(%rsp), %r13
	movq	80(%rsp), %r15
	addl	$1, 103688(%rbx)
	jmp	.L9
.L84:
	movslq	103684(%rbx), %rax
	movq	8(%rsp), %rsi
	movq	%r15, 80(%rsp)
	imulq	$1092, %rax, %r15
	leal	1(%rax), %edx
	movl	%edx, 103684(%rbx)
	movl	$63, %edx
	leaq	33796(%rbx,%r15), %rdi
	movq	%r15, 16(%rsp)
	addq	%rbx, %r15
	call	strncpy@PLT
	testq	%r13, %r13
	jg	.L10
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L12:
	movq	%r13, %rdi
	call	node_sibling@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	jle	.L62
.L10:
	cmpl	$15, 34884(%r15)
	jg	.L78
	movq	%r13, %rdi
	call	node_kind@PLT
	cmpq	$13, %rax
	jne	.L12
	movq	%r13, %rdi
	call	node_text@PLT
	movq	16(%rsp), %rcx
	movq	%rax, %rsi
	movslq	34884(%r15), %rax
	leal	1(%rax), %edx
	addq	$1, %rax
	movl	%edx, 34884(%r15)
	salq	$6, %rax
	movl	$63, %edx
	leaq	33796(%rcx,%rax), %rdi
	addq	%rbx, %rdi
	call	strncpy@PLT
	jmp	.L12
.L29:
	movq	8(%rsp), %rcx
	movq	stderr(%rip), %rdi
	movq	%r13, %rdx
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rsi
	call	fprintf@PLT
	movq	64(%rsp), %r13
	movq	80(%rsp), %r15
	addl	$1, 103688(%rbx)
	jmp	.L9
.L85:
	movq	%rax, %rdi
	call	node_kind@PLT
	cmpq	$16, %rax
	jne	.L17
	movq	%r13, %rdi
	call	node_text@PLT
	movl	$63, %edx
	movq	%rax, %rsi
	movslq	33792(%rbx), %rax
	imulq	$132, %rax, %rax
	leaq	68(%rbx,%rax), %rdi
	call	strncpy@PLT
	jmp	.L17
.L62:
	movq	64(%rsp), %r13
	movq	80(%rsp), %r15
	jmp	.L18
	.size	validate_node_tree.part.0, .-validate_node_tree.part.0
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"error: file not found: `%s`\n"
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"check: FAILED (%ld syntax errors)\n"
	.align 8
.LC7:
	.string	"check: FAILED (%d semantic errors)\n"
	.align 8
.LC8:
	.string	"check: OK (%s validated successfully, %ld AST nodes)\n"
	.text
	.p2align 4
	.type	cmd_check_native.part.0, @function
cmd_check_native.part.0:
	pushq	%r14
	pushq	%rbx
	subq	$103736, %rsp
	movq	%fs:40, %rbx
	movq	%rbx, 103720(%rsp)
	movq	%rdi, %rbx
	call	read_file@PLT
	testq	%rax, %rax
	je	.L89
	cmpb	$0, (%rax)
	jne	.L90
.L89:
	movq	stderr(%rip), %rdi
	movq	%rbx, %rdx
	leaq	.LC5(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L91:
	movl	$1, %eax
.L88:
	movq	103720(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L100
	addq	$103736, %rsp
	popq	%rbx
	popq	%r14
	ret
	.p2align 4,,10
	.p2align 3
.L90:
	movq	%rax, 8(%rsp)
	call	node_arena_reset@PLT
	movq	8(%rsp), %rdi
	call	init_lexer@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	init_parser@PLT
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	parse_program@PLT
	movq	8(%rsp), %rdx
	movq	%rax, %r14
	movq	24(%rdx), %rdx
	testq	%rdx, %rdx
	jg	.L101
	xorl	%esi, %esi
	movl	$103692, %edx
	leaq	16(%rsp), %rdi
	call	memset@PLT
	testq	%r14, %r14
	jle	.L94
	xorl	%edx, %edx
	movq	%r14, %rsi
	leaq	16(%rsp), %rdi
	call	validate_node_tree.part.0
	movl	103704(%rsp), %edx
	testl	%edx, %edx
	jle	.L94
	movq	stderr(%rip), %rdi
	leaq	.LC7(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L91
	.p2align 4,,10
	.p2align 3
.L94:
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	run_semantic_analysis@PLT
	movq	%rbx, %rsi
	movq	%r14, %rdi
	call	run_typechecker@PLT
	call	node_count@PLT
	movq	%rbx, %rsi
	leaq	.LC8(%rip), %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	printf@PLT
	xorl	%eax, %eax
	jmp	.L88
	.p2align 4,,10
	.p2align 3
.L101:
	movq	stderr(%rip), %rdi
	leaq	.LC6(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L91
.L100:
	call	__stack_chk_fail@PLT
	.size	cmd_check_native.part.0, .-cmd_check_native.part.0
	.p2align 4
	.globl	validate_node_tree
	.type	validate_node_tree, @function
validate_node_tree:
	testq	%rsi, %rsi
	jle	.L102
	jmp	validate_node_tree.part.0
	.p2align 4,,10
	.p2align 3
.L102:
	ret
	.size	validate_node_tree, .-validate_node_tree
	.p2align 4
	.globl	count_vars
	.type	count_vars, @function
count_vars:
	testq	%rdi, %rdi
	jle	.L105
	jmp	count_vars.part.0
	.p2align 4,,10
	.p2align 3
.L105:
	xorl	%eax, %eax
	ret
	.size	count_vars, .-count_vars
	.section	.rodata.str1.1
.LC9:
	.string	".LC_str_%d:\n    .asciz \"%s\"\n"
.LC10:
	.string	".LC_str_%d:\n    .string \"%s\"\n"
	.text
	.p2align 4
	.globl	add_string
	.type	add_string, @function
add_string:
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	movq	%rdi, %rbx
	subq	$1056, %rsp
	movl	25620(%rdi), %ebp
	movl	25628(%rdi), %edx
	movq	%fs:40, %r8
	movq	%r8, 1048(%rsp)
	movq	%rsi, %r8
	leaq	16(%rsp), %r12
	leal	1(%rbp), %eax
	movl	%ebp, %ecx
	movl	%eax, 25620(%rdi)
	testl	%edx, %edx
	jne	.L107
	movl	25632(%rdi), %eax
	leaq	.LC10(%rip), %rdx
	testl	%eax, %eax
	je	.L113
.L107:
	leaq	.LC9(%rip), %rdx
.L113:
	movl	$1024, %esi
	movq	%r12, %rdi
	xorl	%eax, %eax
	call	snprintf@PLT
	movl	%eax, %ecx
	movslq	25624(%rbx), %rax
	leal	(%rax,%rcx), %edx
	cmpl	$16383, %edx
	jbe	.L114
.L106:
	movq	1048(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L115
	addq	$1056, %rsp
	movl	%ebp, %eax
	popq	%rbx
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
	.p2align 3
.L114:
	movslq	%ecx, %rdx
	leaq	9236(%rbx,%rax), %rdi
	movq	%r12, %rsi
	movl	%ecx, 12(%rsp)
	call	memcpy@PLT
	movl	12(%rsp), %ecx
	addl	25624(%rbx), %ecx
	movl	%ecx, 25624(%rbx)
	movslq	%ecx, %rcx
	movb	$0, 9236(%rbx,%rcx)
	jmp	.L106
.L115:
	call	__stack_chk_fail@PLT
	.size	add_string, .-add_string
	.p2align 4
	.globl	add_var
	.type	add_var, @function
add_var:
	subq	$40, %rsp
	movq	%r12, 16(%rsp)
	movslq	9224(%rdi), %r12
	movq	%r13, 24(%rsp)
	movq	%rdi, %r13
	movq	%r14, 32(%rsp)
	movq	%rsi, %r14
	movq	%rbx, (%rsp)
	testl	%r12d, %r12d
	jle	.L117
	movq	%rbp, 8(%rsp)
	xorl	%ebx, %ebx
	leaq	8(%rdi), %rbp
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L118:
	addl	$1, %ebx
	addq	$72, %rbp
	cmpl	%r12d, %ebx
	je	.L138
.L120:
	movq	%r14, %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L118
	leaq	(%rbx,%rbx,8), %rax
	movq	8(%rsp), %rbp
	movl	72(%r13,%rax,8), %ebx
.L116:
	movl	%ebx, %eax
	movq	16(%rsp), %r12
	movq	(%rsp), %rbx
	movq	24(%rsp), %r13
	movq	32(%rsp), %r14
	addq	$40, %rsp
	ret
	.p2align 4,,10
	.p2align 3
.L138:
	cmpl	$1, 25636(%r13)
	movl	9228(%r13), %ebx
	sbbl	%eax, %eax
	movq	8(%rsp), %rbp
	andl	$4, %eax
	leal	4(%rax,%rbx), %eax
	movl	%eax, 9228(%r13)
	cmpl	$127, %r12d
	jg	.L116
.L124:
	leaq	(%r12,%r12,8), %rax
	movq	%r14, %rsi
	movl	$63, %edx
	leaq	8(%r13,%rax,8), %rdi
	call	strncpy@PLT
	movslq	9224(%r13), %rax
	leaq	(%rax,%rax,8), %rcx
	movl	%ebx, 72(%r13,%rcx,8)
	movl	25636(%r13), %esi
	leal	1(%rax), %ecx
	testl	%esi, %esi
	jne	.L130
	movl	%ecx, %esi
	cmpl	$4, %eax
	jle	.L126
.L130:
	xorl	%esi, %esi
.L126:
	leaq	(%rax,%rax,8), %rax
	movl	%esi, 76(%r13,%rax,8)
	movl	%ecx, 9224(%r13)
	jmp	.L116
.L117:
	movl	9228(%rdi), %ebx
	movl	25636(%rdi), %edi
	leal	4(%rbx), %edx
	leal	8(%rbx), %eax
	testl	%edi, %edi
	cmovne	%edx, %eax
	movl	%eax, 9228(%r13)
	jmp	.L124
	.size	add_var, .-add_var
	.p2align 4
	.globl	get_var_slot
	.type	get_var_slot, @function
get_var_slot:
	subq	$40, %rsp
	movl	9224(%rdi), %eax
	movq	%r12, 24(%rsp)
	testl	%eax, %eax
	jle	.L143
	movq	%rbx, 8(%rsp)
	leaq	(%rax,%rax,8), %rax
	leaq	8(%rdi), %rbx
	movq	%rbp, 16(%rsp)
	movq	%rsi, %rbp
	movq	%r13, 32(%rsp)
	leaq	(%rbx,%rax,8), %r13
	jmp	.L142
	.p2align 4,,10
	.p2align 3
.L151:
	addq	$72, %rbx
	cmpq	%r13, %rbx
	je	.L150
.L142:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	movq	%rbx, %r12
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L151
	movq	%r12, %rax
	movq	8(%rsp), %rbx
	movq	16(%rsp), %rbp
	movq	32(%rsp), %r13
	movq	24(%rsp), %r12
	addq	$40, %rsp
	ret
	.p2align 4,,10
	.p2align 3
.L150:
	movq	8(%rsp), %rbx
	movq	16(%rsp), %rbp
	movq	32(%rsp), %r13
.L143:
	xorl	%r12d, %r12d
	movq	%r12, %rax
	movq	24(%rsp), %r12
	addq	$40, %rsp
	ret
	.size	get_var_slot, .-get_var_slot
	.p2align 4
	.globl	get_var
	.type	get_var, @function
get_var:
	movl	9224(%rdi), %eax
	testl	%eax, %eax
	jle	.L162
	pushq	%r12
	leaq	(%rax,%rax,8), %rax
	pushq	%rbp
	movq	%rsi, %rbp
	pushq	%rbx
	leaq	8(%rdi), %rbx
	leaq	(%rbx,%rax,8), %r12
	jmp	.L156
	.p2align 4,,10
	.p2align 3
.L164:
	addq	$72, %rbx
	cmpq	%r12, %rbx
	je	.L163
.L156:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L164
	movl	64(%rbx), %eax
	popq	%rbx
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
	.p2align 3
.L163:
	popq	%rbx
	movl	$16, %eax
	popq	%rbp
	popq	%r12
	ret
.L162:
	movl	$16, %eax
	ret
	.size	get_var, .-get_var
	.p2align 4
	.globl	gen_node_x86
	.type	gen_node_x86, @function
gen_node_x86:
	testq	%rsi, %rsi
	jle	.L165
	jmp	gen_node_x86.part.0
	.p2align 4,,10
	.p2align 3
.L165:
	ret
	.size	gen_node_x86, .-gen_node_x86
	.section	.rodata.str1.1
.LC11:
	.string	""
.LC12:
	.string	"    movl $1, %%eax\n"
.LC13:
	.string	"    movq $1, %%rax\n"
.LC14:
	.string	"    movl $0, %%eax\n"
.LC15:
	.string	"    xorl %%eax, %%eax\n"
	.section	.rodata.str1.8

	.align 8
.LC16:
	.string	"    pushl $.LC_str_%d\n    popl %%eax\n"
	.align 8
.LC17:
	.string	"    leaq .LC_str_%d(%%rip), %%rax\n"
	.section	.rodata.str1.1
.LC18:
	.string	"true"
.LC19:
	.string	"    movl $%s, %%eax\n"
.LC20:
	.string	"    movq $%s, %%rax\n"
	.section	.rodata.str1.8
	.align 8
.LC21:
	.string	"    movq %s, %%rax # ident %s\n"
	.align 8
.LC22:
	.string	"    movl -%d(%%ebp), %%eax # ident %s\n"
	.align 8
.LC23:
	.string	"    movq -%d(%%rbp), %%rax # ident %s\n"
	.section	.rodata.str1.1
.LC24:
	.string	">="
.LC25:
	.string	"=="
.LC26:
	.string	"!="
.LC27:
	.string	"    subq $%s, %%rax\n"
.LC28:
	.string	"    addq $%s, %%rax\n"
	.section	.rodata.str1.8
	.align 8
.LC29:
	.string	"    cmpq $%s, %%rax\n    setle %%al\n    movzbq %%al, %%rax\n"
	.align 8
.LC30:
	.string	"    cmpq $%s, %%rax\n    setl %%al\n    movzbq %%al, %%rax\n"
	.align 8
.LC31:
	.string	"    cmpq $%s, %%rax\n    setg %%al\n    movzbq %%al, %%rax\n"
	.align 8
.LC32:
	.string	"    cmpq $%s, %%rax\n    setge %%al\n    movzbq %%al, %%rax\n"
	.align 8
.LC33:
	.string	"    cmpq $%s, %%rax\n    sete %%al\n    movzbq %%al, %%rax\n"
	.align 8
.LC34:
	.string	"    cmpq $%s, %%rax\n    setne %%al\n    movzbq %%al, %%rax\n"
	.section	.rodata.str1.1
.LC35:
	.string	"    pushl %%eax\n"
	.section	.rodata.str1.8
	.align 8
.LC36:
	.string	"    movl %%eax, %%ebx\n    popl %%eax\n"
	.section	.rodata.str1.1
.LC37:
	.string	"    addl %%ebx, %%eax\n"
.LC38:
	.string	"    subl %%ebx, %%eax\n"
.LC39:
	.string	"    imull %%ebx, %%eax\n"
	.section	.rodata.str1.8
	.align 8
.LC40:
	.string	"    cmpl %%ebx, %%eax\n    setle %%al\n    movzbl %%al, %%eax\n"
	.align 8
.LC41:
	.string	"    cmpl %%ebx, %%eax\n    setl %%al\n    movzbl %%al, %%eax\n"
	.align 8
.LC42:
	.string	"    cmpl %%ebx, %%eax\n    setg %%al\n    movzbl %%al, %%eax\n"
	.align 8
.LC43:
	.string	"    cmpl %%ebx, %%eax\n    setge %%al\n    movzbl %%al, %%eax\n"
	.align 8
.LC44:
	.string	"    cmpl %%ebx, %%eax\n    sete %%al\n    movzbl %%al, %%eax\n"
	.align 8
.LC45:
	.string	"    cmpl %%ebx, %%eax\n    setne %%al\n    movzbl %%al, %%eax\n"
	.section	.rodata.str1.1
.LC46:
	.string	"    pushq %%rax\n"
	.section	.rodata.str1.8
	.align 8
.LC47:
	.string	"    movq %%rax, %%rbx\n    popq %%rax\n"
	.section	.rodata.str1.1
.LC48:
	.string	"    addq %%rbx, %%rax\n"
.LC49:
	.string	"    subq %%rbx, %%rax\n"
.LC50:
	.string	"    imulq %%rbx, %%rax\n"
.LC51:
	.string	"    cqto\n    idivq %%rbx\n"
	.section	.rodata.str1.8
	.align 8
.LC52:
	.string	"    cqto\n    idivq %%rbx\n    movq %%rdx, %%rax\n"
	.align 8
.LC53:
	.string	"    cmpq %%rbx, %%rax\n    setle %%al\n    movzbq %%al, %%rax\n"
	.align 8
.LC54:
	.string	"    cmpq %%rbx, %%rax\n    setl %%al\n    movzbq %%al, %%rax\n"
	.align 8
.LC55:
	.string	"    cmpq %%rbx, %%rax\n    setg %%al\n    movzbq %%al, %%rax\n"
	.align 8
.LC56:
	.string	"    cmpq %%rbx, %%rax\n    setge %%al\n    movzbq %%al, %%rax\n"
	.align 8
.LC57:
	.string	"    cmpq %%rbx, %%rax\n    sete %%al\n    movzbq %%al, %%rax\n"
	.align 8
.LC58:
	.string	"    cmpq %%rbx, %%rax\n    setne %%al\n    movzbq %%al, %%rax\n"
	.section	.rodata.str1.1
.LC59:
	.string	"    movq %%rax, %s # let %s\n"
	.section	.rodata.str1.8
	.align 8
.LC60:
	.string	"    movl %%eax, -%d(%%ebp) # let %s\n"
	.align 8
.LC61:
	.string	"    movq %%rax, -%d(%%rbp) # let %s\n"
	.section	.rodata.str1.1
.LC62:
	.string	"+"
	.section	.rodata.str1.8
	.align 8
.LC63:
	.string	"    addq $%s, %s # in-place add %s\n"
	.section	.rodata.str1.1
.LC64:
	.string	"-"
	.section	.rodata.str1.8
	.align 8
.LC65:
	.string	"    subq $%s, %s # in-place sub %s\n"
	.align 8
.LC66:
	.string	"    movq %%rax, %s # assign %s\n"
	.align 8
.LC67:
	.string	"    movl %%eax, -%d(%%ebp) # assign %s\n"
	.align 8
.LC68:
	.string	"    movq %%rax, -%d(%%rbp) # assign %s\n"
	.section	.rodata.str1.1
.LC69:
	.string	"    cmpq $%s, %s\n"
.LC70:
	.string	"<="
.LC71:
	.string	"    jg .L_else_%d\n"
.LC72:
	.string	"<"
.LC73:
	.string	"    jge .L_else_%d\n"
.LC74:
	.string	"    jl .L_else_%d\n"
.LC75:
	.string	">"
.LC76:
	.string	"    jle .L_else_%d\n"
.LC77:
	.string	"    jne .L_else_%d\n"
.LC78:
	.string	"    je .L_else_%d\n"
.LC79:
	.string	"    jmp .L_endif_%d\n"
.LC80:
	.string	".L_else_%d:\n"
.LC81:
	.string	".L_endif_%d:\n"
.LC82:
	.string	"    cmpq $%s, %%rax\n"
	.section	.rodata.str1.8
	.align 8
.LC83:
	.string	"    movq %%rax, %%rbx\n    popq %%rax\n    cmpq %%rbx, %%rax\n"
	.align 8
.LC84:
	.string	"    cmpl $0, %%eax\n    je .L_else_%d\n"
	.align 8
.LC85:
	.string	"    cmpq $0, %%rax\n    je .L_else_%d\n"
	.section	.rodata.str1.1
.LC86:
	.string	"    .p2align 4,,10\n.L_loop_start_%d:\n"
.LC87:
	.string	"    jge .L_loop_end_%d\n"
.LC88:
	.string	"    jg .L_loop_end_%d\n"
.LC89:
	.string	"    jle .L_loop_end_%d\n"
.LC90:
	.string	"    jl .L_loop_end_%d\n"
.LC91:
	.string	"    jne .L_loop_end_%d\n"
.LC92:
	.string	"    je .L_loop_end_%d\n"
.LC93:
	.string	"    jmp .L_loop_start_%d\n"
.LC94:
	.string	".L_loop_end_%d:\n"
	.section	.rodata.str1.8
	.align 8
.LC95:
	.string	"    cmpl $0, %%eax\n    je .L_loop_end_%d\n"
	.align 8
.LC96:
	.string	"    cmpq $0, %%rax\n    je .L_loop_end_%d\n"
	.align 8
.LC97:
	.string	"    pushl %%eax\n    call %srubix_rt_print_poly\n    addl $4, %%esp\n"
	.align 8
.LC98:
	.string	"    movq %%rax, %%rdi\n    call %srubix_rt_print_poly\n"
	.section	.rodata.str1.1
.LC99:
	.string	"main"
.LC100:
	.string	"%srubix_main"
.LC101:
	.string	"%s%s"
.LC102:
	.string	"print"
.LC103:
	.string	"int_to_string"
.LC104:
	.string	"text"
	.section	.rodata.str1.8
	.align 8
.LC105:
	.string	"    pushl %%eax\n    call %srubix_rt_int_to_str\n    addl $4, %%esp\n"
	.align 8
.LC106:
	.string	"    movq %%rax, %%rdi\n    call %srubix_rt_int_to_str\n"
	.align 8
.LC107:
	.string	"    movq %%rax, %%rdi\n    call %s\n"
	.align 8
.LC108:
	.string	"    call %s\n    addl $%d, %%esp\n"
	.section	.rodata.str1.1
.LC109:
	.string	"    popq %%rdi\n"
	.section	.rodata.str1.8
	.align 8
.LC110:
	.string	"    popq %%rsi\n    popq %%rdi\n"
	.align 8
.LC111:
	.string	"    popq %%rdx\n    popq %%rsi\n    popq %%rdi\n"
	.align 8
.LC112:
	.string	"    popq %%rcx\n    popq %%rdx\n    popq %%rsi\n    popq %%rdi\n"
	.section	.rodata.str1.1
.LC113:
	.string	"    call %s\n"
	.section	.rodata.str1.8
	.align 8
.LC114:
	.string	"    movl %%ebp, %%esp\n    popl %%ebp\n    ret\n"
	.section	.rodata.str1.1
.LC115:
	.string	"    addq $32, %%rsp\n"
.LC116:
	.string	"    popq %s\n"
	.section	.rodata.str1.8
	.align 8
.LC117:
	.string	"    movq %%rbp, %%rsp\n    popq %%rbp\n    ret\n"
	.align 8
.LC118:
	.string	"\n.section __TEXT,__text,regular,pure_instructions\n.globl %s\n"
	.section	.rodata.str1.1
.LC119:
	.string	"\n.section .text\n.globl %s\n"
	.section	.rodata.str1.8
	.align 8
.LC120:
	.string	"\n.section .text.%s, \"ax\", @progbits\n    .p2align 4,,15\n.globl %s\n.type %s, @function\n"
	.section	.rodata.str1.1
.LC121:
	.string	"%s:\n"
	.section	.rodata.str1.8
	.align 8
.LC122:
	.string	"    pushl %%ebp\n    movl %%esp, %%ebp\n    subl $64, %%esp\n"
	.align 8
.LC123:
	.string	"    pushq %%rbp\n    movq %%rsp, %%rbp\n"
	.section	.rodata.str1.1
.LC124:
	.string	"    pushq %s\n"
.LC125:
	.string	"    subq $32, %%rsp\n"
	.section	.rodata.str1.8
	.align 8
.LC126:
	.string	"    movl %d(%%ebp), %%eax # param %s\n    movl %%eax, -%d(%%ebp)\n"
	.align 8
.LC127:
	.string	"    movq %%rdi, %s # param %s\n"
	.align 8
.LC128:
	.string	"    movq %%rsi, %s # param %s\n"
	.align 8
.LC129:
	.string	"    movq %%rdx, %s # param %s\n"
	.align 8
.LC130:
	.string	"    movq %%rcx, %s # param %s\n"
	.align 8
.LC131:
	.string	"    movq %%rdi, -%d(%%rbp) # param %s\n"
	.align 8
.LC132:
	.string	"    movq %%rsi, -%d(%%rbp) # param %s\n"
	.align 8
.LC133:
	.string	"    movq %%rdx, -%d(%%rbp) # param %s\n"
	.align 8
.LC134:
	.string	"    movq %%rcx, -%d(%%rbp) # param %s\n"
	.section	.rodata.str1.1
.LC135:
	.string	".text\n"
	.section	.rodata.str1.8
	.align 8
.LC136:
	.string	"\n.section __TEXT,__cstring,cstring_literals\n"
	.section	.rodata.str1.1
.LC137:
	.string	"\n.section .rdata,\"dr\"\n"
.LC138:
	.string	"\n.section .rodata\n"
.LC139:
	.string	"%s\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB140:
	.text
.LHOTB140:
	.p2align 4
	.globl	gen_node_x86.part.0
	.type	gen_node_x86.part.0, @function
gen_node_x86.part.0:
	subq	$168, %rsp
	movq	%rbx, 120(%rsp)
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	movq	%r12, 136(%rsp)
	movq	%r13, 144(%rsp)
	movq	%r14, 152(%rsp)
	movq	%rbp, 128(%rsp)
	movq	%fs:40, %rbp
	movq	%rbp, 104(%rsp)
	movq	%rsi, %rbp
	call	node_kind@PLT
	movq	%rax, %r14
	movq	%rbp, %rdi
	call	node_text@PLT
	movq	25656(%rbx), %r12
	movq	%rax, %r13
	leaq	.LC11(%rip), %rax
	testq	%r12, %r12
	cmove	%rax, %r12
	cmpq	$30, %r14
	ja	.L167
	leaq	.L171(%rip), %rdx
	movslq	(%rdx,%r14,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L171:
	.long	.L167-.L171
	.long	.L183-.L171
	.long	.L182-.L171
	.long	.L181-.L171
	.long	.L180-.L171
	.long	.L179-.L171
	.long	.L178-.L171
	.long	.L177-.L171
	.long	.L176-.L171
	.long	.L175-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L174-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L173-.L171
	.long	.L172-.L171
	.long	.L172-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L167-.L171
	.long	.L170-.L171
	.text
	.p2align 4,,10
	.p2align 3
.L181:
	movq	%rbp, %rdi
	call	node_child@PLT
	movq	%rax, %rbp
.L588:
	testq	%rbp, %rbp
	jle	.L167
.L591:
	movq	%rbp, %rdi
	call	node_kind@PLT
	movq	%rbp, %rdi
	movq	%rax, %r13
	call	node_text@PLT
	cmpq	$8, %r13
	jne	.L437
	leaq	.LC102(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L590
.L437:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movq	%rbp, %rdi
	call	node_sibling@PLT
	movq	%rax, %rbp
	testq	%rbp, %rbp
	jg	.L591
	.p2align 4
	.p2align 3
.L167:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L592
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	ret
	.p2align 4,,10
	.p2align 3
.L172:
	movq	%rbp, %rdi
	call	node_child@PLT
	movq	%rax, %rdi
	movq	%rax, %rbp
	call	node_text@PLT
	movq	%rbp, %rdi
	movq	%rax, %r13
	call	node_sibling@PLT
	movq	%r13, %rsi
	movq	%rbx, %rdi
	movq	%rax, %r14
	call	add_var
	movl	9224(%rbx), %eax
	testl	%eax, %eax
	jle	.L568
	leaq	8(%rbx), %rbp
	leaq	(%rax,%rax,8), %rax
	leaq	0(%rbp,%rax,8), %r12
	jmp	.L300
	.p2align 4,,10
	.p2align 3
.L593:
	addq	$72, %rbp
	cmpq	%r12, %rbp
	je	.L568
.L300:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L593
	testq	%r14, %r14
	jle	.L167
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movl	68(%rbp), %eax
	testl	%eax, %eax
	jg	.L594
	movl	64(%rbp), %edx
.L500:
	movl	25636(%rbx), %eax
	movq	(%rbx), %rdi
	testl	%eax, %eax
	je	.L304
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L595
	movq	120(%rsp), %rbx
	movq	%r13, %rcx
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	leaq	.LC60(%rip), %rsi
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L183:
	movl	25644(%rbx), %r9d
	testl	%r9d, %r9d
	je	.L596
.L476:
	movq	%rbp, %rdi
	call	node_child@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jle	.L477
.L478:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movq	%rbp, %rdi
	call	node_sibling@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jg	.L478
.L477:
	movl	25620(%rbx), %r8d
	testl	%r8d, %r8d
	jle	.L167
	movl	25644(%rbx), %edi
	movq	(%rbx), %rcx
	testl	%edi, %edi
	jne	.L597
	movl	25640(%rbx), %esi
	testl	%esi, %esi
	je	.L481
	movl	$22, %edx
	movl	$1, %esi
	leaq	.LC137(%rip), %rdi
	call	fwrite@PLT
.L480:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L598
	movq	(%rbx), %rdi
	movq	128(%rsp), %rbp
	leaq	9236(%rbx), %rdx
	leaq	.LC139(%rip), %rsi
	movq	120(%rsp), %rbx
	movq	136(%rsp), %r12
	xorl	%eax, %eax
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L182:
	leaq	.LC99(%rip), %rsi
	movq	%r13, %rdi
	leaq	32(%rsp), %r14
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L599
	movq	%r13, %r8
	movq	%r12, %rcx
	leaq	.LC101(%rip), %rdx
	movq	%r14, %rdi
	movl	$64, %esi
	xorl	%eax, %eax
	call	snprintf@PLT
.L443:
	movq	%rbp, %rdi
	call	count_vars.part.0
	movq	(%rbx), %rdi
	movl	$0, 9224(%rbx)
	movl	%eax, %r12d
	movl	$5, %eax
	cmpl	%eax, %r12d
	cmovle	%r12d, %eax
	cmpl	$1, 25636(%rbx)
	movl	%eax, 16(%rsp)
	movl	%eax, 25648(%rbx)
	sbbl	%eax, %eax
	andl	$4, %eax
	addl	$4, %eax
	movl	%eax, 9228(%rbx)
	movl	25644(%rbx), %eax
	testl	%eax, %eax
	jne	.L600
	movl	25640(%rbx), %eax
	testl	%eax, %eax
	je	.L447
	movq	%r14, %rdx
	leaq	.LC119(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L446:
	movq	(%rbx), %rdi
	movq	%r14, %rdx
	leaq	.LC121(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	25636(%rbx), %eax
	movq	(%rbx), %rdi
	testl	%eax, %eax
	je	.L448
	leaq	.LC122(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L449:
	movq	%rbp, %rdi
	call	node_child@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	jle	.L452
	movq	%r15, 160(%rsp)
	movl	$0, 8(%rsp)
	jmp	.L468
	.p2align 4,,10
	.p2align 3
.L453:
	movq	%r12, %rdi
	call	node_sibling@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	jle	.L601
.L468:
	movq	%r12, %rdi
	call	node_kind@PLT
	cmpq	$13, %rax
	jne	.L453
	movq	%r12, %rdi
	call	node_text@PLT
	movq	%rbx, %rdi
	movq	%rax, %rsi
	movq	%rax, %r13
	call	add_var
	movl	9224(%rbx), %eax
	testl	%eax, %eax
	jle	.L454
	leaq	8(%rbx), %r14
	leaq	(%rax,%rax,8), %rax
	leaq	(%r14,%rax,8), %rax
	movq	%rax, (%rsp)
	jmp	.L456
	.p2align 4,,10
	.p2align 3
.L603:
	leaq	72(%r14), %r14
	cmpq	%r14, (%rsp)
	je	.L602
.L456:
	movq	%r13, %rsi
	movq	%r14, %rdi
	movq	%r14, %r15
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L603
	movl	25636(%rbx), %ecx
	testl	%ecx, %ecx
	jne	.L487
	movl	68(%r14), %eax
	testl	%eax, %eax
	jle	.L461
	leaq	reg_names(%rip), %r14
	subl	$1, %eax
	movq	(%r14,%rax,8), %rdx
	movl	8(%rsp), %r14d
	testl	%r14d, %r14d
	je	.L604
	cmpl	$1, 8(%rsp)
	je	.L605
	cmpl	$2, 8(%rsp)
	je	.L606
	cmpl	$3, 8(%rsp)
	je	.L607
	.p2align 4
	.p2align 3
.L460:
	addl	$1, 8(%rsp)
	jmp	.L453
	.p2align 4,,10
	.p2align 3
.L180:
	movq	%rbp, %rdi
	call	node_child@PLT
	movq	%rax, %rdi
	movq	%rax, %r14
	call	node_sibling@PLT
	movq	%rax, %rdi
	movq	%rax, %r12
	call	node_sibling@PLT
	movl	9232(%rbx), %ebp
	movq	%rax, %r13
	leal	1(%rbp), %eax
	movl	%eax, 9232(%rbx)
	movl	25636(%rbx), %eax
	testl	%eax, %eax
	jne	.L327
	testq	%r14, %r14
	jg	.L608
.L328:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC85(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L365:
	testq	%r12, %r12
	jle	.L366
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L366:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC79(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	(%rbx), %rdi
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC80(%rip), %rsi
	call	fprintf@PLT
	testq	%r13, %r13
	jg	.L609
.L367:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L610
	movq	(%rbx), %rdi
	movq	136(%rsp), %r12
	movl	%ebp, %edx
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	leaq	.LC81(%rip), %rsi
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L179:
	movq	%rbp, %rdi
	call	node_child@PLT
	movq	%rax, %rdi
	movq	%rax, %r13
	call	node_sibling@PLT
	movl	9232(%rbx), %ebp
	movq	(%rbx), %rdi
	leaq	.LC86(%rip), %rsi
	movq	%rax, %r12
	leal	1(%rbp), %eax
	movl	%ebp, %edx
	movl	%eax, 9232(%rbx)
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	25636(%rbx), %r11d
	testl	%r11d, %r11d
	jne	.L369
	testq	%r13, %r13
	jg	.L611
.L370:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC96(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L405:
	testq	%r12, %r12
	jle	.L406
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L406:
	movq	(%rbx), %rdi
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC93(%rip), %rsi
	call	fprintf@PLT
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L612
	movq	(%rbx), %rdi
	movq	136(%rsp), %r12
	movl	%ebp, %edx
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	leaq	.LC94(%rip), %rsi
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L178:
	movq	%rbp, %rdi
	call	node_child@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	call	node_text@PLT
	movq	%rbp, %rdi
	movq	%rax, %r13
	call	node_sibling@PLT
	movq	%rax, %r14
	movl	9224(%rbx), %eax
	testl	%eax, %eax
	jle	.L307
	leaq	8(%rbx), %rbp
	leaq	(%rax,%rax,8), %rax
	leaq	0(%rbp,%rax,8), %r12
	jmp	.L309
	.p2align 4,,10
	.p2align 3
.L613:
	addq	$72, %rbp
	cmpq	%r12, %rbp
	je	.L307
.L309:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L613
	movl	68(%rbp), %eax
	testl	%eax, %eax
	jle	.L614
	testq	%r14, %r14
	jle	.L167
	movq	%r14, %rdi
	call	node_kind@PLT
	cmpq	$7, %rax
	je	.L615
.L584:
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L320:
	movl	68(%rbp), %eax
	testl	%eax, %eax
	jg	.L616
	movl	64(%rbp), %edx
.L321:
	movl	25636(%rbx), %eax
	movq	(%rbx), %rdi
	testl	%eax, %eax
	je	.L324
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L617
	movq	120(%rsp), %rbx
	movq	%r13, %rcx
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	leaq	.LC67(%rip), %rsi
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L177:
	movq	%rbp, %rdi
	movq	%r15, 160(%rsp)
	call	node_child@PLT
	movq	%rax, %rdi
	movq	%rax, %r12
	call	node_sibling@PLT
	movq	%rax, %r14
	movq	%rax, %rdi
	call	node_kind@PLT
	movq	%r14, %rdi
	movq	%rax, %rbp
	call	node_text@PLT
	movq	%rax, %r15
	movl	25636(%rbx), %eax
	testl	%eax, %eax
	jne	.L206
	cmpq	$9, %rbp
	jne	.L206
	movzbl	0(%r13), %ebp
	cmpl	$45, %ebp
	jne	.L508
	cmpb	$0, 1(%r13)
	jne	.L508
	testq	%r12, %r12
	jle	.L483
.L484:
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movzbl	0(%r13), %ebp
	cmpl	$45, %ebp
	jne	.L217
	cmpb	$0, 1(%r13)
	jne	.L217
.L483:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L618
	movq	(%rbx), %rdi
	movq	128(%rsp), %rbp
	movq	%r15, %rdx
	xorl	%eax, %eax
	movq	160(%rsp), %r15
	movq	120(%rsp), %rbx
	leaq	.LC27(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L176:
	movl	9224(%rbx), %eax
	testl	%eax, %eax
	jle	.L185
	leaq	8(%rbx), %rbp
	leaq	(%rax,%rax,8), %rax
	leaq	0(%rbp,%rax,8), %r12
	jmp	.L200
	.p2align 4,,10
	.p2align 3
.L619:
	addq	$72, %rbp
	cmpq	%r12, %rbp
	je	.L185
.L200:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L619
	movl	68(%rbp), %eax
	testl	%eax, %eax
	jg	.L620
	movl	64(%rbp), %edx
.L201:
	movl	25636(%rbx), %eax
	movq	(%rbx), %rdi
	testl	%eax, %eax
	je	.L203
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L621
	movq	120(%rsp), %rbx
	movq	%r13, %rcx
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	leaq	.LC22(%rip), %rsi
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L175:
	movq	%rbp, %rdi
	call	node_get_type@PLT
	cmpq	$5, %rax
	je	.L622
	movl	25636(%rbx), %ebp
	movq	(%rbx), %rbx
	cmpq	$4, %rax
	je	.L623
	testl	%ebp, %ebp
	je	.L196
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L624
	movq	128(%rsp), %rbp
	movq	%r13, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	136(%rsp), %r12
	leaq	.LC19(%rip), %rsi
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L174:
	leaq	.LC_tco_name_str(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L174_regular
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	movl	25648(%rbx), %edx
	call	emit_self_tail_call@PLT
	jmp	.L167
.L174_regular:
	movq	%rbp, %rdi
	leaq	32(%rsp), %r14
	call	node_child@PLT

	movq	%rax, %rdi
	movq	%rax, %r13
	call	node_text@PLT
	leaq	.LC99(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbp
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L411
	movq	%r12, %rcx
	leaq	.LC100(%rip), %rdx
	movl	$64, %esi
	movq	%r14, %rdi
	call	snprintf@PLT
.L412:
	leaq	.LC102(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L625
	leaq	.LC103(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L416
	leaq	.LC104(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L417
.L416:
	movq	%r13, %rdi
	call	node_sibling@PLT
	testq	%rax, %rax
	jle	.L167
	movq	%rax, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movl	25636(%rbx), %esi
	movq	(%rbx), %rdi
	movq	%r12, %rdx
	testl	%esi, %esi
	je	.L418
	leaq	.LC105(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L167
	.p2align 4,,10
	.p2align 3
.L173:
	movq	%rbp, %rdi
	call	node_child@PLT
	testq	%rax, %rax
	jg	.L626
.L431:
	movl	25636(%rbx), %eax
	movq	(%rbx), %rdi
	testl	%eax, %eax
	jne	.L627
	leaq	.LC115(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	25648(%rbx), %ebp
	subl	$1, %ebp
	js	.L434
	movl	%ebp, %ebp
	leaq	reg_names(%rip), %r14
	leaq	.LC116(%rip), %r12
	.p2align 4
	.p2align 3
.L435:
	movq	(%r14,%rbp,8), %rdx
	movq	(%rbx), %rdi
	movq	%r12, %rsi
	xorl	%eax, %eax
	subq	$1, %rbp
	call	fprintf@PLT
	testl	%ebp, %ebp
	jns	.L435
.L434:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L628
	movq	(%rbx), %rdi
	movq	128(%rsp), %rbp
	leaq	.LC117(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L170:
	movq	%rbp, %rdi
	call	node_child@PLT
	testq	%rax, %rax
	jle	.L167
	movq	%rbx, %rdi
	movq	%rax, %rsi
	call	gen_node_x86.part.0
	movl	25636(%rbx), %r9d
	movq	(%rbx), %rdi
	testl	%r9d, %r9d
	je	.L408
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L629
	movq	120(%rsp), %rbx
	movq	%r12, %rdx
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	leaq	.LC97(%rip), %rsi
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L206:
	testq	%r12, %r12
	jle	.L238
.L486:
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movl	25636(%rbx), %eax
.L238:
	testl	%eax, %eax
	je	.L239
	movq	(%rbx), %rdi
	xorl	%eax, %eax
	leaq	.LC35(%rip), %rsi
	call	fprintf@PLT
	testq	%r14, %r14
	jle	.L240
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L240:
	movq	(%rbx), %rdi
	leaq	.LC36(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movzbl	0(%r13), %ebp
	cmpl	$43, %ebp
	jne	.L242
	cmpb	$0, 1(%r13)
	jne	.L242
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L630
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC37(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L627:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L631
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	leaq	.LC114(%rip), %rsi
	xorl	%eax, %eax
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L599:
	movq	%r12, %rcx
	leaq	.LC100(%rip), %rdx
	movl	$64, %esi
	movq	%r14, %rdi
	call	snprintf@PLT
	jmp	.L443
	.p2align 4,,10
	.p2align 3
.L411:
	movq	%rbp, %r8
	movq	%r12, %rcx
	leaq	.LC101(%rip), %rdx
	movq	%r14, %rdi
	movl	$64, %esi
	xorl	%eax, %eax
	call	snprintf@PLT
	jmp	.L412
	.p2align 4,,10
	.p2align 3
.L626:
	movq	%rax, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	jmp	.L431
.L510:
	cmpl	$60, %ebp
	jne	.L511
	cmpb	$0, 1(%r13)
	je	.L212
.L511:
	cmpl	$62, %ebp
	jne	.L512
	cmpb	$0, 1(%r13)
	je	.L212
.L512:
	leaq	.LC24(%rip), %rsi
	movq	%r13, %rdi
	movl	%edx, (%rsp)
	call	strcmp@PLT
	movl	(%rsp), %edx
	testl	%eax, %eax
	je	.L212
	leaq	.LC25(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movl	(%rsp), %edx
	testl	%eax, %eax
	je	.L212
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movl	(%rsp), %edx
	testl	%eax, %eax
	je	.L212
	testq	%r12, %r12
	jg	.L486
	.p2align 4
	.p2align 3
.L239:
	movq	(%rbx), %rdi
	xorl	%eax, %eax
	leaq	.LC46(%rip), %rsi
	call	fprintf@PLT
	testq	%r14, %r14
	jle	.L267
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L267:
	movq	(%rbx), %rdi
	leaq	.LC47(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movzbl	0(%r13), %ebp
	cmpl	$43, %ebp
	jne	.L269
	cmpb	$0, 1(%r13)
	jne	.L269
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L632
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC48(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L327:
	testq	%r14, %r14
	jle	.L364
.L329:
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movl	25636(%rbx), %r14d
	testl	%r14d, %r14d
	je	.L328
.L364:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC84(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L596:
	movq	(%rbx), %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC135(%rip), %rdi
	call	fwrite@PLT
	jmp	.L476
	.p2align 4,,10
	.p2align 3
.L369:
	testq	%r13, %r13
	jle	.L404
.L371:
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movl	25636(%rbx), %r10d
	testl	%r10d, %r10d
	je	.L370
.L404:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC95(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L405
	.p2align 4,,10
	.p2align 3
.L620:
	movq	104(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L633
	leal	-1(%rax), %edx
	leaq	reg_names(%rip), %rax
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	movq	(%rax,%rdx,8), %rdx
	movq	120(%rsp), %rbx
	leaq	.LC21(%rip), %rsi
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L614:
	testq	%r14, %r14
	jle	.L167
	jmp	.L584
	.p2align 4,,10
	.p2align 3
.L623:
	leaq	.LC18(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L191
	testl	%ebp, %ebp
	leaq	.LC13(%rip), %rsi
	leaq	.LC12(%rip), %rax
	cmovne	%rax, %rsi
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L634
	movq	128(%rsp), %rbp
	movq	%rbx, %rdi
	movq	120(%rsp), %rbx
	xorl	%eax, %eax
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L601:
	movq	160(%rsp), %r15
.L452:
	movq	%rbp, %rdi
	call	node_child@PLT


	movq	%rax, %rbp
	testq	%rax, %rax
	jle	.L469
.L471:
	movq	%rbp, %rdi
	call	node_kind@PLT
	cmpq	$3, %rax
	je	.L635
.L470:
	movq	%rbp, %rdi
	call	node_sibling@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jg	.L471
.L469:
	movl	25636(%rbx), %r10d
	movq	(%rbx), %rdi
	testl	%r10d, %r10d
	je	.L472
	leaq	.LC114(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L167
	.p2align 4,,10
	.p2align 3
.L602:
	movl	25636(%rbx), %edx
	xorl	%r15d, %r15d
	testl	%edx, %edx
	je	.L459
.L487:
	movl	8(%rsp), %eax
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	leaq	.LC126(%rip), %rsi
	movl	64(%r15), %r8d
	leal	8(,%rax,4), %edx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L460
.L454:
	movl	25636(%rbx), %r15d
	testl	%r15d, %r15d
	jne	.L636
.L459:
	xorl	%r15d, %r15d
.L461:
	movl	8(%rsp), %r11d
	testl	%r11d, %r11d
	je	.L637
	cmpl	$1, 8(%rsp)
	je	.L638
	cmpl	$2, 8(%rsp)
	je	.L639
	cmpl	$3, 8(%rsp)
	jne	.L460
	movl	64(%r15), %edx
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	xorl	%eax, %eax
	leaq	.LC134(%rip), %rsi
	call	fprintf@PLT
	jmp	.L460
	.p2align 4,,10
	.p2align 3
.L590:
	movq	%rbp, %rdi
	call	node_sibling@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	jle	.L437
	movq	%rax, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movl	25636(%rbx), %eax
	movq	(%rbx), %rdi
	movq	%r12, %rdx
	testl	%eax, %eax
	je	.L438
	leaq	.LC97(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L439:
	movq	%r13, %rdi
	call	node_sibling@PLT
	movq	%rax, %rbp
	jmp	.L588
	.p2align 4,,10
	.p2align 3
.L568:
	testq	%r14, %r14
	jle	.L167
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movl	$16, %edx
	jmp	.L500
	.p2align 4,,10
	.p2align 3
.L185:
	movl	$16, %edx
	jmp	.L201
	.p2align 4,,10
	.p2align 3
.L472:
	leaq	.LC115(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	16(%rsp), %ebp
	subl	$1, %ebp
	js	.L474
	movl	%ebp, %ebp
	leaq	reg_names(%rip), %r14
	leaq	.LC116(%rip), %r12
	.p2align 4
	.p2align 3
.L475:
	movq	(%r14,%rbp,8), %rdx
	movq	(%rbx), %rdi
	movq	%r12, %rsi
	xorl	%eax, %eax
	subq	$1, %rbp
	call	fprintf@PLT
	testl	%ebp, %ebp
	jns	.L475
.L474:
	movq	(%rbx), %rdi
	leaq	.LC117(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L167
	.p2align 4,,10
	.p2align 3
.L448:
	movq	(%rbx), %rdi
	movq	%rbp, %rsi
	movl	25632(%rbx), %edx
	movl	%edx, 25648(%rbx)
	call	check_and_emit_guard_fastpath@PLT
	addl	$1, 25632(%rbx)
	xorl	%eax, %eax
	leaq	.LC123(%rip), %rsi
	movq	(%rbx), %rdi
	call	fprintf@PLT


	testl	%r12d, %r12d
	jle	.L450
	xorl	%r12d, %r12d
	leaq	reg_names(%rip), %r14
	.p2align 4
	.p2align 3
.L451:
	movq	(%r14,%r12,8), %rdx
	movq	(%rbx), %rdi
	leaq	.LC124(%rip), %rsi
	xorl	%eax, %eax
	addq	$1, %r12
	call	fprintf@PLT
	cmpl	%r12d, 16(%rsp)
	jg	.L451
.L450:
	movq	(%rbx), %rdi
	leaq	.LC125(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	(%rbx), %rdi
	movl	25648(%rbx), %esi
	call	emit_tco_loop_header@PLT
	jmp	.L449

	.p2align 4,,10
	.p2align 3
.L635:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	jmp	.L470
	.p2align 4,,10
	.p2align 3
.L203:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L640
	movq	120(%rsp), %rbx
	movq	%r13, %rcx
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	leaq	.LC23(%rip), %rsi
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L447:
	movq	%r14, %r8
	movq	%r14, %rcx
	movq	%r13, %rdx
	xorl	%eax, %eax
	leaq	.LC120(%rip), %rsi
	call	fprintf@PLT
	jmp	.L446
	.p2align 4,,10
	.p2align 3
.L625:
	movq	%r13, %rdi
	call	node_sibling@PLT
	testq	%rax, %rax
	jle	.L167
	movq	%rbx, %rdi
	movq	%rax, %rsi
	call	gen_node_x86.part.0
	movl	25636(%rbx), %r8d
	movq	(%rbx), %rdi
	movq	%r12, %rdx
	testl	%r8d, %r8d
	je	.L415
	leaq	.LC97(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L167
	.p2align 4,,10
	.p2align 3
.L600:
	movq	%r14, %rdx
	leaq	.LC118(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L446
	.p2align 4,,10
	.p2align 3
.L307:
	testq	%r14, %r14
	jle	.L167
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movl	$16, %edx
	jmp	.L321
	.p2align 4,,10
	.p2align 3
.L608:
	movq	%r14, %rdi
	call	node_kind@PLT
	cmpq	$7, %rax
	jne	.L329
	movq	%r14, %rdi
	movq	%r15, 160(%rsp)
	call	node_child@PLT
	movq	%rax, %rdi
	movq	%rax, (%rsp)
	call	node_sibling@PLT
	movq	%r14, %rdi
	movq	%rax, 8(%rsp)
	call	node_text@PLT
	movq	(%rsp), %rcx
	movq	%rax, %r15
	testq	%rcx, %rcx
	jle	.L330
	movq	%rcx, %rdi
	call	node_kind@PLT
	cmpq	$8, %rax
	jne	.L331
	movq	8(%rsp), %rax
	testq	%rax, %rax
	jle	.L332
	movq	%rax, %rdi
	call	node_kind@PLT
	cmpq	$9, %rax
	je	.L641
.L334:
	movq	(%rsp), %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L345:
	movq	8(%rsp), %rdi
	call	node_kind@PLT
	cmpq	$9, %rax
	je	.L642
	movq	(%rbx), %rdi
	leaq	.LC46(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	8(%rsp), %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L349:
	movq	(%rbx), %rdi
	leaq	.LC83(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L348:
	movzbl	(%r15), %edx
	movl	%edx, %eax
	subl	$60, %eax
	jne	.L350
	movzbl	1(%r15), %eax
	subl	$61, %eax
	jne	.L350
	movzbl	2(%r15), %eax
.L350:
	movq	(%rbx), %r14
	testl	%eax, %eax
	je	.L643
	movzbl	(%r15), %eax
	cmpl	$60, %eax
	jne	.L354
	cmpb	$0, 1(%r15)
	jne	.L354
	movl	%ebp, %edx
	leaq	.LC73(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L352:
	testq	%r12, %r12
	jle	.L361
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L361:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC79(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	(%rbx), %rdi
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC80(%rip), %rsi
	call	fprintf@PLT
	testq	%r13, %r13
	jg	.L644
.L362:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L645
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	movl	%ebp, %edx
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	leaq	.LC81(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L611:
	movq	%r13, %rdi
	call	node_kind@PLT
	cmpq	$7, %rax
	jne	.L371
	movq	%r13, %rdi
	movq	%r15, 160(%rsp)
	call	node_child@PLT
	movq	%rax, %rdi
	movq	%rax, %r15
	call	node_sibling@PLT
	movq	%r13, %rdi
	movq	%rax, (%rsp)
	movq	%rax, %r14
	call	node_text@PLT
	movq	%rax, %r13
	testq	%r15, %r15
	jle	.L372
	movq	%r15, %rdi
	call	node_kind@PLT
	cmpq	$8, %rax
	jne	.L373
	testq	%r14, %r14
	jle	.L374
	movq	%r14, %rdi
	call	node_kind@PLT
	cmpq	$9, %rax
	je	.L646
.L376:
	movq	%r15, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L386:
	movq	(%rsp), %rdi
	call	node_kind@PLT
	cmpq	$9, %rax
	je	.L647
	movq	(%rbx), %rdi
	leaq	.LC46(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	(%rsp), %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L390:
	movq	(%rbx), %rdi
	leaq	.LC83(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L389:
	movzbl	0(%r13), %eax
	movl	%eax, %edx
	subl	$60, %edx
	jne	.L391
	movzbl	1(%r13), %edx
.L391:
	movq	(%rbx), %r14
	testl	%edx, %edx
	je	.L648
	movzbl	0(%r13), %edx
	cmpl	$60, %edx
	jne	.L395
	cmpb	$61, 1(%r13)
	jne	.L395
	cmpb	$0, 2(%r13)
	jne	.L395
	movl	%ebp, %edx
	leaq	.LC88(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
.L393:
	testq	%r12, %r12
	jle	.L402
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L402:
	movq	(%rbx), %rdi
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC93(%rip), %rsi
	call	fprintf@PLT
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L649
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	movl	%ebp, %edx
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	leaq	.LC94(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L196:
	testq	%r13, %r13
	jle	.L196_regular
	cmpb	$48, (%r13)
	jne	.L196_regular
	cmpb	$0, 1(%r13)
	jne	.L196_regular
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L650
	movq	128(%rsp), %rbp
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	136(%rsp), %r12
	leaq	.LC15(%rip), %rsi
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L196_regular:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L650
	movq	128(%rsp), %rbp
	movq	%r13, %rdx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	136(%rsp), %r12
	leaq	.LC20(%rip), %rsi
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT


	.p2align 4,,10
	.p2align 3
.L242:
	cmpl	$45, %ebp
	jne	.L245
	cmpb	$0, 1(%r13)
	jne	.L245
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L651
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC38(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L269:
	cmpl	$45, %ebp
	jne	.L272
	cmpb	$0, 1(%r13)
	jne	.L272
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L652
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC49(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L609:
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	jmp	.L367
	.p2align 4,,10
	.p2align 3
.L637:
	movl	64(%r15), %edx
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	xorl	%eax, %eax
	leaq	.LC131(%rip), %rsi
	call	fprintf@PLT
	jmp	.L460
	.p2align 4,,10
	.p2align 3
.L408:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L653
	movq	120(%rsp), %rbx
	movq	%r12, %rdx
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	leaq	.LC98(%rip), %rsi
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L622:
	movq	%rbx, %rdi
	movq	%r13, %rsi
	call	add_string
	movl	25636(%rbx), %edx
	movq	(%rbx), %rdi
	testl	%edx, %edx
	je	.L187
	movq	104(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L654
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movl	%eax, %edx
	leaq	.LC16(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	xorl	%eax, %eax
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L481:
	movl	$18, %edx
	movl	$1, %esi
	leaq	.LC138(%rip), %rdi
	call	fwrite@PLT
	jmp	.L480
	.p2align 4,,10
	.p2align 3
.L597:
	movl	$44, %edx
	movl	$1, %esi
	leaq	.LC136(%rip), %rdi
	call	fwrite@PLT
	jmp	.L480
	.p2align 4,,10
	.p2align 3
.L272:
	cmpl	$42, %ebp
	jne	.L275
	cmpb	$0, 1(%r13)
	jne	.L275
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L655
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC50(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
	.p2align 4,,10
	.p2align 3
.L245:
	cmpl	$42, %ebp
	jne	.L248
	cmpb	$0, 1(%r13)
	jne	.L248
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L656
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC39(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L508:
	cmpl	$43, %ebp
	jne	.L509
	cmpb	$0, 1(%r13)
	jne	.L509
	testq	%r12, %r12
	jg	.L484
.L485:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L657
	movq	(%rbx), %rdi
	movq	128(%rsp), %rbp
	movq	%r15, %rdx
	xorl	%eax, %eax
	movq	160(%rsp), %r15
	movq	120(%rsp), %rbx
	leaq	.LC28(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L604:
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	leaq	.LC127(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L460
.L417:
	movq	%r13, %rdi
	call	node_sibling@PLT
	movq	%rax, %rbp
	movl	25636(%rbx), %eax
	testq	%rbp, %rbp
	jle	.L565
	testl	%eax, %eax
	je	.L658
	testq	%rbp, %rbp
	jle	.L565
.L420:
	xorl	%r12d, %r12d
.L423:
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	call	gen_node_x86.part.0
	movl	25636(%rbx), %ecx
	movq	(%rbx), %rdi
	testl	%ecx, %ecx
	je	.L421
	leaq	.LC35(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L422:
	movq	%rbp, %rdi
	addl	$1, %r12d
	call	node_sibling@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jg	.L423
	movl	25636(%rbx), %edx
	testl	%edx, %edx
	jne	.L425
	movq	(%rbx), %rdi
	cmpl	$1, %r12d
	je	.L659
	cmpl	$2, %r12d
	je	.L660
	cmpl	$3, %r12d
	je	.L661
	cmpl	$4, %r12d
	je	.L662
.L426:
	movq	%r14, %rdx
	leaq	.LC113(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L167
	.p2align 4,,10
	.p2align 3
.L421:
	leaq	.LC46(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L422
.L304:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L663
	movq	120(%rsp), %rbx
	movq	%r13, %rcx
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	leaq	.LC61(%rip), %rsi
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L191:
	testl	%ebp, %ebp
	leaq	.LC15(%rip), %rsi
	leaq	.LC14(%rip), %rax
	cmovne	%rax, %rsi
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L664
	movq	128(%rsp), %rbp
	movq	%rbx, %rdi
	movq	120(%rsp), %rbx
	xorl	%eax, %eax
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L594:
	movq	104(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L665
	leal	-1(%rax), %edx
	leaq	reg_names(%rip), %rax
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	movq	(%rax,%rdx,8), %rdx
	movq	120(%rsp), %rbx
	leaq	.LC59(%rip), %rsi
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L248:
	movzbl	0(%r13), %edx
	cmpl	$60, %edx
	jne	.L251
	cmpb	$61, 1(%r13)
	jne	.L251
	cmpb	$0, 2(%r13)
	jne	.L251
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L666
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC40(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L275:
	cmpl	$47, %ebp
	jne	.L278
	cmpb	$0, 1(%r13)
	jne	.L278
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L667
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC51(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L324:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L668
	movq	120(%rsp), %rbx
	movq	%r13, %rcx
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	leaq	.LC68(%rip), %rsi
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L418:
	leaq	.LC106(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L167
.L187:
	movq	104(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L669
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movl	%eax, %edx
	leaq	.LC17(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	xorl	%eax, %eax
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L616:
	movq	104(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L670
	leal	-1(%rax), %edx
	leaq	reg_names(%rip), %rax
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	movq	(%rax,%rdx,8), %rdx
	movq	120(%rsp), %rbx
	leaq	.LC66(%rip), %rsi
	xorl	%eax, %eax
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L217:
	cmpl	$43, %ebp
	jne	.L583
	cmpb	$0, 1(%r13)
	je	.L485
.L583:
	movzbl	0(%r13), %edx
.L220:
	cmpl	$60, %edx
	jne	.L223
	cmpb	$61, 1(%r13)
	jne	.L223
	cmpb	$0, 2(%r13)
	jne	.L223
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L671
	movq	(%rbx), %rdi
	movq	128(%rsp), %rbp
	movq	%r15, %rdx
	xorl	%eax, %eax
	movq	160(%rsp), %r15
	movq	120(%rsp), %rbx
	leaq	.LC29(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L638:
	movl	64(%r15), %edx
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	xorl	%eax, %eax
	leaq	.LC132(%rip), %rsi
	call	fprintf@PLT
	jmp	.L460
.L438:
	leaq	.LC98(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L439
.L251:
	cmpl	$60, %ebp
	jne	.L254
	cmpb	$0, 1(%r13)
	jne	.L254
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L672
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC41(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L278:
	cmpl	$37, %ebp
	jne	.L281
	cmpb	$0, 1(%r13)
	jne	.L281
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L673
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC52(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L509:
	movzbl	0(%r13), %edx
	cmpl	$60, %edx
	jne	.L510
	cmpb	$61, 1(%r13)
	jne	.L510
	cmpb	$0, 2(%r13)
	jne	.L510
.L212:
	testq	%r12, %r12
	jg	.L484
	jmp	.L220
.L639:
	movl	64(%r15), %edx
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	xorl	%eax, %eax
	leaq	.LC133(%rip), %rsi
	call	fprintf@PLT
	jmp	.L460
.L415:
	leaq	.LC98(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L167
.L223:
	cmpl	$60, %ebp
	jne	.L226
	cmpb	$0, 1(%r13)
	jne	.L226
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L674
	movq	(%rbx), %rdi
	movq	128(%rsp), %rbp
	movq	%r15, %rdx
	xorl	%eax, %eax
	movq	160(%rsp), %r15
	movq	120(%rsp), %rbx
	leaq	.LC30(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L605:
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	leaq	.LC128(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L460
.L254:
	cmpl	$62, %ebp
	jne	.L257
	cmpb	$0, 1(%r13)
	jne	.L257
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L675
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC42(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L281:
	movzbl	0(%r13), %edx
	cmpl	$60, %edx
	jne	.L284
	cmpb	$61, 1(%r13)
	jne	.L284
	cmpb	$0, 2(%r13)
	jne	.L284
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L676
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC53(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L606:
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	leaq	.LC129(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L460
.L505:
	xorl	%r12d, %r12d
.L425:
	movq	(%rbx), %rdi
	leal	0(,%r12,4), %ecx
	movq	%r14, %rdx
	xorl	%eax, %eax
	leaq	.LC108(%rip), %rsi
	call	fprintf@PLT
	jmp	.L167
.L226:
	cmpl	$62, %ebp
	jne	.L229
	cmpb	$0, 1(%r13)
	jne	.L229
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L677
	movq	(%rbx), %rdi
	movq	128(%rsp), %rbp
	movq	%r15, %rdx
	xorl	%eax, %eax
	movq	160(%rsp), %r15
	movq	120(%rsp), %rbx
	leaq	.LC31(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L607:
	movq	(%rbx), %rdi
	movq	%r13, %rcx
	leaq	.LC130(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L460
.L373:
	movq	%r15, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L372:
	cmpq	$0, (%rsp)
	jg	.L386
.L387:
	movq	(%rbx), %rdi
	leaq	.LC46(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L390
.L331:
	movq	(%rsp), %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
.L330:
	cmpq	$0, 8(%rsp)
	jg	.L345
.L346:
	movq	(%rbx), %rdi
	leaq	.LC46(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L349
.L257:
	cmpl	$62, %edx
	jne	.L260
	cmpb	$61, 1(%r13)
	jne	.L260
	cmpb	$0, 2(%r13)
	jne	.L260
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L678
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC43(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L284:
	cmpl	$60, %ebp
	jne	.L287
	cmpb	$0, 1(%r13)
	jne	.L287
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L679
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC54(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L615:
	movq	%r14, %rdi
	movq	%r15, 160(%rsp)
	call	node_child@PLT
	movq	%rax, %rdi
	movq	%rax, %r15
	call	node_sibling@PLT
	movq	%r14, %rdi
	movq	%rax, %r12
	call	node_text@PLT
	movq	%rax, (%rsp)
	testq	%r15, %r15
	jg	.L680
.L311:
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	movq	160(%rsp), %r15
	jmp	.L320
.L565:
	testl	%eax, %eax
	jne	.L505
.L587:
	movq	(%rbx), %rdi
	jmp	.L426
.L229:
	cmpl	$62, %edx
	jne	.L232
	cmpb	$61, 1(%r13)
	jne	.L232
	cmpb	$0, 2(%r13)
	jne	.L232
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L681
	movq	(%rbx), %rdi
	movq	128(%rsp), %rbp
	movq	%r15, %rdx
	xorl	%eax, %eax
	movq	160(%rsp), %r15
	movq	120(%rsp), %rbx
	leaq	.LC32(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L658:
	movq	%rbp, %rdi
	call	node_sibling@PLT
	testq	%rax, %rax
	jg	.L420
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86
	movq	(%rbx), %rdi
	movq	%r14, %rdx
	xorl	%eax, %eax
	leaq	.LC107(%rip), %rsi
	call	fprintf@PLT
	jmp	.L167
.L395:
	cmpl	$62, %eax
	jne	.L397
	cmpb	$0, 1(%r13)
	jne	.L397
	movl	%ebp, %edx
	leaq	.LC89(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L393
.L354:
	cmpl	$62, %edx
	jne	.L356
	cmpb	$61, 1(%r15)
	jne	.L356
	cmpb	$0, 2(%r15)
	jne	.L356
	movl	%ebp, %edx
	leaq	.LC74(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L352
.L287:
	cmpl	$62, %ebp
	jne	.L290
	cmpb	$0, 1(%r13)
	jne	.L290
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L682
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC55(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L260:
	cmpl	$61, %edx
	jne	.L263
	cmpb	$61, 1(%r13)
	jne	.L263
	cmpb	$0, 2(%r13)
	jne	.L263
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L683
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC44(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L232:
	cmpl	$61, %edx
	jne	.L235
	cmpb	$61, 1(%r13)
	jne	.L235
	cmpb	$0, 2(%r13)
	jne	.L235
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L684
	movq	(%rbx), %rdi
	movq	128(%rsp), %rbp
	movq	%r15, %rdx
	xorl	%eax, %eax
	movq	160(%rsp), %r15
	movq	120(%rsp), %rbx
	leaq	.LC33(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L659:
	leaq	.LC109(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	(%rbx), %rdi
	jmp	.L426
.L648:
	movl	%ebp, %edx
	leaq	.LC87(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L393
.L643:
	movl	%ebp, %edx
	leaq	.LC71(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	jmp	.L352
.L397:
	cmpl	$62, %edx
	jne	.L399
	cmpb	$61, 1(%r13)
	jne	.L399
	cmpb	$0, 2(%r13)
	jne	.L399
	movl	%ebp, %edx
	leaq	.LC90(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L393
.L356:
	cmpl	$62, %eax
	jne	.L358
	cmpb	$0, 1(%r15)
	jne	.L358
	movl	%ebp, %edx
	leaq	.LC76(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L352
.L290:
	cmpl	$62, %edx
	jne	.L293
	cmpb	$61, 1(%r13)
	jne	.L293
	cmpb	$0, 2(%r13)
	jne	.L293
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L685
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC56(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L660:
	leaq	.LC110(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	(%rbx), %rdi
	jmp	.L426
.L263:
	cmpl	$33, %edx
	jne	.L582
	cmpb	$61, 1(%r13)
	jne	.L582
	cmpb	$0, 2(%r13)
	jne	.L582
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L686
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC45(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L582:
	movq	160(%rsp), %r15
	jmp	.L167
.L235:
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L582
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L687
	movq	(%rbx), %rdi
	movq	128(%rsp), %rbp
	movq	%r15, %rdx
	xorl	%eax, %eax
	movq	160(%rsp), %r15
	movq	120(%rsp), %rbx
	leaq	.LC34(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L680:
	movq	%r15, %rdi
	call	node_kind@PLT
	cmpq	$8, %rax
	jne	.L311
	movq	%r15, %rdi
	call	node_text@PLT
	movq	%r13, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L311
	testq	%r12, %r12
	jle	.L311
	movq	%r12, %rdi
	call	node_kind@PLT
	cmpq	$9, %rax
	jne	.L311
	movq	(%rsp), %rdi
	leaq	.LC62(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L688
	movq	(%rsp), %rdi
	leaq	.LC64(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L311
	movl	68(%rbp), %eax
	leaq	reg_names(%rip), %rdx
	movq	%r12, %rdi
	subl	$1, %eax
	cltq
	movq	(%rdx,%rax,8), %rbp
	call	node_text@PLT
	movq	104(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L689
	movq	(%rbx), %rdi
	movq	%r13, %r8
	movq	120(%rsp), %rbx
	movq	%rbp, %rcx
	movq	160(%rsp), %r15
	movq	128(%rsp), %rbp
	movq	%rax, %rdx
	leaq	.LC65(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	xorl	%eax, %eax
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L644:
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	jmp	.L362
.L661:
	leaq	.LC111(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movq	(%rbx), %rdi
	jmp	.L426
.L358:
	leaq	.LC25(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L690
	leaq	.LC26(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	movl	%ebp, %edx
	leaq	.LC78(%rip), %rsi
	movq	%r14, %rdi
	testl	%eax, %eax
	je	.L585
	xorl	%eax, %eax
.L585:
	call	fprintf@PLT
	jmp	.L352
.L293:
	leaq	.LC25(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L691
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L582
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L692
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC58(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L399:
	leaq	.LC25(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L693
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	movl	%ebp, %edx
	leaq	.LC92(%rip), %rsi
	movq	%r14, %rdi
	testl	%eax, %eax
	je	.L586
	xorl	%eax, %eax
.L586:
	call	fprintf@PLT
	jmp	.L393
.L374:
	movq	%r15, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	jmp	.L387
.L332:
	movq	(%rsp), %rsi
	movq	%rbx, %rdi
	call	gen_node_x86.part.0
	jmp	.L346
.L662:
	leaq	.LC112(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L587
.L647:
	movq	(%rsp), %rdi
	call	node_text@PLT
	movq	(%rbx), %rdi
	leaq	.LC82(%rip), %rsi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L389
.L642:
	movq	8(%rsp), %rdi
	call	node_text@PLT
	movq	(%rbx), %rdi
	leaq	.LC82(%rip), %rsi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L348
.L646:
	movq	%r15, %rdi
	call	node_text@PLT
	movq	%rax, 16(%rsp)
	movl	9224(%rbx), %eax
	testl	%eax, %eax
	jle	.L376
	imulq	$72, %rax, %rax
	leaq	8(%rbx), %r14
	addq	%r14, %rax
	movq	%rax, 8(%rsp)
	jmp	.L378
.L694:
	addq	$72, %r14
	cmpq	8(%rsp), %r14
	je	.L376
.L378:
	movq	16(%rsp), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L694
	movl	68(%r14), %eax
	testl	%eax, %eax
	jle	.L376
	leal	-1(%rax), %edx
	movq	(%rsp), %rdi
	leaq	reg_names(%rip), %rax
	movq	(%rax,%rdx,8), %r14
	call	node_text@PLT
	movq	(%rbx), %rdi
	leaq	.LC69(%rip), %rsi
	movq	%rax, %rdx
	movq	%r14, %rcx
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC72(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L695
	leaq	.LC70(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L696
	leaq	.LC75(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L697
	leaq	.LC24(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L698
	leaq	.LC25(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L699
	leaq	.LC26(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L700
.L380:
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86
	movq	(%rbx), %rdi
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC93(%rip), %rsi
	call	fprintf@PLT
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L701
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	movl	%ebp, %edx
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	leaq	.LC94(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L641:
	movq	(%rsp), %rdi
	call	node_text@PLT
	movq	%rax, 24(%rsp)
	movl	9224(%rbx), %eax
	testl	%eax, %eax
	jle	.L334
	imulq	$72, %rax, %rax
	leaq	8(%rbx), %r14
	addq	%r14, %rax
	movq	%rax, 16(%rsp)
	jmp	.L336
.L702:
	addq	$72, %r14
	cmpq	%r14, 16(%rsp)
	je	.L334
.L336:
	movq	24(%rsp), %rsi
	movq	%r14, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L702
	movl	68(%r14), %eax
	testl	%eax, %eax
	jle	.L334
	leal	-1(%rax), %edx
	movq	8(%rsp), %rdi
	leaq	reg_names(%rip), %rax
	movq	(%rax,%rdx,8), %r14
	call	node_text@PLT
	movq	(%rbx), %rdi
	leaq	.LC69(%rip), %rsi
	movq	%rax, %rdx
	movq	%r14, %rcx
	xorl	%eax, %eax
	call	fprintf@PLT
	leaq	.LC70(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L703
	leaq	.LC72(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L704
	leaq	.LC24(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L705
	leaq	.LC75(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L706
	leaq	.LC25(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L707
	leaq	.LC26(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L708
.L338:
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	xorl	%eax, %eax
	leaq	.LC79(%rip), %rsi
	call	fprintf@PLT
	movq	(%rbx), %rdi
	xorl	%eax, %eax
	movl	%ebp, %edx
	leaq	.LC80(%rip), %rsi
	call	fprintf@PLT
	testq	%r13, %r13
	jle	.L343
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	gen_node_x86
.L343:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L709
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	movl	%ebp, %edx
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	leaq	.LC81(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L693:
	movl	%ebp, %edx
	leaq	.LC91(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	jmp	.L393
.L690:
	movl	%ebp, %edx
	leaq	.LC77(%rip), %rsi
	movq	%r14, %rdi
	call	fprintf@PLT
	jmp	.L352
.L691:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L710
	movq	(%rbx), %rdi
	movq	160(%rsp), %r15
	leaq	.LC57(%rip), %rsi
	xorl	%eax, %eax
	movq	120(%rsp), %rbx
	movq	128(%rsp), %rbp
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L592:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L692:
	call	__stack_chk_fail@PLT
.L705:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC74(%rip), %rsi
	call	fprintf@PLT
	jmp	.L338
.L704:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC73(%rip), %rsi
	call	fprintf@PLT
	jmp	.L338
.L703:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC71(%rip), %rsi
	call	fprintf@PLT
	jmp	.L338
.L709:
	call	__stack_chk_fail@PLT
.L707:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC77(%rip), %rsi
	call	fprintf@PLT
	jmp	.L338
.L706:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC76(%rip), %rsi
	call	fprintf@PLT
	jmp	.L338
.L621:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L672:
	call	__stack_chk_fail@PLT
.L612:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L682:
	call	__stack_chk_fail@PLT
.L595:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L628:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L673:
	call	__stack_chk_fail@PLT
.L651:
	call	__stack_chk_fail@PLT
.L681:
	call	__stack_chk_fail@PLT
.L674:
	call	__stack_chk_fail@PLT
.L653:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L632:
	call	__stack_chk_fail@PLT
.L678:
	call	__stack_chk_fail@PLT
.L708:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC78(%rip), %rsi
	call	fprintf@PLT
	jmp	.L338
.L677:
	call	__stack_chk_fail@PLT
.L685:
	call	__stack_chk_fail@PLT
.L679:
	call	__stack_chk_fail@PLT
.L684:
	call	__stack_chk_fail@PLT
.L645:
	call	__stack_chk_fail@PLT
.L629:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L652:
	call	__stack_chk_fail@PLT
.L683:
	call	__stack_chk_fail@PLT
.L686:
	call	__stack_chk_fail@PLT
.L633:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L670:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L654:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L610:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L630:
	call	__stack_chk_fail@PLT
.L650:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L667:
	call	__stack_chk_fail@PLT
.L657:
	call	__stack_chk_fail@PLT
.L634:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L663:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L655:
	call	__stack_chk_fail@PLT
.L617:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L598:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L631:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L640:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L671:
	call	__stack_chk_fail@PLT
.L656:
	call	__stack_chk_fail@PLT
.L665:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L675:
	call	__stack_chk_fail@PLT
.L676:
	call	__stack_chk_fail@PLT
.L669:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L687:
	call	__stack_chk_fail@PLT
.L664:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L701:
	call	__stack_chk_fail@PLT
.L700:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC92(%rip), %rsi
	call	fprintf@PLT
	jmp	.L380
.L699:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC91(%rip), %rsi
	call	fprintf@PLT
	jmp	.L380
.L698:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC90(%rip), %rsi
	call	fprintf@PLT
	jmp	.L380
.L697:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC89(%rip), %rsi
	call	fprintf@PLT
	jmp	.L380
.L696:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC88(%rip), %rsi
	call	fprintf@PLT
	jmp	.L380
.L695:
	movq	(%rbx), %rdi
	movl	%ebp, %edx
	leaq	.LC87(%rip), %rsi
	call	fprintf@PLT
	jmp	.L380
.L624:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L649:
	call	__stack_chk_fail@PLT
.L618:
	call	__stack_chk_fail@PLT
.L668:
	movq	%r15, 160(%rsp)
	call	__stack_chk_fail@PLT
.L689:
	call	__stack_chk_fail@PLT
.L688:
	movl	68(%rbp), %eax
	leaq	reg_names(%rip), %rdx
	movq	%r12, %rdi
	subl	$1, %eax
	cltq
	movq	(%rdx,%rax,8), %rbp
	call	node_text@PLT
	movq	104(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L711
	movq	(%rbx), %rdi
	movq	%r13, %r8
	movq	120(%rsp), %rbx
	movq	%rbp, %rcx
	movq	160(%rsp), %r15
	movq	128(%rsp), %rbp
	movq	%rax, %rdx
	leaq	.LC63(%rip), %rsi
	movq	136(%rsp), %r12
	movq	144(%rsp), %r13
	xorl	%eax, %eax
	movq	152(%rsp), %r14
	addq	$168, %rsp
	jmp	fprintf@PLT
.L666:
	call	__stack_chk_fail@PLT
.L710:
	call	__stack_chk_fail@PLT
.L711:
	call	__stack_chk_fail@PLT
.L636:
	jmp	.L458
	.section	.text.unlikely
	.type	gen_node_x86.part.0.cold, @function
gen_node_x86.part.0.cold:
.L458:
	movl	64, %eax
	ud2
	.text
	.size	gen_node_x86.part.0, .-gen_node_x86.part.0
	.section	.text.unlikely
	.size	gen_node_x86.part.0.cold, .-gen_node_x86.part.0.cold
.LCOLDE140:
	.text
.LHOTE140:
	.section	.rodata.str1.8
	.align 8
.LC141:
	.string	"error: missing required file path for 'check' command\n"
	.text
	.p2align 4
	.globl	cmd_check_native
	.type	cmd_check_native, @function
cmd_check_native:
	testq	%rdi, %rdi
	je	.L713
	cmpb	$0, (%rdi)
	jne	.L722
.L713:
	subq	$8, %rsp
	movq	stderr(%rip), %rcx
	movl	$54, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %eax
	addq	$8, %rsp
	ret
	.p2align 4,,10
	.p2align 3
.L722:
	jmp	cmd_check_native.part.0
	.size	cmd_check_native, .-cmd_check_native
	.section	.rodata.str1.8
	.align 8
.LC142:
	.string	"================================================================="
	.align 8
.LC143:
	.string	" RUBIX UNIVERSAL MULTI-BIT ARCHITECTURE DOCTOR"
	.section	.rodata.str1.1
.LC144:
	.string	"Host Configuration:"
	.section	.rodata.str1.8
	.align 8
.LC145:
	.string	"  Host Architecture:  x86_64 (64-bit)"
	.align 8
.LC146:
	.string	"  Host OS:            Universal Linux (Kernel 4.x+, POSIX/ELF)"
	.align 8
.LC147:
	.string	"  Host Distro:        Agnostic (Ubuntu, Debian, Fedora, RHEL, Alpine, Mint, etc.)"
	.align 8
.LC148:
	.string	"  Host ABI:           System V AMD64 ABI"
	.align 8
.LC149:
	.string	"  Host Linker:        GNU ld / lld"
	.align 8
.LC150:
	.string	"Supported Platforms (64-bit and 32-bit Architecture Families):"
	.align 8
.LC151:
	.string	"  [AVAILABLE]   linux-x64        (All 64-bit Linux distros: Ubuntu, Debian, Fedora, etc.)"
	.align 8
.LC152:
	.string	"  [AVAILABLE]   linux-arm64      (64-bit ARM64 / AArch64: Raspberry Pi, Cloud, Android)"
	.align 8
.LC153:
	.string	"  [AVAILABLE]   macos-arm64      (Apple Silicon M1/M2/M3/M4 macOS Mach-O)"
	.align 8
.LC154:
	.string	"  [AVAILABLE]   windows-x64      (Windows 10, 11, Server x86-64 PE/COFF)"
	.align 8
.LC155:
	.string	"  [AVAILABLE]   macos-x64        (Intel Mac x86-64 Mach-O)"
	.align 8
.LC156:
	.string	"  [AVAILABLE]   linux-riscv64    (64-bit RISC-V Linux ELF)"
	.align 8
.LC157:
	.string	"  [AVAILABLE]   linux-x86        (32-bit Intel/AMD x86 / i686 Legacy PCs)"
	.align 8
.LC158:
	.string	"  [AVAILABLE]   linux-arm32      (32-bit ARMv7: Raspberry Pi 1/2, Embedded IoT)"
	.align 8
.LC159:
	.string	"  [AVAILABLE]   riscv32          (32-bit RISC-V Microcontrollers, ESP32-C3)"
	.align 8
.LC160:
	.string	"  [AVAILABLE]   wasm             (WebAssembly WASI / Browser, Node, Vercel, Cloudflare)"
	.align 8
.LC161:
	.string	"Multi-Platform Status: 10 Target Architectures Operational"
	.text
	.p2align 4
	.globl	cmd_doctor_native
	.type	cmd_doctor_native, @function
cmd_doctor_native:
	subq	$8, %rsp
	leaq	.LC142(%rip), %rdi
	call	puts@PLT
	leaq	.LC143(%rip), %rdi
	call	puts@PLT
	leaq	.LC142(%rip), %rdi
	call	puts@PLT
	leaq	.LC144(%rip), %rdi
	call	puts@PLT
	leaq	.LC145(%rip), %rdi
	call	puts@PLT
	leaq	.LC146(%rip), %rdi
	call	puts@PLT
	leaq	.LC147(%rip), %rdi
	call	puts@PLT
	leaq	.LC148(%rip), %rdi
	call	puts@PLT
	leaq	.LC149(%rip), %rdi
	call	puts@PLT
	leaq	.LC142(%rip), %rdi
	call	puts@PLT
	leaq	.LC150(%rip), %rdi
	call	puts@PLT
	leaq	.LC151(%rip), %rdi
	call	puts@PLT
	leaq	.LC152(%rip), %rdi
	call	puts@PLT
	leaq	.LC153(%rip), %rdi
	call	puts@PLT
	leaq	.LC154(%rip), %rdi
	call	puts@PLT
	leaq	.LC155(%rip), %rdi
	call	puts@PLT
	leaq	.LC156(%rip), %rdi
	call	puts@PLT
	leaq	.LC157(%rip), %rdi
	call	puts@PLT
	leaq	.LC158(%rip), %rdi
	call	puts@PLT
	leaq	.LC159(%rip), %rdi
	call	puts@PLT
	leaq	.LC160(%rip), %rdi
	call	puts@PLT
	leaq	.LC142(%rip), %rdi
	call	puts@PLT
	leaq	.LC161(%rip), %rdi
	call	puts@PLT
	leaq	.LC142(%rip), %rdi
	call	puts@PLT
	xorl	%eax, %eax
	addq	$8, %rsp
	ret
	.size	cmd_doctor_native, .-cmd_doctor_native
	.section	.rodata.str1.1
.LC162:
	.string	"x86_64-unknown-linux-gnu"
.LC163:
	.string	"aarch64-unknown-linux-gnu"
.LC164:
	.string	"aarch64-apple-darwin"
.LC165:
	.string	"x86_64-w64-mingw32"
.LC166:
	.string	"x86_64-apple-darwin"
.LC167:
	.string	"wasm32-unknown-unknown"
.LC168:
	.string	"riscv64-unknown-linux-gnu"
.LC169:
	.string	"i686-unknown-linux-gnu"
.LC170:
	.string	"arm-unknown-linux-gnueabi"
.LC171:
	.string	"riscv32-unknown-linux-gnu"
	.section	.rodata.str1.8
	.align 8
.LC172:
	.string	"error: file not found or empty: %s\n"
	.section	.rodata.str1.1
.LC173:
	.string	"linux-x64"
.LC174:
	.string	"linux-amd64"
.LC175:
	.string	"linux64"
.LC176:
	.string	"linux-arm64"
.LC177:
	.string	"arm64"
.LC178:
	.string	"aarch64"
.LC179:
	.string	"macos-arm64"
.LC180:
	.string	"macos"
.LC181:
	.string	"apple-silicon"
.LC182:
	.string	"windows-x64"
.LC183:
	.string	"windows"
.LC184:
	.string	"win64"
.LC185:
	.string	"macos-x64"
.LC186:
	.string	"macos-intel"
.LC187:
	.string	"wasm"
.LC188:
	.string	"web"
.LC189:
	.string	"browser"
.LC190:
	.string	"vercel"
.LC191:
	.string	"linux-riscv64"
.LC192:
	.string	"riscv64"
.LC193:
	.string	"linux-x86"
.LC194:
	.string	"linux-32"
.LC195:
	.string	"x86-32"
.LC196:
	.string	"linux-arm32"
.LC197:
	.string	"arm32"
.LC198:
	.string	"raspberry-pi"
.LC199:
	.string	"linux-riscv32"
.LC200:
	.string	"riscv32"
.LC201:
	.string	"%s.s"
.LC202:
	.string	"w"
	.section	.rodata.str1.8
	.align 8
.LC203:
	.string	"error: cannot open %s for writing\n"
	.section	.rodata.str1.1
.LC204:
	.string	"riscv"
	.section	.rodata.str1.8
	.align 8
.LC205:
	.string	"clang -target %s -c -x c /dev/null -o %s"
	.align 8
.LC206:
	.string	"error: cross-compilation failed for target %s\n"
	.align 8
.LC207:
	.string	"Compiled RISC-V binary for target %s: %s\n"
	.section	.rodata.str1.1
.LC208:
	.string	"arm-"
.LC209:
	.string	"armv7"
	.section	.rodata.str1.8
	.align 8
.LC210:
	.string	"Compiled 32-bit ARM binary for target %s: %s\n"
	.section	.rodata.str1.1
.LC211:
	.string	"i686"
.LC212:
	.string	"i386"
.LC213:
	.string	"x86_32"
.LC214:
	.string	"clang -target %s -c %s -o %s"
	.section	.rodata.str1.8
	.align 8
.LC215:
	.string	"Compiled 32-bit x86 binary for target %s: %s\n"
	.section	.rodata.str1.1
.LC216:
	.string	"darwin"
.LC217:
	.string	"apple"
.LC218:
	.string	"_"
	.section	.rodata.str1.8
	.align 8
.LC219:
	.string	"Compiled AArch64 binary for target %s: %s\n"
	.section	.rodata.str1.1
.LC220:
	.string	"%s.wat"
	.section	.rodata.str1.8
	.align 8
.LC221:
	.string	"(module\n  (memory (export \"memory\") 2)\n  (func $main (export \"main\") (result i32)\n    i32.const 0\n  )\n)\n"
	.align 8
.LC222:
	.string	"clang -target wasm32-unknown-unknown -c -x c /dev/null -o %s"
	.align 8
.LC223:
	.string	"error: WebAssembly generation failed\n"
	.align 8
.LC224:
	.string	"Compiled WebAssembly module: %s\n"
	.section	.rodata.str1.1
.LC225:
	.string	"mingw"
	.section	.rodata.str1.8
	.align 8
.LC226:
	.string	"Compiled Windows COFF binary for target %s: %s\n"
	.align 8
.LC227:
	.string	"Compiled macOS Mach-O binary for target %s: %s\n"
	.section	.rodata.str1.1
.LC228:
	.string	"x86_64-linux"
.LC229:
	.string	"host"
.LC230:
	.string	"default"
	.section	.rodata.str1.8
	.align 8
.LC231:
	.string	"error: target '%s' is not supported on this host\n"
	.align 8
.LC232:
	.string	"  = help: run 'rubix doctor' to inspect supported target platforms\n"
	.section	.rodata.str1.1
.LC233:
	.string	"%s.o"
	.section	.rodata.str1.8
	.align 8
.LC234:
	.string	"error: assembly or linking failed\n"
	.align 8
.LC235:
	.string	"Compiled native ELF binary: %s\n"
	.text
	.p2align 4
	.globl	compile_file
	.type	compile_file, @function
compile_file:
	pushq	%r15
	movq	%rsi, %r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	movq	%rdi, %rbx
	subq	$132712, %rsp
	movq	%fs:40, %r13
	movq	%r13, 132696(%rsp)
	movq	%rdx, %r13
	call	read_file@PLT
	testq	%rax, %rax
	je	.L726
	movq	%rax, %rbp
	cmpb	$0, (%rax)
	je	.L726
	xorl	%r12d, %r12d
	testq	%r13, %r13
	je	.L729
	leaq	.LC173(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L731
	leaq	.LC174(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L731
	leaq	.LC175(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L731
	leaq	.LC176(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L733
	leaq	.LC177(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L733
	leaq	.LC178(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L733
	leaq	.LC179(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L735
	leaq	.LC180(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L735
	leaq	.LC181(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L735
	leaq	.LC182(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L737
	leaq	.LC183(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L737
	leaq	.LC184(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L737
	leaq	.LC185(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L739
	leaq	.LC186(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L739
	leaq	.LC187(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L741
	leaq	.LC188(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L741
	leaq	.LC189(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L741
	leaq	.LC190(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L741
	leaq	.LC191(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L743
	leaq	.LC192(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L743
	leaq	.LC193(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L745
	leaq	.LC194(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L745
	leaq	.LC195(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L745
	leaq	.LC196(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L747
	leaq	.LC197(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L747
	leaq	.LC198(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L747
	leaq	.LC199(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L792
	leaq	.LC200(%rip), %rsi
	movq	%r13, %rdi
	leaq	.LC171(%rip), %r12
	call	strcmp@PLT
	testl	%eax, %eax
	cmovne	%r13, %r12
	.p2align 4
	.p2align 3
.L729:
	call	node_arena_reset@PLT
	movq	%rbp, %rdi
	call	init_lexer@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	init_parser@PLT
	movq	%rax, %r14
	movq	%rax, %rdi
	call	parse_program@PLT
	movq	24(%r14), %rdx
	movq	%rax, %rbp
	testq	%rdx, %rdx
	jg	.L876
	xorl	%esi, %esi
	movl	$103692, %edx
	leaq	25664(%rsp), %rdi
	call	memset@PLT
	testq	%rbp, %rbp
	jle	.L750
	xorl	%edx, %edx
	movq	%rbp, %rsi
	leaq	25664(%rsp), %rdi
	call	validate_node_tree.part.0
	movl	129352(%rsp), %edx
	testl	%edx, %edx
	jle	.L750
	movq	stderr(%rip), %rdi
	leaq	.LC7(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L874
	.p2align 4,,10
	.p2align 3
.L731:
	leaq	.LC162(%rip), %r12
	jmp	.L729
	.p2align 4,,10
	.p2align 3
.L750:
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	run_semantic_analysis@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	run_typechecker@PLT
	movq	%rbp, %rdi
	call	run_ast_optimizer@PLT
	movq	%r15, %rcx
	movl	$512, %esi
	xorl	%eax, %eax
	leaq	.LC201(%rip), %rdx
	leaq	129616(%rsp), %rdi
	call	snprintf@PLT
	leaq	.LC202(%rip), %rsi
	leaq	129616(%rsp), %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L877
	movl	$25664, %edx
	xorl	%esi, %esi
	movq	%rsp, %rdi
	call	memset@PLT
	leaq	.LC11(%rip), %rax
	movq	%rbx, (%rsp)
	movq	%rax, 25656(%rsp)
	testq	%r12, %r12
	je	.L752
	leaq	.LC204(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L753
	leaq	.LC200(%rip), %rsi
	movq	%r12, %rdi
	movl	$1, 25632(%rsp)
	call	strstr@PLT
	testq	%rax, %rax
	je	.L754
	movl	$1, 25636(%rsp)
.L754:
	testq	%rbp, %rbp
	jle	.L755
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	gen_node_x86.part.0
.L755:
	movq	%rbx, %rdi
	call	fclose@PLT
	movq	%r15, %r8
	movq	%r12, %rcx
	movl	$2048, %esi
	leaq	.LC205(%rip), %rdx
	leaq	130640(%rsp), %rdi
	xorl	%eax, %eax
	call	snprintf@PLT
	leaq	130640(%rsp), %rdi
	call	system@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L875
	movq	%r15, %rdx
	movq	%r12, %rsi
	leaq	.LC207(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L725
	.p2align 4,,10
	.p2align 3
.L726:
	movq	stderr(%rip), %rdi
	movq	%rbx, %rdx
	leaq	.LC172(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.L874:
	movl	$1, %ebx
.L725:
	movq	132696(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L878
	addq	$132712, %rsp
	movl	%ebx, %eax
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.p2align 4,,10
	.p2align 3
.L876:
	movq	stderr(%rip), %rdi
	leaq	.LC6(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L874
	.p2align 4,,10
	.p2align 3
.L752:
	testq	%rbp, %rbp
	jle	.L787
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	gen_node_x86.part.0
.L787:
	movq	%rbx, %rdi
	call	fclose@PLT
	movdqa	.LC236(%rip), %xmm0
	xorl	%edx, %edx
	movabsq	$417391211103, %rax
	leaq	129360(%rsp), %rdi
	movq	%rax, 129376(%rsp)
	movaps	%xmm0, 129360(%rsp)
	pxor	%xmm0, %xmm0
	movq	%rdx, 129384(%rsp)
	movaps	%xmm0, 129392(%rsp)
	movaps	%xmm0, 129408(%rsp)
	movaps	%xmm0, 129424(%rsp)
	movaps	%xmm0, 129440(%rsp)
	movaps	%xmm0, 129456(%rsp)
	movaps	%xmm0, 129472(%rsp)
	movaps	%xmm0, 129488(%rsp)
	movaps	%xmm0, 129504(%rsp)
	movaps	%xmm0, 129520(%rsp)
	movaps	%xmm0, 129536(%rsp)
	movaps	%xmm0, 129552(%rsp)
	movaps	%xmm0, 129568(%rsp)
	movaps	%xmm0, 129584(%rsp)
	movaps	%xmm0, 129600(%rsp)
	call	file_exists@PLT
	testq	%rax, %rax
	je	.L879
.L788:
	movq	%r15, %rcx
	movl	$512, %esi
	xorl	%eax, %eax
	leaq	.LC233(%rip), %rdx
	leaq	130128(%rsp), %rdi
	call	snprintf@PLT
	movl	$8303, %eax
	leaq	130646(%rsp), %rdi
	leaq	130128(%rsp), %rsi
	movl	$757101409, 130640(%rsp)
	movw	%ax, 130644(%rsp)
	call	stpcpy@PLT
	leaq	129616(%rsp), %rsi
	movb	$32, (%rax)
	leaq	1(%rax), %rdi
	call	stpcpy@PLT
	movdqa	.LC240(%rip), %xmm0
	leaq	130128(%rsp), %rsi
	leaq	43(%rax), %rdi
	movups	%xmm0, (%rax)
	movdqa	.LC241(%rip), %xmm0
	movups	%xmm0, 16(%rax)
	movdqa	.LC242(%rip), %xmm0
	movups	%xmm0, 28(%rax)
	call	stpcpy@PLT
	leaq	129360(%rsp), %rsi
	movb	$32, (%rax)
	leaq	1(%rax), %rdi
	call	stpcpy@PLT
	movq	%r15, %rsi
	movl	$544156960, (%rax)
	leaq	4(%rax), %rdi
	call	stpcpy@PLT
	movl	$8294, %edx
	movabsq	$3251719267894568480, %rcx
	leaq	130128(%rsp), %rsi
	movq	%rcx, (%rax)
	leaq	10(%rax), %rdi
	movw	%dx, 8(%rax)
	call	strcpy@PLT
	leaq	130640(%rsp), %rdi
	call	system@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L880
	movq	%r15, %rsi
	leaq	.LC235(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L725
	.p2align 4,,10
	.p2align 3
.L753:
	leaq	.LC208(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L881
.L758:
	movl	$1, 25628(%rsp)
	movq	%rbx, %rdi
	movl	$1, 25636(%rsp)
	call	fclose@PLT
	movq	%r15, %r8
	movq	%r12, %rcx
	movl	$2048, %esi
	leaq	.LC205(%rip), %rdx
	leaq	130640(%rsp), %rdi
	xorl	%eax, %eax
	call	snprintf@PLT
	leaq	130640(%rsp), %rdi
	call	system@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L760
.L875:
	movq	stderr(%rip), %rdi
	movq	%r12, %rdx
	leaq	.LC206(%rip), %rsi
	xorl	%eax, %eax
	movl	$1, %ebx
	call	fprintf@PLT
	jmp	.L725
	.p2align 4,,10
	.p2align 3
.L733:
	leaq	.LC163(%rip), %r12
	jmp	.L729
	.p2align 4,,10
	.p2align 3
.L880:
	movq	stderr(%rip), %rcx
	movl	$34, %edx
	movl	$1, %esi
	leaq	.LC234(%rip), %rdi
	call	fwrite@PLT
	jmp	.L874
	.p2align 4,,10
	.p2align 3
.L760:
	movq	%r15, %rdx
	movq	%r12, %rsi
	leaq	.LC210(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L725
	.p2align 4,,10
	.p2align 3
.L881:
	leaq	.LC197(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	jne	.L758
	leaq	.LC209(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	jne	.L758
	leaq	.LC211(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L882
.L762:
	movl	$1, 25636(%rsp)
	testq	%rbp, %rbp
	jle	.L764
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	gen_node_x86.part.0
.L764:
	movq	%rbx, %rdi
	call	fclose@PLT
	movq	%r15, %r9
	movq	%r12, %rcx
	movl	$2048, %esi
	leaq	129616(%rsp), %r8
	leaq	.LC214(%rip), %rdx
	xorl	%eax, %eax
	leaq	130640(%rsp), %rdi
	call	snprintf@PLT
	leaq	130640(%rsp), %rdi
	call	system@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L875
	movq	%r15, %rdx
	movq	%r12, %rsi
	leaq	.LC215(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L725
	.p2align 4,,10
	.p2align 3
.L879:
	movdqa	.LC237(%rip), %xmm0
	movaps	%xmm0, 129360(%rsp)
	movdqa	.LC238(%rip), %xmm0
	movaps	%xmm0, 129376(%rsp)
	movdqa	.LC239(%rip), %xmm0
	movups	%xmm0, 129389(%rsp)
	jmp	.L788
.L735:
	leaq	.LC164(%rip), %r12
	jmp	.L729
.L882:
	leaq	.LC212(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	jne	.L762
	leaq	.LC213(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	jne	.L762
	leaq	.LC178(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L883
.L767:
	leaq	.LC216(%rip), %rsi
	movq	%r12, %rdi
	movl	$1, 25628(%rsp)
	call	strstr@PLT
	testq	%rax, %rax
	je	.L884
.L769:
	leaq	.LC218(%rip), %rax
	movl	$1, 25644(%rsp)
	movq	%rax, 25656(%rsp)
.L770:
	movq	%rbx, %rdi
	call	fclose@PLT
	movq	%r15, %r8
	movq	%r12, %rcx
	movl	$2048, %esi
	leaq	.LC205(%rip), %rdx
	leaq	130640(%rsp), %rdi
	xorl	%eax, %eax
	call	snprintf@PLT
	leaq	130640(%rsp), %rdi
	call	system@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L875
	movq	%r15, %rdx
	movq	%r12, %rsi
	leaq	.LC219(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L725
.L737:
	leaq	.LC165(%rip), %r12
	jmp	.L729
.L878:
	call	__stack_chk_fail@PLT
.L877:
	movq	stderr(%rip), %rdi
	leaq	129616(%rsp), %rdx
	leaq	.LC203(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	jmp	.L874
.L739:
	leaq	.LC166(%rip), %r12
	jmp	.L729
.L741:
	leaq	.LC167(%rip), %r12
	jmp	.L729
.L884:
	leaq	.LC180(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	jne	.L769
	leaq	.LC217(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	jne	.L769
	jmp	.L770
.L883:
	leaq	.LC177(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	jne	.L767
	leaq	.LC187(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L773
	movq	%rbx, %rdi
	call	fclose@PLT
	movq	%r15, %rcx
	movl	$512, %esi
	xorl	%eax, %eax
	leaq	.LC220(%rip), %rdx
	leaq	130128(%rsp), %rdi
	call	snprintf@PLT
	leaq	.LC202(%rip), %rsi
	leaq	130128(%rsp), %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L774
	leaq	.LC221(%rip), %rdi
	movq	%rax, %rcx
	movl	$104, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movq	%rbx, %rdi
	call	fclose@PLT
.L774:
	movq	%r15, %rcx
	movl	$2048, %esi
	xorl	%eax, %eax
	leaq	.LC222(%rip), %rdx
	leaq	130640(%rsp), %rdi
	call	snprintf@PLT
	leaq	130640(%rsp), %rdi
	call	system@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	je	.L775
	movq	stderr(%rip), %rcx
	movl	$37, %edx
	movl	$1, %esi
	leaq	.LC223(%rip), %rdi
	call	fwrite@PLT
	jmp	.L874
.L773:
	leaq	.LC183(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L885
.L777:
	movl	$1, 25640(%rsp)
	testq	%rbp, %rbp
	jle	.L779
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	gen_node_x86.part.0
.L779:
	movq	%rbx, %rdi
	call	fclose@PLT
	movq	%r15, %r9
	movq	%r12, %rcx
	movl	$2048, %esi
	leaq	129616(%rsp), %r8
	leaq	.LC214(%rip), %rdx
	xorl	%eax, %eax
	leaq	130640(%rsp), %rdi
	call	snprintf@PLT
	leaq	130640(%rsp), %rdi
	call	system@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L875
	movq	%r15, %rdx
	movq	%r12, %rsi
	leaq	.LC226(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L725
.L885:
	leaq	.LC225(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	jne	.L777
	leaq	.LC216(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L886
.L782:
	leaq	.LC218(%rip), %rax
	movl	$1, 25644(%rsp)
	movq	%rax, 25656(%rsp)
	testq	%rbp, %rbp
	jle	.L784
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	gen_node_x86.part.0
.L784:
	movq	%rbx, %rdi
	call	fclose@PLT
	movq	%r15, %r9
	movq	%r12, %rcx
	movl	$2048, %esi
	leaq	129616(%rsp), %r8
	leaq	.LC214(%rip), %rdx
	xorl	%eax, %eax
	leaq	130640(%rsp), %rdi
	call	snprintf@PLT
	leaq	130640(%rsp), %rdi
	call	system@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L875
	movq	%r15, %rdx
	movq	%r12, %rsi
	leaq	.LC227(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L725
.L886:
	leaq	.LC180(%rip), %rsi
	movq	%r12, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	jne	.L782
	leaq	.LC228(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L752
	leaq	.LC162(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L752
	leaq	.LC229(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L752
	leaq	.LC230(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L752
	movq	%rbx, %rdi
	call	fclose@PLT
	leaq	129616(%rsp), %rdi
	call	unlink@PLT
	movq	stderr(%rip), %rdi
	movq	%r13, %rdx
	xorl	%eax, %eax
	leaq	.LC231(%rip), %rsi
	call	fprintf@PLT
	movl	$67, %edx
	movq	stderr(%rip), %rcx
	movl	$1, %esi
	leaq	.LC232(%rip), %rdi
	call	fwrite@PLT
	jmp	.L874
.L775:
	movq	%r15, %rsi
	leaq	.LC224(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L725
.L792:
	leaq	.LC171(%rip), %r12
	jmp	.L729
.L747:
	leaq	.LC170(%rip), %r12
	jmp	.L729
.L745:
	leaq	.LC169(%rip), %r12
	jmp	.L729
.L743:
	leaq	.LC168(%rip), %r12
	jmp	.L729
	.size	compile_file, .-compile_file
	.section	.rodata.str1.1
.LC244:
	.string	"doctor"
.LC245:
	.string	"check"
.LC246:
	.string	"build"
	.section	.rodata.str1.8
	.align 8
.LC247:
	.string	"error: missing required file path for 'build' command\n"
	.section	.rodata.str1.1
.LC248:
	.string	"--target"
.LC249:
	.string	"%s.out"
.LC250:
	.string	"run"
	.section	.rodata.str1.8
	.align 8
.LC251:
	.string	"error: missing required file path for 'run' command\n"
	.section	.rodata.str1.1
.LC252:
	.string	"/tmp/rubix_app_%d"
	.text
	.p2align 4
	.globl	native_backend_rubix_main
	.type	native_backend_rubix_main, @function
native_backend_rubix_main:
	subq	$1112, %rsp
	movq	%fs:40, %rax
	movq	%rax, 1048(%rsp)
	xorl	%eax, %eax
	call	get_arg_count@PLT
	testq	%rax, %rax
	je	.L928
	xorl	%edi, %edi
	movq	%rbx, 1064(%rsp)
	movq	%rax, %rbx
	movq	%rbp, 1072(%rsp)
	call	get_arg@PLT
	leaq	.LC244(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbp
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L929
	leaq	.LC245(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L892
	cmpq	$1, %rbx
	jle	.L895
	movl	$1, %edi
	call	get_arg@PLT
	testq	%rax, %rax
	je	.L895
	cmpb	$0, (%rax)
	je	.L895
	movq	%rax, %rdi
	call	cmd_check_native.part.0
	movl	%eax, %eax
	.p2align 4
	.p2align 3
.L887:
	movq	1048(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L927
	movq	1064(%rsp), %rbx
	movq	1072(%rsp), %rbp
	addq	$1112, %rsp
	ret
	.p2align 4,,10
	.p2align 3
.L892:
	leaq	.LC246(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L897
	cmpq	$1, %rbx
	jle	.L930
	movq	%r12, 1080(%rsp)
	movl	$1, %ebp
	movq	%r14, 1096(%rsp)
	movb	$0, out_bin.0(%rip)
	movq	$0, 8(%rsp)
	movq	%r13, 1088(%rsp)
	movl	$1, %r13d
	movq	%r15, 1104(%rsp)
	xorl	%r15d, %r15d
	.p2align 4
	.p2align 3
.L905:
	movq	%r13, %rdi
	call	get_arg@PLT
	movq	%rax, %r12
	movzbl	(%rax), %eax
	subl	$45, %eax
	jne	.L899
	movzbl	1(%r12), %eax
	subl	$111, %eax
	jne	.L899
	movzbl	2(%r12), %eax
.L899:
	leal	1(%rbp), %r14d
	movslq	%r14d, %r13
	testl	%eax, %eax
	jne	.L900
	cmpq	%r13, %rbx
	jg	.L931
	leaq	.LC248(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L903
.L904:
	cmpb	$45, (%r12)
	jne	.L906
.L914:
	testq	%r15, %r15
	jne	.L917
	movq	stderr(%rip), %rcx
	movl	$54, %edx
	movl	$1, %esi
	leaq	.LC247(%rip), %rdi
	call	fwrite@PLT
	movq	1080(%rsp), %r12
	movq	1088(%rsp), %r13
	movq	1096(%rsp), %r14
	movq	1104(%rsp), %r15
	jmp	.L910
	.p2align 4,,10
	.p2align 3
.L928:
	movq	1048(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L932
.L926:
	addq	$1112, %rsp
	jmp	rubix_main@PLT
	.p2align 4,,10
	.p2align 3
.L897:
	leaq	.LC250(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L908
	cmpq	$1, %rbx
	jle	.L933
	movl	$1, %edi
	call	get_arg@PLT
	movq	%rax, %rbx
	call	getpid@PLT
	movl	$512, %esi
	leaq	16(%rsp), %rdi
	leaq	.LC252(%rip), %rdx
	movl	%eax, %ecx
	xorl	%eax, %eax
	call	snprintf@PLT
	leaq	.LC229(%rip), %rdx
	leaq	16(%rsp), %rsi
	movq	%rbx, %rdi
	call	compile_file
	testl	%eax, %eax
	jne	.L910
	leaq	16(%rsp), %rdi
	call	system@PLT
	leaq	16(%rsp), %rdi
	movl	%eax, %ebx
	call	unlink@PLT
	leaq	16(%rsp), %rcx
	xorl	%eax, %eax
	leaq	.LC201(%rip), %rdx
	movl	$512, %esi
	leaq	528(%rsp), %rdi
	call	snprintf@PLT
	leaq	528(%rsp), %rdi
	call	unlink@PLT
	movzbl	%bh, %eax
	andl	$127, %ebx
	je	.L887
	jmp	.L910
	.p2align 4,,10
	.p2align 3
.L895:
	movq	stderr(%rip), %rcx
	movl	$54, %edx
	movl	$1, %esi
	leaq	.LC141(%rip), %rdi
	call	fwrite@PLT
.L910:
	movl	$1, %eax
	jmp	.L887
	.p2align 4,,10
	.p2align 3
.L900:
	leaq	.LC248(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L903
	cmpq	%r13, %rbx
	jle	.L904
	movq	%r13, %rdi
	addl	$2, %ebp
	call	get_arg@PLT
	movslq	%ebp, %r13
	movq	%rax, 8(%rsp)
	.p2align 4
	.p2align 3
.L902:
	cmpq	%r13, %rbx
	jg	.L905
	jmp	.L914
	.p2align 4,,10
	.p2align 3
.L903:
	cmpb	$45, (%r12)
	movl	%r14d, %ebp
	cmovne	%r12, %r15
	jmp	.L902
	.p2align 4,,10
	.p2align 3
.L931:
	movq	%r13, %rdi
	addl	$2, %ebp
	call	get_arg@PLT
	movl	$511, %edx
	leaq	out_bin.0(%rip), %rdi
	movslq	%ebp, %r13
	movq	%rax, %rsi
	call	strncpy@PLT
	jmp	.L902
	.p2align 4,,10
	.p2align 3
.L929:
	call	cmd_doctor_native
	xorl	%eax, %eax
	jmp	.L887
.L917:
	movq	%r15, %r12
	.p2align 4
	.p2align 3
.L906:
	cmpb	$0, out_bin.0(%rip)
	je	.L934
.L907:
	movq	8(%rsp), %rdx
	movq	%r12, %rdi
	leaq	out_bin.0(%rip), %rsi
	call	compile_file
	movq	1080(%rsp), %r12
	movq	1088(%rsp), %r13
	movq	1096(%rsp), %r14
	movq	1104(%rsp), %r15
	movl	%eax, %eax
	jmp	.L887
	.p2align 4,,10
	.p2align 3
.L934:
	movq	%r12, %rcx
	leaq	.LC249(%rip), %rdx
	movl	$512, %esi
	xorl	%eax, %eax
	leaq	out_bin.0(%rip), %rdi
	call	snprintf@PLT
	jmp	.L907
	.p2align 4,,10
	.p2align 3
.L933:
	movq	stderr(%rip), %rcx
	movl	$52, %edx
	movl	$1, %esi
	leaq	.LC251(%rip), %rdi
	call	fwrite@PLT
	jmp	.L910
	.p2align 4,,10
	.p2align 3
.L908:
	movq	1048(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L927
	movq	1064(%rsp), %rbx
	movq	1072(%rsp), %rbp
	jmp	.L926
	.p2align 4,,10
	.p2align 3
.L930:
	movq	stderr(%rip), %rcx
	movl	$54, %edx
	movl	$1, %esi
	leaq	.LC247(%rip), %rdi
	call	fwrite@PLT
	jmp	.L910
.L932:
	movq	%rbx, 1064(%rsp)
	movq	%rbp, 1072(%rsp)
.L927:
	movq	%r12, 1080(%rsp)
	movq	%r13, 1088(%rsp)
	movq	%r14, 1096(%rsp)
	movq	%r15, 1104(%rsp)
	call	__stack_chk_fail@PLT
	.size	native_backend_rubix_main, .-native_backend_rubix_main
	.local	out_bin.0
	.comm	out_bin.0,512,32
	.section	.rodata.str1.1
.LC253:
	.string	"%r12"
.LC254:
	.string	"%r13"
.LC255:
	.string	"%r14"
.LC256:
	.string	"%r15"
.LC257:
	.string	"%rbx"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	reg_names, @object
	.size	reg_names, 40
reg_names:
	.quad	.LC253
	.quad	.LC254
	.quad	.LC255
	.quad	.LC256
	.quad	.LC257
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC236:
	.quad	3415256192122778994
	.quad	8676574413675719020
	.align 16
.LC237:
	.quad	7593684034374297647
	.quad	3421180424879564915
	.align 16
.LC238:
	.quad	8227927438247948846
	.quad	7795561000596696693
	.align 16
.LC239:
	.quad	7094702554993143653
	.quad	27354150410877033
	.align 16
.LC240:
	.quad	2333818326480201248
	.quad	7162743404398139181
	.align 16
.LC241:
	.quad	7957695015191671597
	.quad	7597622527987097715
	.align 16
.LC242:
	.quad	7362576585753374063
	.quad	9129745076547438
.LC_tco_name_str:
	.string	"tail_call"
	.ident	"GCC: (GNU) 16.2.1 20260810"

	.section	.note.GNU-stack,"",@progbits
