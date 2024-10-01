	.file	"preflow.c"
# GNU C17 (GCC) version 14.2.1 20240910 (x86_64-pc-linux-gnu)
#	compiled by GNU C version 14.2.1 20240910, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64
	.text
	.local	progname
	.comm	progname,8,8
	.section	.rodata
.LC0:
	.string	"%s: "
.LC1:
	.string	"error: %s\n"
	.text
	.globl	error
	.type	error, @function
error:
.LFB6:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$8432, %rsp	#,
	movq	%rdi, -8424(%rbp)	# fmt, fmt
	movq	%rsi, -168(%rbp)	#,
	movq	%rdx, -160(%rbp)	#,
	movq	%rcx, -152(%rbp)	#,
	movq	%r8, -144(%rbp)	#,
	movq	%r9, -136(%rbp)	#,
	testb	%al, %al	#
	je	.L2	#,
	movaps	%xmm0, -128(%rbp)	#,
	movaps	%xmm1, -112(%rbp)	#,
	movaps	%xmm2, -96(%rbp)	#,
	movaps	%xmm3, -80(%rbp)	#,
	movaps	%xmm4, -64(%rbp)	#,
	movaps	%xmm5, -48(%rbp)	#,
	movaps	%xmm6, -32(%rbp)	#,
	movaps	%xmm7, -16(%rbp)	#,
.L2:
# preflow.c:153: {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp102
	movq	%rax, -184(%rbp)	# tmp102, D.4376
	xorl	%eax, %eax	# tmp102
# preflow.c:184: 	va_start(ap, fmt);
	movl	$8, -8408(%rbp)	#, MEM[(struct [1] *)&ap].gp_offset
	movl	$48, -8404(%rbp)	#, MEM[(struct [1] *)&ap].fp_offset
	leaq	16(%rbp), %rax	#, tmp111
	movq	%rax, -8400(%rbp)	# tmp111, MEM[(struct [1] *)&ap].overflow_arg_area
	leaq	-176(%rbp), %rax	#, tmp112
	movq	%rax, -8392(%rbp)	# tmp112, MEM[(struct [1] *)&ap].reg_save_area
# preflow.c:185: 	vsprintf(buf, fmt, ap);
	leaq	-8408(%rbp), %rdx	#, tmp104
	movq	-8424(%rbp), %rcx	# fmt, tmp105
	leaq	-8384(%rbp), %rax	#, tmp106
	movq	%rcx, %rsi	# tmp105,
	movq	%rax, %rdi	# tmp106,
	call	vsprintf@PLT	#
# preflow.c:187: 	if (progname != NULL)
	movq	progname(%rip), %rax	# progname, progname.0_1
# preflow.c:187: 	if (progname != NULL)
	testq	%rax, %rax	# progname.0_1
	je	.L3	#,
# preflow.c:188: 		fprintf(stderr, "%s: ", progname);
	movq	progname(%rip), %rdx	# progname, progname.1_2
	movq	stderr(%rip), %rax	# stderr, stderr.2_3
	leaq	.LC0(%rip), %rcx	#, tmp107
	movq	%rcx, %rsi	# tmp107,
	movq	%rax, %rdi	# stderr.2_3,
	movl	$0, %eax	#,
	call	fprintf@PLT	#
.L3:
# preflow.c:190: 	fprintf(stderr, "error: %s\n", buf);
	movq	stderr(%rip), %rax	# stderr, stderr.3_4
	leaq	-8384(%rbp), %rdx	#, tmp108
	leaq	.LC1(%rip), %rcx	#, tmp109
	movq	%rcx, %rsi	# tmp109,
	movq	%rax, %rdi	# stderr.3_4,
	movl	$0, %eax	#,
	call	fprintf@PLT	#
# preflow.c:191: 	exit(1);
	movl	$1, %edi	#,
	call	exit@PLT	#
	.cfi_endproc
.LFE6:
	.size	error, .-error
	.type	next_int, @function
next_int:
.LFB7:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%rbx	#
	subq	$24, %rsp	#,
	.cfi_offset 3, -24
# preflow.c:213: 	x = 0;
	movl	$0, -24(%rbp)	#, x
# preflow.c:214:         while (isdigit(c = getchar()))
	jmp	.L6	#
.L7:
# preflow.c:215:                 x = 10 * x + c - '0';
	movl	-24(%rbp), %edx	# x, tmp110
	movl	%edx, %eax	# tmp110, _1
	sall	$2, %eax	#, _1
	addl	%edx, %eax	# tmp110, _1
	addl	%eax, %eax	# tmp112
	movl	%eax, %edx	# _1, _1
# preflow.c:215:                 x = 10 * x + c - '0';
	movl	-20(%rbp), %eax	# c, tmp113
	addl	%edx, %eax	# _1, _2
# preflow.c:215:                 x = 10 * x + c - '0';
	subl	$48, %eax	#, tmp114
	movl	%eax, -24(%rbp)	# tmp114, x
.L6:
# preflow.c:214:         while (isdigit(c = getchar()))
	call	__ctype_b_loc@PLT	#
# preflow.c:214:         while (isdigit(c = getchar()))
	movq	(%rax), %rbx	# *_3, _4
	call	getchar@PLT	#
	movl	%eax, -20(%rbp)	# tmp115, c
# preflow.c:214:         while (isdigit(c = getchar()))
	movl	-20(%rbp), %eax	# c, tmp116
	cltq
	addq	%rax, %rax	# _6
	addq	%rbx, %rax	# _4, _7
	movzwl	(%rax), %eax	# *_7, _8
	movzwl	%ax, %eax	# _8, _9
	andl	$2048, %eax	#, _10
	testl	%eax, %eax	# _10
	jne	.L7	#,
# preflow.c:217:         return x;
	movl	-24(%rbp), %eax	# x, _17
# preflow.c:218: }
	movq	-8(%rbp), %rbx	#,
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE7:
	.size	next_int, .-next_int
	.section	.rodata
	.align 8
.LC2:
	.string	"out of memory: malloc(%zu) failed"
	.text
	.type	xmalloc, @function
xmalloc:
.LFB8:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
	movq	%rdi, -24(%rbp)	# s, s
# preflow.c:237: 	p = malloc(s);
	movq	-24(%rbp), %rax	# s, tmp100
	movq	%rax, %rdi	# tmp100,
	call	malloc@PLT	#
	movq	%rax, -8(%rbp)	# tmp101, p
# preflow.c:239: 	if (p == NULL)
	cmpq	$0, -8(%rbp)	#, p
	jne	.L10	#,
# preflow.c:240: 		error("out of memory: malloc(%zu) failed", s);
	movq	-24(%rbp), %rax	# s, tmp102
	movq	%rax, %rsi	# tmp102,
	leaq	.LC2(%rip), %rax	#, tmp103
	movq	%rax, %rdi	# tmp103,
	movl	$0, %eax	#,
	call	error	#
