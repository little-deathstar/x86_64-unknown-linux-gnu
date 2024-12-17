system_exit equ 60
system_success equ 1
section .text
	global system
	system:
		mov rdi, system_success
		mov rax, system_exit
		syscall