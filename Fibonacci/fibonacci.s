    .data

input:  .space  16

    .text
    .global _start

_start:
	mov	$16,	%rdi
        mov     $input, %rsi
        call    read_i

        mov     %rax,   %rcx

        mov     $0,     %rax
	mov     $1,     %rbx

fibonacci:
        add	%rbx,	%rax
	xchg	%rax,	%rbx

	dec	%rcx
	jnz 	fibonacci

exit:
	call 	print_i
        mov     $60,	%rax
        mov     $0,	%rdi
        syscall
