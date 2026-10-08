section .data
    prompt db "Continue? (y/n): "
    prompt_len equ $ - prompt

    yes_msg db "YES", 10
    yes_len equ $ - yes_msg

    no_msg db "NO", 10
    no_len equ $ - no_msg

section .bss
    buffer resb 2

section .text
    global _start

_start:
    ; prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    ; user input
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 2
    syscall

    ; is buffer[0] == 'y'?
    ; if [buffer] - 'y' equals to 0 then ZF(Zero Flag) in RFLAGS register becomes 1.
    cmp byte [buffer], 'y'
    ; je: Jump if Equal
    ; jump to .yes if ZF == 1
    je .yes

    cmp byte [buffer], 'Y'
    je .yes

    ; if not 'y' or 'Y'
    mov rax, 1
    mov rdi, 1
    mov rsi, no_msg
    mov rdx, no_len
    syscall

    jmp .exit

.yes:
    mov rax, 1
    mov rdi, 1
    mov rsi, yes_msg
    mov rdx, yes_len
    syscall

.exit:
    mov rax, 60
    mov rdi, 0
    syscall
