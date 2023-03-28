    .data
buf:
	.space	32
    .text
    .global main

main:
        mov     $32,	%rdi
        mov     $buf,	%rsi
	call	read_i
	mov	%rax,	%rbx

        mov     $32,	%rdi
        mov     $buf,	%rsi
	call	read_i

        call    add

        mov     %rbx,	%rax
        call    print_i

        jmp     exit

add:
        cmp     $0,     %rax
        jne     add_loop
        ret

add_loop:
        xor     %rax,   %rbx    # [    A    ]  [ A^B ]
        xor     %rbx,   %rax    # [ (A^B)^A ]  [ A^B ]
        not     %rbx            # [    B    ]  [~A^B ]
        and     %rbx,   %rax    # [   A&B   ]  [~A^B ]
        not     %rbx            # [   A&B   ]  [ A^B ]

        shl     $1,     %rax
        jmp     add

exit:
        mov     $60,    %rax
        mov     $0,     %rdi
        syscall