.L10:
# preflow.c:242: 	return p;
	movq	-8(%rbp), %rax	# p, _7
# preflow.c:243: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE8:
	.size	xmalloc, .-xmalloc
	.type	xcalloc, @function
xcalloc:
.LFB9:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
	movq	%rdi, -24(%rbp)	# n, n
	movq	%rsi, -32(%rbp)	# s, s
# preflow.c:249: 	p = xmalloc(n * s);
	movq	-24(%rbp), %rax	# n, tmp102
	imulq	-32(%rbp), %rax	# s, _1
	movq	%rax, %rdi	# _1,
	call	xmalloc	#
	movq	%rax, -8(%rbp)	# tmp103, p
# preflow.c:252: 	memset(p, 0, n * s);
	movq	-24(%rbp), %rax	# n, tmp104
	imulq	-32(%rbp), %rax	# s, tmp104
	movq	%rax, %rdx	# tmp104, _2
	movq	-8(%rbp), %rax	# p, tmp105
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp105,
	call	memset@PLT	#
# preflow.c:266: 	return p;
	movq	-8(%rbp), %rax	# p, _9
# preflow.c:267: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE9:
	.size	xcalloc, .-xcalloc
	.type	add_edge, @function
add_edge:
.LFB10:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
	movq	%rdi, -24(%rbp)	# u, u
	movq	%rsi, -32(%rbp)	# e, e
# preflow.c:278: 	p = xmalloc(sizeof(list_t));
	movl	$16, %edi	#,
	call	xmalloc	#
	movq	%rax, -8(%rbp)	# tmp99, p
# preflow.c:279: 	p->edge = e;
	movq	-8(%rbp), %rax	# p, tmp100
	movq	-32(%rbp), %rdx	# e, tmp101
	movq	%rdx, (%rax)	# tmp101, p_4->edge
# preflow.c:280: 	p->next = u->edge;
	movq	-24(%rbp), %rax	# u, tmp102
	movq	8(%rax), %rdx	# u_7(D)->edge, _1
# preflow.c:280: 	p->next = u->edge;
	movq	-8(%rbp), %rax	# p, tmp103
	movq	%rdx, 8(%rax)	# _1, p_4->next
# preflow.c:281: 	u->edge = p;
	movq	-24(%rbp), %rax	# u, tmp104
	movq	-8(%rbp), %rdx	# p, tmp105
	movq	%rdx, 8(%rax)	# tmp105, u_7(D)->edge
# preflow.c:282: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE10:
	.size	add_edge, .-add_edge
	.type	connect, @function
connect:
.LFB11:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$48, %rsp	#,
	movq	%rdi, -24(%rbp)	# u, u
	movq	%rsi, -32(%rbp)	# v, v
	movl	%edx, -36(%rbp)	# c, c
	movq	%rcx, -48(%rbp)	# e, e
# preflow.c:285: {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp101
	movq	%rax, -8(%rbp)	# tmp101, D.4383
	xorl	%eax, %eax	# tmp101
# preflow.c:291: 	e->u = u;
	movq	-48(%rbp), %rax	# e, tmp102
	movq	-24(%rbp), %rdx	# u, tmp103
	movq	%rdx, (%rax)	# tmp103, e_5(D)->u
# preflow.c:292: 	e->v = v;
	movq	-48(%rbp), %rax	# e, tmp104
	movq	-32(%rbp), %rdx	# v, tmp105
	movq	%rdx, 8(%rax)	# tmp105, e_5(D)->v
# preflow.c:293: 	e->c = c;
	movl	-36(%rbp), %eax	# c, tmp106
	movl	%eax, -12(%rbp)	# tmp106, D.4178
	movl	-12(%rbp), %eax	# D.4178, _1
	movl	%eax, %edx	# _1, _2
	movq	-48(%rbp), %rax	# e, tmp107
	addq	$20, %rax	#, _3
	xchgl	(%rax), %edx	#,* _3, tmp108
# preflow.c:295: 	add_edge(u, e);
	movq	-48(%rbp), %rdx	# e, tmp109
	movq	-24(%rbp), %rax	# u, tmp110
	movq	%rdx, %rsi	# tmp109,
	movq	%rax, %rdi	# tmp110,
	call	add_edge	#
# preflow.c:296: 	add_edge(v, e);
	movq	-48(%rbp), %rdx	# e, tmp111
	movq	-32(%rbp), %rax	# v, tmp112
	movq	%rdx, %rsi	# tmp111,
	movq	%rax, %rdi	# tmp112,
	call	add_edge	#
# preflow.c:297: }
	nop	
	movq	-8(%rbp), %rax	# D.4383, tmp113
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp113
	je	.L16	#,
	call	__stack_chk_fail@PLT	#
.L16:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE11:
	.size	connect, .-connect
	.type	new_graph, @function
new_graph:
.LFB12:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$64, %rsp	#,
	movq	%rdi, -56(%rbp)	# in, in
	movl	%esi, -60(%rbp)	# n, n
	movl	%edx, -64(%rbp)	# m, m
# preflow.c:309: 	g = xmalloc(sizeof(graph_t));
	movl	$48, %edi	#,
	call	xmalloc	#
	movq	%rax, -24(%rbp)	# tmp120, g
# preflow.c:311: 	g->n = n;
	movq	-24(%rbp), %rax	# g, tmp121
	movl	-60(%rbp), %edx	# n, tmp122
	movl	%edx, (%rax)	# tmp122, g_25->n
# preflow.c:312: 	g->m = m;
	movq	-24(%rbp), %rax	# g, tmp123
	movl	-64(%rbp), %edx	# m, tmp124
	movl	%edx, 4(%rax)	# tmp124, g_25->m
# preflow.c:314: 	g->v = xcalloc(n, sizeof(node_t));
	movl	-60(%rbp), %eax	# n, tmp125
	cltq
	movl	$24, %esi	#,
	movq	%rax, %rdi	# _1,
	call	xcalloc	#
# preflow.c:314: 	g->v = xcalloc(n, sizeof(node_t));
	movq	-24(%rbp), %rdx	# g, tmp126
	movq	%rax, 8(%rdx)	# _2, g_25->v
# preflow.c:315: 	g->e = xcalloc(m, sizeof(edge_t));
	movl	-64(%rbp), %eax	# m, tmp127
	cltq
	movl	$24, %esi	#,
	movq	%rax, %rdi	# _3,
	call	xcalloc	#
# preflow.c:315: 	g->e = xcalloc(m, sizeof(edge_t));
	movq	-24(%rbp), %rdx	# g, tmp128
	movq	%rax, 16(%rdx)	# _4, g_25->e
# preflow.c:317: 	g->s = &g->v[0];
	movq	-24(%rbp), %rax	# g, tmp129
	movq	8(%rax), %rdx	# g_25->v, _5
