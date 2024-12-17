system_exit equ 60
system_success equ 0
section .text
	extern system
	global stack
	stack:
		mov rdi, rsp
		sub rsp, 8
		call system
		add rsp, 8
		mov rdi, system_success
		mov rax, system_exit
		syscall