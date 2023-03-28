    .global print_s, strlen, print_i

# STRING LENGTH CALCULATOR
strlen:
        xor     %rcx, %rcx              # init counter to 0

    strlen_count:
        movb    (%rsi,%rcx,1), %ah      # move char from memory for cmp
        inc     %rcx                    # increment string address
        cmp     $0, %ah                 # compare char with NULL
        jne     strlen_count            # repeat if char is NOT the NULL terminator

        ret

# STRING PRINT ROUTINE
print_s:
        call    strlen                  # get string length
        mov     %rcx, %rdx              # set length of string

        mov     $1, %rax                # system call 1 is write
        mov     $1, %rdi                # file handle 1 is stdout

        syscall                         # invoke syscall
        ret

# INTEGER PRINT ROUTINE
print_i:
        xor     %rcx,   %rcx        # zero out rcx
        mov     $10,    %rbx        # move divisor into rbx

    print_i_L0: # digit extraction

        xor     %rdx,   %rdx        # zero out rdx
        idiv    %rbx                # divide by 10 ;; quotient(remaining number) in rax, remainder(last digit) in rdx

        add     $8,     %rcx        # increment string bit length (by 1 byte)
        add     $0x30,  %rdx        # convert decimal to ASCII
        push    %rdx                # push digit into stack

        cmp     $0,     %rax        # check if rax is 0
        jne     print_i_L0          # repeat for rest of the number

        mov     %rsp,   %rsi        # move stack pointer to source reg
        mov     %rcx,   %rdx        # length of int string is in rcx
        mov     $1,     %rax        # syscall 1(write)
        mov     $1,     %rdi        # output handle 1(stdout)

        add     %rcx,   %rsp        # restore stack pointer
        syscall                     # invoke system to perform 'write'

        ret
