prefix ?= /usr/local
bindir = $(prefix)/bin

install: build
	install ".build/release/stencil" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/stencil"

build:
	swift build -c release --disable-sandbox

format:
	swiftformat .

clean:
	rm -rf .build

makefile:
	swift run stencil render -t Templates/Makefile.stencil -d Templates/Makefile.yaml -o ./Makefile

archive: build
	mkdir -p archive
	tar -cvzf ./archive/stencil-cli.tar.gz  -C .build/release/ stencil

list:
	@echo Available commands:
	@echo - install
	@echo - uninstall
	@echo - build
	@echo - format
	@echo - clean
	@echo - makefile
	@echo - archive

.PHONY: install uninstall build format clean makefile archive list
