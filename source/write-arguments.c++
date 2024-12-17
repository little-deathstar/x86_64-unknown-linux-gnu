// FIXME: the index register is maybe being clobbered before it is used to guard writing the space character

#include "system.c++"

system {
	if (arguments->count > 1) {
		#if 1
			for (signed int index = 1; index < arguments->count; index += 1) {
				unsigned long size = 0;
				while (arguments->value[index][size] != '\0') {
					size += 1;
				}
				if (index > 1) {
					(void) write(output, " ", 1);
				}
				(void) write(output, arguments->value[index], size);
			}
			(void) write(output, "\n", 1);
		#else
			signed int index = 1;
			const char * argument;
			unsigned long size;
			argument:
				argument = arguments->value[index];
				if (argument) {
					size = 0;
					goto size;
				} else {
					write(output, "\n", 1);
					return;
				}
			size:
				if (argument[size] == '\0') {
					goto write;
				} else {
					size += 1;
					goto size;
				}
			write:
				if (argument == arguments->value[0]) {
					write(output, " ", 1);
				}
				(void) write(output, argument, size);
				index += 1;
				goto argument;
		#endif
	}
}