# preflow.c:317: 	g->s = &g->v[0];
	movq	-24(%rbp), %rax	# g, tmp130
	movq	%rdx, 24(%rax)	# _5, g_25->s
# preflow.c:318: 	g->t = &g->v[n-1];
	movq	-24(%rbp), %rax	# g, tmp131
	movq	8(%rax), %rcx	# g_25->v, _6
# preflow.c:318: 	g->t = &g->v[n-1];
	movl	-60(%rbp), %eax	# n, tmp132
	movslq	%eax, %rdx	# tmp132, _7
	movq	%rdx, %rax	# _7, _8
	addq	%rax, %rax	# _8
	addq	%rdx, %rax	# _7, _8
	salq	$3, %rax	#, tmp134
	subq	$24, %rax	#, _9
# preflow.c:318: 	g->t = &g->v[n-1];
	leaq	(%rcx,%rax), %rdx	#, _10
# preflow.c:318: 	g->t = &g->v[n-1];
	movq	-24(%rbp), %rax	# g, tmp135
	movq	%rdx, 32(%rax)	# _10, g_25->t
# preflow.c:319: 	g->excess = NULL;
	movq	-24(%rbp), %rax	# g, tmp136
	movq	$0, 40(%rax)	#, g_25->excess
# preflow.c:321: 	for (i = 0; i < m; i += 1) {
	movl	$0, -40(%rbp)	#, i
# preflow.c:321: 	for (i = 0; i < m; i += 1) {
	jmp	.L18	#
.L19:
# preflow.c:322: 		a = next_int();
	movl	$0, %eax	#,
	call	next_int	#
	movl	%eax, -36(%rbp)	# tmp137, a
# preflow.c:323: 		b = next_int();
	movl	$0, %eax	#,
	call	next_int	#
	movl	%eax, -32(%rbp)	# tmp138, b
# preflow.c:324: 		c = next_int();
	movl	$0, %eax	#,
	call	next_int	#
	movl	%eax, -28(%rbp)	# tmp139, c
# preflow.c:325: 		u = &g->v[a];
	movq	-24(%rbp), %rax	# g, tmp140
	movq	8(%rax), %rcx	# g_25->v, _11
# preflow.c:325: 		u = &g->v[a];
	movl	-36(%rbp), %eax	# a, tmp141
	movslq	%eax, %rdx	# tmp141, _12
	movq	%rdx, %rax	# _12, _13
	addq	%rax, %rax	# _13
	addq	%rdx, %rax	# _12, _13
	salq	$3, %rax	#, tmp143
# preflow.c:325: 		u = &g->v[a];
	addq	%rcx, %rax	# _11, tmp144
	movq	%rax, -16(%rbp)	# tmp144, u
# preflow.c:326: 		v = &g->v[b];
	movq	-24(%rbp), %rax	# g, tmp145
	movq	8(%rax), %rcx	# g_25->v, _14
# preflow.c:326: 		v = &g->v[b];
	movl	-32(%rbp), %eax	# b, tmp146
	movslq	%eax, %rdx	# tmp146, _15
	movq	%rdx, %rax	# _15, _16
	addq	%rax, %rax	# _16
	addq	%rdx, %rax	# _15, _16
	salq	$3, %rax	#, tmp148
# preflow.c:326: 		v = &g->v[b];
	addq	%rcx, %rax	# _14, tmp149
	movq	%rax, -8(%rbp)	# tmp149, v
# preflow.c:327: 		connect(u, v, c, g->e+i);
	movq	-24(%rbp), %rax	# g, tmp150
	movq	16(%rax), %rcx	# g_25->e, _17
# preflow.c:327: 		connect(u, v, c, g->e+i);
	movl	-40(%rbp), %eax	# i, tmp151
	movslq	%eax, %rdx	# tmp151, _18
	movq	%rdx, %rax	# _18, _19
	addq	%rax, %rax	# _19
	addq	%rdx, %rax	# _18, _19
	salq	$3, %rax	#, tmp153
# preflow.c:327: 		connect(u, v, c, g->e+i);
	addq	%rax, %rcx	# _19, _20
	movl	-28(%rbp), %edx	# c, tmp154
	movq	-8(%rbp), %rsi	# v, tmp155
	movq	-16(%rbp), %rax	# u, tmp156
	movq	%rax, %rdi	# tmp156,
	call	connect	#
# preflow.c:321: 	for (i = 0; i < m; i += 1) {
	addl	$1, -40(%rbp)	#, i
.L18:
# preflow.c:321: 	for (i = 0; i < m; i += 1) {
	movl	-40(%rbp), %eax	# i, tmp157
	cmpl	-64(%rbp), %eax	# m, tmp157
	jl	.L19	#,
# preflow.c:330: 	return g;
	movq	-24(%rbp), %rax	# g, _38
# preflow.c:331: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE12:
	.size	new_graph, .-new_graph
	.type	enter_excess, @function
enter_excess:
.LFB13:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)	# g, g
	movq	%rsi, -16(%rbp)	# v, v
# preflow.c:344: 	if (v != g->t && v != g->s) {
	movq	-8(%rbp), %rax	# g, tmp101
	movq	32(%rax), %rax	# g_6(D)->t, _1
# preflow.c:344: 	if (v != g->t && v != g->s) {
	cmpq	%rax, -16(%rbp)	# _1, v
	je	.L23	#,
# preflow.c:344: 	if (v != g->t && v != g->s) {
	movq	-8(%rbp), %rax	# g, tmp102
	movq	24(%rax), %rax	# g_6(D)->s, _2
# preflow.c:344: 	if (v != g->t && v != g->s) {
	cmpq	%rax, -16(%rbp)	# _2, v
	je	.L23	#,
# preflow.c:345: 		v->next = g->excess;
	movq	-8(%rbp), %rax	# g, tmp103
	movq	40(%rax), %rdx	# g_6(D)->excess, _3
# preflow.c:345: 		v->next = g->excess;
	movq	-16(%rbp), %rax	# v, tmp104
	movq	%rdx, 16(%rax)	# _3, v_7(D)->next
# preflow.c:346: 		g->excess = v;
	movq	-8(%rbp), %rax	# g, tmp105
	movq	-16(%rbp), %rdx	# v, tmp106
	movq	%rdx, 40(%rax)	# tmp106, g_6(D)->excess
.L23:
# preflow.c:348: }
	nop	
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE13:
	.size	enter_excess, .-enter_excess
	.type	leave_excess, @function
leave_excess:
.LFB14:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)	# g, g
# preflow.c:359: 	v = g->excess;
	movq	-24(%rbp), %rax	# g, tmp101
	movq	40(%rax), %rax	# g_4(D)->excess, tmp102
	movq	%rax, -8(%rbp)	# tmp102, v
# preflow.c:361: 	if (v != NULL)
	cmpq	$0, -8(%rbp)	#, v
	je	.L25	#,
