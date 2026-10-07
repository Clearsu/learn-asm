
section .data ; data used by program
	; first_msg: label - alias for an address
	; db: Define Byte - puts following data into file byte by byte
	; 10: ASCII newline ('\n' in C)
	first_msg db "Hello, world!", 10

	; equ: defines constant
	; $: current assembly position (??)
	first_msg_len equ $ - first_msg

	second_msg db "I am learning assembly.", 10
	second_msg_len equ $ - second_msg

section .text ; code to execute
	global _start ; expose the symbol "_start" to let the linker find the entrypoint

; [Linux x86-64 syscall conversion]
; rax = syscall number
; rdi = argument 1
; rsi = argument 2
; rdx = argument 3
; r10 = argument 4
; r8 = argument 5
; r9 = argument 6

_start: ; label.
	; write(1, msg, len)
	mov rax, 1 ; syscall: write
	mov rdi, 1
	mov rsi, first_msg
	mov rdx, first_msg_len
	syscall ; CPU changes to kernel mode

	mov rax, 1
	mov rdi, 1
	mov rsi, second_msg
	mov rdx, second_msg_len
	syscall

	; exit(0)
	mov rax, 60 ; syscall: exit
	mov rdi, 0
	syscall
