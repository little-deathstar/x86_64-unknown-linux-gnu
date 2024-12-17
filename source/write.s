system_exit equ 60
system_success equ 1
system_write equ 1
system_output equ 1
section .rodata
	value_string db `Hello, world!\n`
	value_size equ $ - value_string
section .text
	global system
	system:
		mov rdx, value_size
		mov rsi, value_string
		mov rdi, system_output
		mov rax, system_write
		syscall ; ignore potential error in rax
		mov rdi, system_success
		mov rax, system_exit
		syscall