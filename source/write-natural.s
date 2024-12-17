system_write equ 1
system_exit equ 60
system_output equ 1
section .rodata
	line_string db `\n`
section .data
	; value times ceil(log10(2 ^ N - 1)) db 0 
	value times 20 db 0
section .text
	global system
	system:
		mov rax, 012345
		mov rcx, 0
		mov rdx, 1
		mov byte [value], `0`
		increment:
			cmp rax, 0
				jmp write
			; reset decimal index
			; if 9, carry
			;      if overflow grow decimal and inrement most significant digit to one
			; else increment and exit inner loop to the rest of the outer loop
			mov rcx, 0
			carru:
			cmp byte [value + rcx], `9`
				?
			dec rax
			jmp increment
		write:
		mov rsi, value
		add rsi, rdx
		mov rdx, 1
		mov rdi, system_output
		write_decimal:
			dec rsi
			mov rax, system_write
			syscall ; ignore potential error in rax
			cmp rsi, value
				jne write_decimal
		write_line:
		mov rsi, line_string
		mov rax, system_write
		syscall ; ignore potential error in rax
		exit:
		mov rax, system_exit
		mov rdi, 0
		syscall