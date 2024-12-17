system_success equ 1
system_exit equ 60
section .text
	global system
	system:
		mov rax, system_exit
		mov rdi, system_success
		syscall