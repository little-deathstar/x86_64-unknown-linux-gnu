system_exit equ 60
section .text
	global system
	system:
		mov rax, system_exit
		mov rdi, [rsp]
		dec rdi
		syscall