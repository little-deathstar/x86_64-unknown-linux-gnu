# x86_64-unknown-linux-gnu

These assembly, llvm, and c++ examples are tested using LLVM 19.1.5 on a Ryzen 3900X running Debian 12.

The assembly examples directly jump to the application, system.

The llvm and c++ examples call a c function, system, passed an immutable pointer to a dynamically sized structure of the argument count and arguments.
The array of arguments is terminated by a null pointer and every argument is terminated by a null character.
If the function returns, the process will exit with a value of zero.

- undefined
- loop
	`loop.ir` fails to compile with optimizations.
- exit
- write
- write-natural
	unimplimented
- exit-argument-count
- write-program
- write-arguments
	`write-arguments.ir` works without optimizations.
	`write-arguments.c++` works without optimizations.
	These bugs call into question the validity of `exit-argument-count.c++` and `write-program.c++`