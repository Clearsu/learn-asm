; On Linux x86-64, normal user-space function calls typically
; follow the System V AMD64 ABI.
;
; Integer/pointer arguments:
; 1st arg: rdi
; 2nd arg: rsi
; 3rd arg: rdx
; 4th arg: rcx
; 5th arg: r8
; 6th arg: r9
; and return value: rax


section .bss
    output resb 2

section .text
    global _start

_start:
    mov rdi, 3 ; first arg
    mov rsi, 4 ; second arg

    ; call is not just a fump.
    ; It pushes the address of the next instruction (return address)
    ; onto the stack (rsp -= 8), then jumps to add_numbers.
    ;
    ; For example,
    ;
    ; _start:
    ;0x401000   call add_numbers
    ;0x401005   add al, '0' <- this address is saved
    ;
    call add_numbers

    ; now rax = 7

    add al, '0'
    mov [output], al
    mov byte [output + 1], 10

    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, 2
    syscall

    mov rax, 60
    xor edi, edi
    syscall

add_numbers:
    mov rax, rdi
    add rax, rsi

    ; ret pops the return address from [rsp] into RIP, then rsp += 8.
    ret 