# preflow.c:362: 		g->excess = v->next;
	movq	-8(%rbp), %rax	# v, tmp103
	movq	16(%rax), %rdx	# v_5->next, _1
# preflow.c:362: 		g->excess = v->next;
	movq	-24(%rbp), %rax	# g, tmp104
	movq	%rdx, 40(%rax)	# _1, g_4(D)->excess
.L25:
# preflow.c:364: 	return v;
	movq	-8(%rbp), %rax	# v, _7
# preflow.c:365: }
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE14:
	.size	leave_excess, .-leave_excess
	.section	.rodata
.LC3:
	.string	"preflow.c"
.LC4:
	.string	"d >= 0"
.LC5:
	.string	"u->e >= 0"
.LC6:
	.string	"abs(e->f) <= e->c"
	.text
	.type	push, @function
push:
.LFB15:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$144, %rsp	#,
	movq	%rdi, -120(%rbp)	# g, g
	movq	%rsi, -128(%rbp)	# u, u
	movq	%rdx, -136(%rbp)	# v, v
	movq	%rcx, -144(%rbp)	# e, e
# preflow.c:368: {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp190
	movq	%rax, -8(%rbp)	# tmp190, D.4384
	xorl	%eax, %eax	# tmp190
# preflow.c:374: 	if (u == e->u) {
	movq	-144(%rbp), %rax	# e, tmp191
	movq	(%rax), %rax	# e_100(D)->u, _1
# preflow.c:374: 	if (u == e->u) {
	cmpq	%rax, -128(%rbp)	# _1, u
	jne	.L28	#,
# preflow.c:375: 		d = MIN(u->e, e->c - e->f);
	movq	-128(%rbp), %rax	# u, tmp192
	addq	$4, %rax	#, _2
	movl	(%rax), %eax	#* _2, _3
# preflow.c:375: 		d = MIN(u->e, e->c - e->f);
	movl	%eax, -104(%rbp)	# _4, D.4212
	movl	-104(%rbp), %ecx	# D.4212, _5
	movq	-144(%rbp), %rax	# e, tmp193
	addq	$20, %rax	#, _6
	movl	(%rax), %eax	#* _6, _7
# preflow.c:375: 		d = MIN(u->e, e->c - e->f);
	movl	%eax, -112(%rbp)	# _8, D.4210
	movl	-112(%rbp), %edx	# D.4210, _9
	movq	-144(%rbp), %rax	# e, tmp194
	addq	$16, %rax	#, _10
	movl	(%rax), %eax	#* _10, _11
# preflow.c:375: 		d = MIN(u->e, e->c - e->f);
	movl	%eax, -108(%rbp)	# _12, D.4211
	movl	-108(%rbp), %eax	# D.4211, _13
	subl	%eax, %edx	# _13, _14
	cmpl	%edx, %ecx	# _14, _5
	jg	.L29	#,
# preflow.c:375: 		d = MIN(u->e, e->c - e->f);
	movq	-128(%rbp), %rax	# u, tmp195
	addq	$4, %rax	#, _15
	movl	(%rax), %eax	#* _15, _16
	movl	%eax, -100(%rbp)	# _17, D.4213
	movl	-100(%rbp), %eax	# D.4213, iftmp.4_92
	jmp	.L30	#
.L29:
# preflow.c:375: 		d = MIN(u->e, e->c - e->f);
	movq	-144(%rbp), %rax	# e, tmp196
	addq	$20, %rax	#, _18
	movl	(%rax), %eax	#* _18, _19
# preflow.c:375: 		d = MIN(u->e, e->c - e->f);
	movl	%eax, -96(%rbp)	# _20, D.4214
	movl	-96(%rbp), %eax	# D.4214, _21
	movq	-144(%rbp), %rdx	# e, tmp197
	addq	$16, %rdx	#, _22
	movl	(%rdx), %edx	#* _22, _23
# preflow.c:375: 		d = MIN(u->e, e->c - e->f);
	movl	%edx, -92(%rbp)	# _24, D.4215
	movl	-92(%rbp), %edx	# D.4215, _25
	subl	%edx, %eax	# _25, iftmp.4_92
.L30:
# preflow.c:375: 		d = MIN(u->e, e->c - e->f);
	movl	%eax, -12(%rbp)	# iftmp.4_92, d
# preflow.c:376: 		e->f += d;
	movl	-12(%rbp), %eax	# d, tmp198
	movl	%eax, -88(%rbp)	# tmp198, D.4216
	movl	-88(%rbp), %eax	# D.4216, _26
	movl	%eax, %ecx	# _26, _27
	movq	-144(%rbp), %rax	# e, tmp199
	leaq	16(%rax), %rdx	#, _28
	movl	%ecx, %eax	# _27, _29
	lock xaddl	%eax, (%rdx)	#, _29,* _28
	addl	%ecx, %eax	# _27, _29
# preflow.c:376: 		e->f += d;
	movl	%eax, -84(%rbp)	# _30, D.4217
	jmp	.L31	#
.L28:
# preflow.c:378: 		d = MIN(u->e, e->c + e->f);
	movq	-128(%rbp), %rax	# u, tmp200
	addq	$4, %rax	#, _31
	movl	(%rax), %eax	#* _31, _32
# preflow.c:378: 		d = MIN(u->e, e->c + e->f);
	movl	%eax, -72(%rbp)	# _33, D.4220
	movl	-72(%rbp), %edx	# D.4220, _34
	movq	-144(%rbp), %rax	# e, tmp201
	addq	$20, %rax	#, _35
	movl	(%rax), %eax	#* _35, _36
# preflow.c:378: 		d = MIN(u->e, e->c + e->f);
	movl	%eax, -80(%rbp)	# _37, D.4218
	movl	-80(%rbp), %ecx	# D.4218, _38
	movq	-144(%rbp), %rax	# e, tmp202
	addq	$16, %rax	#, _39
	movl	(%rax), %eax	#* _39, _40
# preflow.c:378: 		d = MIN(u->e, e->c + e->f);
	movl	%eax, -76(%rbp)	# _41, D.4219
	movl	-76(%rbp), %eax	# D.4219, _42
	addl	%ecx, %eax	# _38, _43
	cmpl	%eax, %edx	# _43, _34
	jg	.L32	#,
# preflow.c:378: 		d = MIN(u->e, e->c + e->f);
	movq	-128(%rbp), %rax	# u, tmp203
	addq	$4, %rax	#, _44
	movl	(%rax), %eax	#* _44, _45
	movl	%eax, -68(%rbp)	# _46, D.4221
	movl	-68(%rbp), %eax	# D.4221, iftmp.5_93
	jmp	.L33	#
.L32:
# preflow.c:378: 		d = MIN(u->e, e->c + e->f);
	movq	-144(%rbp), %rax	# e, tmp204
	addq	$20, %rax	#, _47
	movl	(%rax), %eax	#* _47, _48
