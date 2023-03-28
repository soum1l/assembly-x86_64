    .global read_i

# args:	buffer length	:= rdi
# 	buffer pointer  := rsi
# retv:	integer		:= rax
read_i:
	## READ FROM STDIN ##
	mov	%rsi,	%rsi	# set read buffer
	mov	%rdi,	%rdx	# set read length
	mov	$0,	%rax	# syscall 0 [read]
	mov	$0,	%rdi	# handle 0 [stdin]
	syscall

	## FINDING LENGTH ##
        xor     %rdx,	%rdx	# clear temp register
	xor	%r10,	%r10	# zero out length register
	read_i_L1:
	cmpb	$0, (%rsi,%r10,1)
	je	read_i_L1_end	# if \0, break loop
	inc	%r10		# else, increment length
	jmp	read_i_L1	# and repeat.
	read_i_L1_end:
	dec	%r10

	## PARSING INTEGER FROM STRING ##
	mov     $1,	%rdx	# rdx = powers of 10
        xor     %rax,	%rax	# clear output register
	read_i_L2:
        xor     %rcx,	%rcx	# clear temp register

        dec     %r10			# decrement length counter
        movb    (%rsi,%r10,1),	%cl
        sub     $0x30,		%rcx	# convert ASCII to numeric val

        imul    %rdx,	%rcx	# multiply with 10^k
        add     %rcx,	%rax	# add res to output number

        imul    $10,	%rdx	# multiply base with 10

        cmp     $0,	%r10	# repeat if length is not 0
	jg	read_i_L2

	## DETECT SIGN ##
	cmpb	$0x2d, (%rsi)
	jne	read_i_end
	sub	%rcx,	%rax
	neg	%rax

read_i_end:
        ret
