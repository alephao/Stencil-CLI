prefix ?= /usr/local
bindir ?= $(prefix)/bin

REPODIR = $(shell pwd)
BUILDDIR = $(REPODIR)/.build

.PHONY: build
build:
	swift build \
		-c release \
		--disable-sandbox \
		--build-path "$(BUILDDIR)"

.PHONY: install
install: build
	install -d "$(bindir)"
	install "$(BUILDDIR)/release/stencil" "$(bindir)"

.PHONY: uninstall
uninstall:
	rm -rf "$(bindir)/stencil"

.PHONY: format
format:
	swiftformat .

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)

.PHONY: archive
archive: build
	mkdir -p archive
	tar -cvzf ./archive/stencil-cli.tar.gz  -C $(BUILDDIR)/release/ stencil
