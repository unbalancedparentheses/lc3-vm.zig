build:
	zig build-exe hello.zig

run: build
	./hello
