#include "system.c++"

constexpr char value [] = "Hello, world!\n";

system {
    (void) write(output, value, sizeof(value) - sizeof(""));
}