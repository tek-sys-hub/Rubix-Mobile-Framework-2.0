.PHONY: all test check verify clean doctor help version runtime

all: runtime check test verify

# Build pure native runtime from assembly syscalls
runtime:
	@echo "==> Assembling pure native Rubix runtime (sys.s)..."
	@as -o runtime/sys.o runtime/sys.s
	@ar rcs runtime/librubix_rt.a runtime/sys.o

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
