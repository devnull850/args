	.global _start
	.global main

	.bss
	.data
n:
	.ascii	"\n"

	.text
main:
        push	%rbp
	movq	%rsp,%rbp
	add	$0xffffffffffffffe0,%rsp
        movl	%edi,0xfffffffffffffffc(%rbp)	# argc
        movq	%rsi,0xffffffffffffffe8(%rbp)	# argv
	movl	$0,%eax	
	movl	%eax,0xfffffffffffffff8(%rbp)	# i = 0
.l0:
	movl	0xfffffffffffffff8(%rbp),%eax
	movl	0xfffffffffffffffc(%rbp),%edx
	cmp	%edx,%eax			# i < argc
	jge	.end
	movl	%eax,%edx
	add	$1,%eax				# i = i + 1
	movl	%eax,0xfffffffffffffff8(%rbp)
	movq	0xffffffffffffffe8(%rbp),%rax
	lea	(%rax,%rdx,8),%rax
	movq	(%rax),%rax			# argv[i]
.l1:
	movb	(%rax),%dl
	test	%dl,%dl
	je	.newline
	movq	%rax,%rdx
	add	$1,%rdx
	movq	%rdx,0xfffffffffffffff0(%rbp)
	movq	%rax,%rsi			# input string
	movq	$1,%rax				# write system call
	movq	$1,%rdi				# stdout
	movq	$1,%rdx				# number of bytes to write
	syscall
	movq	0xfffffffffffffff0(%rbp),%rax
	jmp	.l1
.newline:
	movq	$1,%rax
	movq	$1,%rdi
	movq	$n,%rsi
	movq	$1,%rdx
	syscall
	jmp	.l0
.end:
	movl	$0,%eax
        add	$0x20,%rsp
        pop	%rbp 
        ret

_start:
	pop	%rdi
	mov	%rsp,%rsi
        call 	main
	mov	%rax,%rdi
	mov	$0x3c,%rax
	syscall
