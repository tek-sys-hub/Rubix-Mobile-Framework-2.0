.PHONY: all test check verify clean doctor help version runtime

all: runtime check test verify

# Build pure native runtime from assembly syscalls
runtime:
	@echo "==> Assembling pure native Rubix runtime (sys.s)..."
	@as -o runtime/sys.o runtime/sys.s
	@ar rcs runtime/librubix_rt.a runtime/sys.o

runtime-windows:
	@echo "==> Assembling pure native Windows x64 runtime (sys_win64.s)..."
	@clang -target x86_64-w64-windows-gnu -c runtime/platform/windows/sys_win64.s -o runtime/platform/windows/sys_win64.o
	@ar rcs runtime/librubix_rt_win64.a runtime/platform/windows/sys_win64.o

# Run static analysis on all general-purpose examples
check:
	@echo "==> Running Rubix static analysis checks on all examples..."
	@for f in examples/*.bix; do ./rubix check "$$f" || exit 1; done

# Run the comprehensive test suite
test:
	@echo "==> Running Rubix comprehensive test suite..."
	@bash scripts/test.sh

# Run determinism and reproducibility verification
verify:
	@echo "==> Running Rubix determinism & reproducibility verification..."
	@bash scripts/verify.sh

doctor:
	@./rubix doctor

version:
	@./rubix version

help:
	@./rubix help

clean:
	@echo "==> Cleaning temporary build artifacts..."
	@rm -rf /tmp/rubix_* /tmp/*.bix /tmp/*.log

PREFIX ?= /usr/local

install:
	@echo "==> Installing Rubix to $(PREFIX)..."
	@install -d $(PREFIX)/bin $(PREFIX)/lib
	@install -m 755 bin/rubix $(PREFIX)/bin/rubix
	@install -m 755 bin/rubixc $(PREFIX)/bin/rubixc
	@install -m 644 runtime/librubix_rt.a $(PREFIX)/lib/librubix_rt.a
	@echo "Rubix installed successfully to $(PREFIX)/bin/rubix"

uninstall:
	@echo "==> Uninstalling Rubix from $(PREFIX)..."
	@rm -f $(PREFIX)/bin/rubix $(PREFIX)/bin/rubixc $(PREFIX)/lib/librubix_rt.a
	@echo "Rubix uninstalled from $(PREFIX)"

