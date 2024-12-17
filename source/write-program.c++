#include "system.c++"

system {
	if (arguments->count >= 1) {
		unsigned long size = 0;
		while (arguments->value[0][size] != '\0') {
			size += 1;
		}
		(void) write(output, arguments->value[0], size);
		(void) write(output, "\n", 1);
	} else {
		exit(failure);
	}
}