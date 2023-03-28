    .data
array: .long   1,2,9,4,10,5,1

    .text
       .global main

main:
        xor     %rdi,   %rdi            # set index to 0
        movl    array(, %rdi, 4), %eax  # start with initial as max

loop:
        inc     %rdi                    # increment index

        cmp     $6,     %rdi
        jge     exit                    # exit if end of array reached

        cmp     array(, %rdi, 4), %eax  # compare with current max
        jge     loop                    # continue if number in array is lesser than max

        mov     array(, %rdi, 4), %eax  # else, set new number as max
        jmp     loop

exit:
	call	print_i
        mov     $60,	%rax
        mov	$0,	%rdi
	syscall