# preflow.c:378: 		d = MIN(u->e, e->c + e->f);
	movl	%eax, -64(%rbp)	# _49, D.4222
	movl	-64(%rbp), %edx	# D.4222, _50
	movq	-144(%rbp), %rax	# e, tmp205
	addq	$16, %rax	#, _51
	movl	(%rax), %eax	#* _51, _52
# preflow.c:378: 		d = MIN(u->e, e->c + e->f);
	movl	%eax, -60(%rbp)	# _53, D.4223
	movl	-60(%rbp), %eax	# D.4223, _54
	addl	%edx, %eax	# _50, iftmp.5_93
.L33:
# preflow.c:378: 		d = MIN(u->e, e->c + e->f);
	movl	%eax, -12(%rbp)	# iftmp.5_93, d
# preflow.c:379: 		e->f -= d;
	movl	-12(%rbp), %eax	# d, tmp206
	movl	%eax, -56(%rbp)	# tmp206, D.4224
	movl	-56(%rbp), %eax	# D.4224, _55
	movl	%eax, %ecx	# _55, _56
	movq	-144(%rbp), %rax	# e, tmp207
	leaq	16(%rax), %rdx	#, _57
	negl	%ecx	# tmp208
	movl	%ecx, %eax	# tmp208, _58
	lock xaddl	%eax, (%rdx)	#, _58,* _57
	addl	%ecx, %eax	# tmp208, _58
# preflow.c:379: 		e->f -= d;
	movl	%eax, -52(%rbp)	# _59, D.4225
.L31:
# preflow.c:384: 	u->e -= d;
	movl	-12(%rbp), %eax	# d, tmp209
	movl	%eax, -48(%rbp)	# tmp209, D.4226
	movl	-48(%rbp), %eax	# D.4226, _60
	movl	%eax, %ecx	# _60, _61
	movq	-128(%rbp), %rax	# u, tmp210
	leaq	4(%rax), %rdx	#, _62
	negl	%ecx	# tmp211
	movl	%ecx, %eax	# tmp211, _63
	lock xaddl	%eax, (%rdx)	#, _63,* _62
	addl	%ecx, %eax	# tmp211, _63
# preflow.c:384: 	u->e -= d;
	movl	%eax, -44(%rbp)	# _64, D.4227
# preflow.c:385: 	v->e += d;
	movl	-12(%rbp), %eax	# d, tmp212
	movl	%eax, -40(%rbp)	# tmp212, D.4228
	movl	-40(%rbp), %eax	# D.4228, _65
	movl	%eax, %ecx	# _65, _66
	movq	-136(%rbp), %rax	# v, tmp213
	leaq	4(%rax), %rdx	#, _67
	movl	%ecx, %eax	# _66, _68
	lock xaddl	%eax, (%rdx)	#, _68,* _67
	addl	%ecx, %eax	# _66, _68
# preflow.c:385: 	v->e += d;
	movl	%eax, -36(%rbp)	# _69, D.4229
# preflow.c:389: 	assert(d >= 0);
	cmpl	$0, -12(%rbp)	#, d
	jns	.L34	#,
# preflow.c:389: 	assert(d >= 0);
	leaq	__PRETTY_FUNCTION__.0(%rip), %rax	#, tmp214
	movq	%rax, %rcx	# tmp214,
	movl	$389, %edx	#,
	leaq	.LC3(%rip), %rax	#, tmp215
	movq	%rax, %rsi	# tmp215,
	leaq	.LC4(%rip), %rax	#, tmp216
	movq	%rax, %rdi	# tmp216,
	call	__assert_fail@PLT	#
.L34:
# preflow.c:390: 	assert(u->e >= 0);
	movq	-128(%rbp), %rax	# u, tmp217
	addq	$4, %rax	#, _70
	movl	(%rax), %eax	#* _70, _71
# preflow.c:390: 	assert(u->e >= 0);
	movl	%eax, -32(%rbp)	# _72, D.4232
	movl	-32(%rbp), %eax	# D.4232, _73
	testl	%eax, %eax	# _73
	jns	.L35	#,
	leaq	__PRETTY_FUNCTION__.0(%rip), %rax	#, tmp218
	movq	%rax, %rcx	# tmp218,
	movl	$390, %edx	#,
	leaq	.LC3(%rip), %rax	#, tmp219
	movq	%rax, %rsi	# tmp219,
	leaq	.LC5(%rip), %rax	#, tmp220
	movq	%rax, %rdi	# tmp220,
	call	__assert_fail@PLT	#
.L35:
# preflow.c:391: 	assert(abs(e->f) <= e->c);
	movq	-144(%rbp), %rax	# e, tmp221
	addq	$16, %rax	#, _74
	movl	(%rax), %eax	#* _74, _75
# preflow.c:391: 	assert(abs(e->f) <= e->c);
	movl	%eax, -28(%rbp)	# _76, D.4235
	movl	-28(%rbp), %eax	# D.4235, _77
	movl	%eax, %edx	# _77, tmp232
	negl	%edx	# tmp232
	cmovs	%eax, %edx	# tmp232,, _77, _78
	movq	-144(%rbp), %rax	# e, tmp222
	addq	$20, %rax	#, _79
	movl	(%rax), %eax	#* _79, _80
# preflow.c:391: 	assert(abs(e->f) <= e->c);
	movl	%eax, -24(%rbp)	# _81, D.4236
	movl	-24(%rbp), %eax	# D.4236, _82
	cmpl	%eax, %edx	# _82, _78
	jle	.L36	#,
# preflow.c:391: 	assert(abs(e->f) <= e->c);
	leaq	__PRETTY_FUNCTION__.0(%rip), %rax	#, tmp223
	movq	%rax, %rcx	# tmp223,
	movl	$391, %edx	#,
	leaq	.LC3(%rip), %rax	#, tmp224
	movq	%rax, %rsi	# tmp224,
	leaq	.LC6(%rip), %rax	#, tmp225
	movq	%rax, %rdi	# tmp225,
	call	__assert_fail@PLT	#
.L36:
# preflow.c:393: 	if (u->e > 0) {
	movq	-128(%rbp), %rax	# u, tmp226
	addq	$4, %rax	#, _83
	movl	(%rax), %eax	#* _83, _84
# preflow.c:393: 	if (u->e > 0) {
	movl	%eax, -20(%rbp)	# _85, D.4237
# preflow.c:393: 	if (u->e > 0) {
	movl	-20(%rbp), %eax	# D.4237, _86
# preflow.c:393: 	if (u->e > 0) {
	testl	%eax, %eax	# _86
	jle	.L37	#,
# preflow.c:397: 		enter_excess(g, u);
	movq	-128(%rbp), %rdx	# u, tmp227
	movq	-120(%rbp), %rax	# g, tmp228
	movq	%rdx, %rsi	# tmp227,
	movq	%rax, %rdi	# tmp228,
	call	enter_excess	#
