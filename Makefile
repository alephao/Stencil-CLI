.PHONY: build format clean generate_makefile

build:
	swift build -c release --disable-sandbox
format:
	swiftformat .
clean:
	rm -fr .build
generate_makefile:
	swift run stencly render -t Makefile.stencil -d ./Makefile.yaml -o ./Makefile
