section .bss
    digit resb 2

section .text
    global _start

_start:
    mov r12, 0

.loop:
    mov rax, r12
    add al, '1'
    mov [digit], al
    mov byte [digit + 1], 10 ; new line

    mov rax, 1
    mov rdi, 1
    mov rsi, digit
    mov rdx, 2
    syscall

    ; in case of decrement, dec r12 ; decrement (r12--)
    inc r12
    cmp r12, 5
    jne .loop

.exit:
    mov rax, 60
    xor edi, edi
    syscall
