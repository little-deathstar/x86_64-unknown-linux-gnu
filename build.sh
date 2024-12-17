set -e
directory="$(dirname "$(realpath "$0")")"
if [ "$1" = "--optimize" ]; then
	shift
	optimize="-flto -O3"
else
	optimize="-O0"
fi
if [ "$1" = "--strip" ]; then
	shift
	strip="--strip-all"
else
	strip=""
fi
if [ "$1" ]; then
	file="$1"
	shift
	if [ ! -d "$directory/build" ]; then
		mkdir "$directory/build"
	fi
	name="$(basename "$file")"
	case "$file" in
	*.s)
		language="nasm"
		nasm -f elf64 "$file" -o "$directory/build/$name.o"
		;;
	*.ir)
		language="ir"
		clang -c -x ir -Werror -Wall -Wextra $optimize "$file" -o "$directory/build/$name.o"
		language="llvm"
		;;
	*.c++)
		language="c++"
		clang -c -x c++ -Werror -Wall -Wextra -Wno-c99-extensions -pedantic -ansi -std=c++17 -nostdlib -fno-rtti -fno-exceptions $optimize "$file" -o "$directory/build/$name.o"
		;;
	*)
		echo "error: unknown source file: $file" 
		exit 1
		;;
	esac
	if [ "$language" = "nasm" ]; then
		entry=system
		files=""$directory/build/$name.o""
	else
		nasm -f elf64 "$directory/source/system.s" -o "$directory/build/system.o"
		entry=stack
		files=""$directory/build/system.o" "$directory/build/$name.o""
	fi
	ld.lld -z noexecstack --entry="$entry" $files $strip -o "$directory/build/$name"
	batcat --paging=never --language "$language" "$file"
	llvm-objdump --disassemble --x86-asm-syntax=intel "$directory/build/$name"
	echo
	echo "$directory/build/$name" "$@"
	(
		set +e
		"$directory/build/$name" "$@"
		echo "exit: $?"
	)
else
	echo "error: no source file argument" 
	exit 1
fi