.L37:
# preflow.c:400: 	if (v->e == d) {
	movq	-136(%rbp), %rax	# v, tmp229
	addq	$4, %rax	#, _87
	movl	(%rax), %eax	#* _87, _88
# preflow.c:400: 	if (v->e == d) {
	movl	%eax, -16(%rbp)	# _89, D.4238
# preflow.c:400: 	if (v->e == d) {
	movl	-16(%rbp), %eax	# D.4238, _90
# preflow.c:400: 	if (v->e == d) {
	cmpl	%eax, -12(%rbp)	# _90, d
	jne	.L40	#,
# preflow.c:407: 		enter_excess(g, v);
	movq	-136(%rbp), %rdx	# v, tmp230
	movq	-120(%rbp), %rax	# g, tmp231
	movq	%rdx, %rsi	# tmp230,
	movq	%rax, %rdi	# tmp231,
	call	enter_excess	#
.L40:
# preflow.c:409: }
	nop	
	movq	-8(%rbp), %rax	# D.4384, tmp233
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp233
	je	.L39	#,
	call	__stack_chk_fail@PLT	#
.L39:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE15:
	.size	push, .-push
	.globl	hello
	.bss
	.align 4
	.type	hello, @object
	.size	hello, 4
hello:
	.zero	4
	.text
	.type	relabel, @function
relabel:
.LFB16:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
	movq	%rdi, -24(%rbp)	# g, g
	movq	%rsi, -32(%rbp)	# u, u
# preflow.c:413: {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp107
	movq	%rax, -8(%rbp)	# tmp107, D.4389
	xorl	%eax, %eax	# tmp107
# preflow.c:414: 	hello &= 0x1234;
	movl	hello(%rip), %eax	# hello, hello.6_1
	andl	$4660, %eax	#, _2
	movl	%eax, hello(%rip)	# _2, hello
# preflow.c:415: 	u->h += 1;
	movl	$1, -16(%rbp)	#, D.4244
	movl	-16(%rbp), %eax	# D.4244, _3
	movl	%eax, %ecx	# _3, _4
	movq	-32(%rbp), %rdx	# u, _5
	movl	%ecx, %eax	# _4, _6
	lock xaddl	%eax, (%rdx)	#, _6,* _5
	addl	%ecx, %eax	# _4, _6
# preflow.c:415: 	u->h += 1;
	movl	%eax, -12(%rbp)	# _7, D.4245
# preflow.c:416: 	hello &= 0x5678;
	movl	hello(%rip), %eax	# hello, hello.7_8
	andl	$22136, %eax	#, _9
	movl	%eax, hello(%rip)	# _9, hello
# preflow.c:419: 	enter_excess(g, u);
	movq	-32(%rbp), %rdx	# u, tmp108
	movq	-24(%rbp), %rax	# g, tmp109
	movq	%rdx, %rsi	# tmp108,
	movq	%rax, %rdi	# tmp109,
	call	enter_excess	#
# preflow.c:420: }
	nop	
	movq	-8(%rbp), %rax	# D.4389, tmp110
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp110
	je	.L42	#,
	call	__stack_chk_fail@PLT	#
.L42:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE16:
	.size	relabel, .-relabel
	.type	other, @function
other:
.LFB17:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)	# u, u
	movq	%rsi, -16(%rbp)	# e, e
# preflow.c:424: 	if (u == e->u)
	movq	-16(%rbp), %rax	# e, tmp101
	movq	(%rax), %rax	# e_4(D)->u, _1
# preflow.c:424: 	if (u == e->u)
	cmpq	%rax, -8(%rbp)	# _1, u
	jne	.L44	#,
# preflow.c:425: 		return e->v;
	movq	-16(%rbp), %rax	# e, tmp102
	movq	8(%rax), %rax	# e_4(D)->v, _2
	jmp	.L45	#
.L44:
# preflow.c:427: 		return e->u;
	movq	-16(%rbp), %rax	# e, tmp103
	movq	(%rax), %rax	# e_4(D)->u, _2
.L45:
# preflow.c:428: }
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE17:
	.size	other, .-other
	.globl	preflow
	.type	preflow, @function
preflow:
.LFB18:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$112, %rsp	#,
	movq	%rdi, -104(%rbp)	# g, g
# preflow.c:431: {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp136
	movq	%rax, -8(%rbp)	# tmp136, D.4390
	xorl	%eax, %eax	# tmp136
# preflow.c:439: 	s = g->s;
	movq	-104(%rbp), %rax	# g, tmp137
	movq	24(%rax), %rax	# g_53(D)->s, tmp138
	movq	%rax, -24(%rbp)	# tmp138, s
# preflow.c:440: 	s->h = g->n;
	movq	-104(%rbp), %rax	# g, tmp139
	movl	(%rax), %eax	# g_53(D)->n, _1
# preflow.c:440: 	s->h = g->n;
	movl	%eax, -88(%rbp)	# _1, D.4259
	movl	-88(%rbp), %eax	# D.4259, _2
	movl	%eax, %edx	# _2, _3
	movq	-24(%rbp), %rax	# s, _4
	xchgl	(%rax), %edx	#,* _4, tmp140
# preflow.c:442: 	p = s->edge;
	movq	-24(%rbp), %rax	# s, tmp141
	movq	8(%rax), %rax	# s_54->edge, tmp142
	movq	%rax, -32(%rbp)	# tmp142, p
# preflow.c:449: 	while (p != NULL) {
	jmp	.L47	#
.L48:
# preflow.c:450: 		e = p->edge;
	movq	-32(%rbp), %rax	# p, tmp143
	movq	(%rax), %rax	# p_44->edge, tmp144
	movq	%rax, -40(%rbp)	# tmp144, e
# preflow.c:451: 		p = p->next;
	movq	-32(%rbp), %rax	# p, tmp145
	movq	8(%rax), %rax	# p_44->next, tmp146
	movq	%rax, -32(%rbp)	# tmp146, p
# preflow.c:453: 		s->e += e->c;
	movq	-40(%rbp), %rax	# e, tmp147
	addq	$20, %rax	#, _5
	movl	(%rax), %eax	#* _5, _6
# preflow.c:453: 		s->e += e->c;
	movl	%eax, -84(%rbp)	# _7, D.4260
# preflow.c:453: 		s->e += e->c;
	movl	-84(%rbp), %eax	# D.4260, _8
	movl	%eax, -80(%rbp)	# _8, D.4261
	movl	-80(%rbp), %eax	# D.4261, _9
	movl	%eax, %ecx	# _9, _10
	movq	-24(%rbp), %rax	# s, tmp148
	leaq	4(%rax), %rdx	#, _11
	movl	%ecx, %eax	# _10, _12
	lock xaddl	%eax, (%rdx)	#, _12,* _11
	addl	%ecx, %eax	# _10, _12
# preflow.c:453: 		s->e += e->c;
	movl	%eax, -76(%rbp)	# _13, D.4262
