system_success equ 0
system_exit equ 60
system_output equ 1
system_write equ 1
section .rodata
	space_string db ` `
	line_string db `\n`
section .text
	global system
	system:
		cmp word [rsp], 1
			jle exit
		mov rbx, 2
		jmp argument
		arguments:
			cmp qword [rsp + rbx * 8], 0
				je line
			mov rax, system_write
			mov rsi, space_string
			mov rdx, 1
			syscall
			argument:
			mov rsi, [rsp + rbx * 8]
			mov rdx, 0
			size_argument:
				cmp byte [rsi + rdx], 0
					je write_argument
				inc rdx
				jmp size_argument
			write_argument:
			mov rax, system_write
			mov rdi, system_output
			syscall
			inc rbx
			jmp arguments
		line:
		mov rax, system_write
		mov rsi, line_string
		mov rdx, 1
		syscall
		exit:
		mov rax, system_exit
		mov rdi, system_success
		syscall