#pragma once

#define system extern "C" void system([[maybe_unused]] const struct arguments * const arguments)

#define loop while (true)

template <typename y, typename x> [[clang::always_inline]] inline y cast(x && value) {
	return __builtin_bit_cast(y, value);
}

[[noreturn, clang::always_inline]] inline void unreachable() {
	__builtin_unreachable();
}

constexpr signed int success = 0;
constexpr signed int failure = 1;

[[noreturn, clang::always_inline]] inline void exit(signed int value) {
	asm ("mov %0, %%edi" : : "r"(value) : "rdi");
	asm ("mov %0, %%rax" : : "i"(60) : "rax");
	asm volatile ("syscall" : : : "rax", "rcx");
	unreachable();
}

constexpr signed int output = 1;

[[clang::always_inline]] inline signed long write(int file, const char * value, unsigned long size) {
	signed long write;
	asm ("mov %0, %%rdx" : : "r"(size) : "rdx");
	asm ("mov %0, %%rsi" : : "r"(value) : "rsi");
	asm ("mov %0, %%edi" : : "r"(file) : "rdi");
	asm ("mov %0, %%rax" : : "i"(1) : "rax");
	asm volatile ("syscall" : : : "rax", "rcx");
	asm ("mov %%rax, %0" : "=r"(write) : : "rax");
	return write;
}

struct arguments {
	const signed int count;
	const char * value [];
};