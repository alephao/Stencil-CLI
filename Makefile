prefix ?= /usr/local
bindir = $(prefix)/bin

install: build
	install ".build/release/stencly" "$(bindir)"

build:
	swift build -c release --disable-sandbox

format:
	swiftformat .

clean:
	rm -rf .build

makefile:
	swift run stencly render -t Templates/Makefile.stencil -d Templates/Makefile.yaml -o ./Makefile

list:
	@echo Available commands:
	@echo - install
	@echo - build
	@echo - format
	@echo - clean
	@echo - makefile

.PHONY: install build format clean makefile list