# preflow.c:454: 		push(g, s, other(s, e), e);
	movq	-40(%rbp), %rdx	# e, tmp149
	movq	-24(%rbp), %rax	# s, tmp150
	movq	%rdx, %rsi	# tmp149,
	movq	%rax, %rdi	# tmp150,
	call	other	#
	movq	%rax, %rdi	#, _14
# preflow.c:454: 		push(g, s, other(s, e), e);
	movq	-40(%rbp), %rdx	# e, tmp151
	movq	-24(%rbp), %rsi	# s, tmp152
	movq	-104(%rbp), %rax	# g, tmp153
	movq	%rdx, %rcx	# tmp151,
	movq	%rdi, %rdx	# _14,
	movq	%rax, %rdi	# tmp153,
	call	push	#
.L47:
# preflow.c:449: 	while (p != NULL) {
	cmpq	$0, -32(%rbp)	#, p
	jne	.L48	#,
# preflow.c:459: 	while ((u = leave_excess(g)) != NULL) {
	jmp	.L49	#
.L57:
# preflow.c:474: 		v = NULL;
	movq	$0, -48(%rbp)	#, v
# preflow.c:475: 		p = u->edge;
	movq	-16(%rbp), %rax	# u, tmp154
	movq	8(%rax), %rax	# u_60->edge, tmp155
	movq	%rax, -32(%rbp)	# tmp155, p
# preflow.c:477: 		while (p != NULL) {
	jmp	.L50	#
.L55:
# preflow.c:478: 			e = p->edge;
	movq	-32(%rbp), %rax	# p, tmp156
	movq	(%rax), %rax	# p_45->edge, tmp157
	movq	%rax, -40(%rbp)	# tmp157, e
# preflow.c:479: 			p = p->next;
	movq	-32(%rbp), %rax	# p, tmp158
	movq	8(%rax), %rax	# p_45->next, tmp159
	movq	%rax, -32(%rbp)	# tmp159, p
# preflow.c:481: 			if (u == e->u) {
	movq	-40(%rbp), %rax	# e, tmp160
	movq	(%rax), %rax	# e_66->u, _15
# preflow.c:481: 			if (u == e->u) {
	cmpq	%rax, -16(%rbp)	# _15, u
	jne	.L51	#,
# preflow.c:482: 				v = e->v;
	movq	-40(%rbp), %rax	# e, tmp161
	movq	8(%rax), %rax	# e_66->v, tmp162
	movq	%rax, -48(%rbp)	# tmp162, v
# preflow.c:483: 				b = 1;
	movl	$1, -52(%rbp)	#, b
	jmp	.L52	#
.L51:
# preflow.c:485: 				v = e->u;
	movq	-40(%rbp), %rax	# e, tmp163
	movq	(%rax), %rax	# e_66->u, tmp164
	movq	%rax, -48(%rbp)	# tmp164, v
# preflow.c:486: 				b = -1;
	movl	$-1, -52(%rbp)	#, b
.L52:
# preflow.c:489: 			if (u->h > v->h && b * e->f < e->c)
	movq	-16(%rbp), %rax	# u, _16
	movl	(%rax), %eax	#* _16, _17
# preflow.c:489: 			if (u->h > v->h && b * e->f < e->c)
	movl	%eax, -72(%rbp)	# _18, D.4263
# preflow.c:489: 			if (u->h > v->h && b * e->f < e->c)
	movl	-72(%rbp), %edx	# D.4263, _19
	movq	-48(%rbp), %rax	# v, _20
	movl	(%rax), %eax	#* _20, _21
# preflow.c:489: 			if (u->h > v->h && b * e->f < e->c)
	movl	%eax, -68(%rbp)	# _22, D.4264
	movl	-68(%rbp), %eax	# D.4264, _23
# preflow.c:489: 			if (u->h > v->h && b * e->f < e->c)
	cmpl	%eax, %edx	# _23, _19
	jle	.L53	#,
# preflow.c:489: 			if (u->h > v->h && b * e->f < e->c)
	movq	-40(%rbp), %rax	# e, tmp165
	addq	$16, %rax	#, _24
	movl	(%rax), %eax	#* _24, _25
	movl	%eax, -64(%rbp)	# _26, D.4265
	movl	-64(%rbp), %eax	# D.4265, _27
	imull	-52(%rbp), %eax	# b, _27
	movl	%eax, %edx	# _27, _28
# preflow.c:489: 			if (u->h > v->h && b * e->f < e->c)
	movq	-40(%rbp), %rax	# e, tmp166
	addq	$20, %rax	#, _29
	movl	(%rax), %eax	#* _29, _30
# preflow.c:489: 			if (u->h > v->h && b * e->f < e->c)
	movl	%eax, -60(%rbp)	# _31, D.4266
	movl	-60(%rbp), %eax	# D.4266, _32
# preflow.c:489: 			if (u->h > v->h && b * e->f < e->c)
	cmpl	%eax, %edx	# _32, _28
	jl	.L54	#,
.L53:
# preflow.c:492: 				v = NULL;
	movq	$0, -48(%rbp)	#, v
.L50:
# preflow.c:477: 		while (p != NULL) {
	cmpq	$0, -32(%rbp)	#, p
	jne	.L55	#,
.L54:
# preflow.c:495: 		if (v != NULL)
	cmpq	$0, -48(%rbp)	#, v
	je	.L56	#,
# preflow.c:496: 			push(g, u, v, e);
	movq	-40(%rbp), %rcx	# e, tmp167
	movq	-48(%rbp), %rdx	# v, tmp168
	movq	-16(%rbp), %rsi	# u, tmp169
	movq	-104(%rbp), %rax	# g, tmp170
	movq	%rax, %rdi	# tmp170,
	call	push	#
	jmp	.L49	#
.L56:
# preflow.c:498: 			relabel(g, u);
	movq	-16(%rbp), %rdx	# u, tmp171
	movq	-104(%rbp), %rax	# g, tmp172
	movq	%rdx, %rsi	# tmp171,
	movq	%rax, %rdi	# tmp172,
	call	relabel	#
.L49:
# preflow.c:459: 	while ((u = leave_excess(g)) != NULL) {
	movq	-104(%rbp), %rax	# g, tmp173
	movq	%rax, %rdi	# tmp173,
	call	leave_excess	#
	movq	%rax, -16(%rbp)	# tmp174, u
# preflow.c:459: 	while ((u = leave_excess(g)) != NULL) {
	cmpq	$0, -16(%rbp)	#, u
	jne	.L57	#,
# preflow.c:501: 	return g->t->e;
	movq	-104(%rbp), %rax	# g, tmp175
	movq	32(%rax), %rax	# g_53(D)->t, _33
# preflow.c:501: 	return g->t->e;
	addq	$4, %rax	#, _34
	movl	(%rax), %eax	#* _34, _35
