#include "system.c++"

system {
	exit(arguments->count - 1);
}