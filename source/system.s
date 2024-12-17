system_exit equ 60
section .text
	extern system
	global stack
	stack:
		mov rdi, rsp
		call system
		mov rax, system_exit
		mov rdi, 0
		syscall