# preflow.c:501: 	return g->t->e;
	movl	%eax, -56(%rbp)	# _36, D.4267
	movl	-56(%rbp), %eax	# D.4267, _63
# preflow.c:502: }
	movq	-8(%rbp), %rdx	# D.4390, tmp177
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp177
	je	.L59	#,
	call	__stack_chk_fail@PLT	#
.L59:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE18:
	.size	preflow, .-preflow
	.type	free_graph, @function
free_graph:
.LFB19:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$48, %rsp	#,
	movq	%rdi, -40(%rbp)	# g, g
# preflow.c:510: 	for (i = 0; i < g->n; i += 1) {
	movl	$0, -20(%rbp)	#, i
# preflow.c:510: 	for (i = 0; i < g->n; i += 1) {
	jmp	.L61	#
.L64:
# preflow.c:511: 		p = g->v[i].edge;
	movq	-40(%rbp), %rax	# g, tmp105
	movq	8(%rax), %rcx	# g_14(D)->v, _1
# preflow.c:511: 		p = g->v[i].edge;
	movl	-20(%rbp), %eax	# i, tmp106
	movslq	%eax, %rdx	# tmp106, _2
	movq	%rdx, %rax	# _2, _3
	addq	%rax, %rax	# _3
	addq	%rdx, %rax	# _2, _3
	salq	$3, %rax	#, tmp108
	addq	%rcx, %rax	# _1, _4
# preflow.c:511: 		p = g->v[i].edge;
	movq	8(%rax), %rax	# _4->edge, tmp109
	movq	%rax, -16(%rbp)	# tmp109, p
# preflow.c:512: 		while (p != NULL) {
	jmp	.L62	#
.L63:
# preflow.c:513: 			q = p->next;
	movq	-16(%rbp), %rax	# p, tmp110
	movq	8(%rax), %rax	# p_9->next, tmp111
	movq	%rax, -8(%rbp)	# tmp111, q
# preflow.c:514: 			free(p);
	movq	-16(%rbp), %rax	# p, tmp112
	movq	%rax, %rdi	# tmp112,
	call	free@PLT	#
# preflow.c:515: 			p = q;
	movq	-8(%rbp), %rax	# q, tmp113
	movq	%rax, -16(%rbp)	# tmp113, p
.L62:
# preflow.c:512: 		while (p != NULL) {
	cmpq	$0, -16(%rbp)	#, p
	jne	.L63	#,
# preflow.c:510: 	for (i = 0; i < g->n; i += 1) {
	addl	$1, -20(%rbp)	#, i
.L61:
# preflow.c:510: 	for (i = 0; i < g->n; i += 1) {
	movq	-40(%rbp), %rax	# g, tmp114
	movl	(%rax), %eax	# g_14(D)->n, _5
# preflow.c:510: 	for (i = 0; i < g->n; i += 1) {
	cmpl	%eax, -20(%rbp)	# _5, i
	jl	.L64	#,
# preflow.c:518: 	free(g->v);
	movq	-40(%rbp), %rax	# g, tmp115
	movq	8(%rax), %rax	# g_14(D)->v, _6
# preflow.c:518: 	free(g->v);
	movq	%rax, %rdi	# _6,
	call	free@PLT	#
# preflow.c:519: 	free(g->e);
	movq	-40(%rbp), %rax	# g, tmp116
	movq	16(%rax), %rax	# g_14(D)->e, _7
# preflow.c:519: 	free(g->e);
	movq	%rax, %rdi	# _7,
	call	free@PLT	#
# preflow.c:520: 	free(g);
	movq	-40(%rbp), %rax	# g, tmp117
	movq	%rax, %rdi	# tmp117,
	call	free@PLT	#
# preflow.c:521: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE19:
	.size	free_graph, .-free_graph
	.section	.rodata
.LC7:
	.string	"f = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB20:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$48, %rsp	#,
	movl	%edi, -36(%rbp)	# argc, argc
	movq	%rsi, -48(%rbp)	# argv, argv
# preflow.c:531: 	progname = argv[0];	/* name is a string in argv[0]. */
	movq	-48(%rbp), %rax	# argv, tmp101
	movq	(%rax), %rax	# *argv_3(D), _1
# preflow.c:531: 	progname = argv[0];	/* name is a string in argv[0]. */
	movq	%rax, progname(%rip)	# _1, progname
# preflow.c:533: 	in = stdin;		/* same as System.in in Java.	*/
	movq	stdin(%rip), %rax	# stdin, tmp102
	movq	%rax, -16(%rbp)	# tmp102, in
# preflow.c:535: 	n = next_int();
	movl	$0, %eax	#,
	call	next_int	#
	movl	%eax, -28(%rbp)	# tmp103, n
# preflow.c:536: 	m = next_int();
	movl	$0, %eax	#,
	call	next_int	#
	movl	%eax, -24(%rbp)	# tmp104, m
# preflow.c:539: 	next_int();
	movl	$0, %eax	#,
	call	next_int	#
# preflow.c:540: 	next_int();
	movl	$0, %eax	#,
	call	next_int	#
# preflow.c:542: 	g = new_graph(in, n, m);
	movl	-24(%rbp), %edx	# m, tmp105
	movl	-28(%rbp), %ecx	# n, tmp106
	movq	-16(%rbp), %rax	# in, tmp107
	movl	%ecx, %esi	# tmp106,
	movq	%rax, %rdi	# tmp107,
	call	new_graph	#
	movq	%rax, -8(%rbp)	# tmp108, g
# preflow.c:544: 	fclose(in);
	movq	-16(%rbp), %rax	# in, tmp109
	movq	%rax, %rdi	# tmp109,
	call	fclose@PLT	#
# preflow.c:546: 	f = preflow(g);
	movq	-8(%rbp), %rax	# g, tmp110
	movq	%rax, %rdi	# tmp110,
	call	preflow	#
	movl	%eax, -20(%rbp)	# tmp111, f
# preflow.c:548: 	printf("f = %d\n", f);
	movl	-20(%rbp), %eax	# f, tmp112
	movl	%eax, %esi	# tmp112,
	leaq	.LC7(%rip), %rax	#, tmp113
	movq	%rax, %rdi	# tmp113,
	movl	$0, %eax	#,
	call	printf@PLT	#
# preflow.c:550: 	free_graph(g);
	movq	-8(%rbp), %rax	# g, tmp114
	movq	%rax, %rdi	# tmp114,
	call	free_graph	#
# preflow.c:552: 	return 0;
	movl	$0, %eax	#, _19
# preflow.c:553: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE20:
	.size	main, .-main
	.section	.rodata
	.type	__PRETTY_FUNCTION__.0, @object
	.size	__PRETTY_FUNCTION__.0, 5
__PRETTY_FUNCTION__.0:
	.string	"push"
	.ident	"GCC: (GNU) 14.2.1 20240910"
	.section	.note.GNU-stack,"",@progbits
