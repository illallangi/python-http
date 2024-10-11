.PHONY: usage
usage:
	@echo "Usage: make [target]"
	@echo
	@echo "Targets:"
	@echo "  clean       Remove all generated files"
	@echo "  lint        Run ruff format, check and uv sync"
	@echo "  commit      Run cz commit"
	@echo "  build       Build the project"
	@echo
	@echo "  help        Run http-tools help"
	@echo "  version     Run http-tools version"
	@echo

.PHONY: clean
clean:
	@git clean -Xdf
	@mkdir -p .git/hooks
	@rm -f .git/hooks/*.sample
	@find .git/hooks/ -type f  | while read i; do chmod +x $$i; done

.PHONY: lint
lint:
	@uv run --quiet ruff format src
	@uv run --quiet ruff check src
	@uv sync --quiet

.PHONY: commit
commit: lint
	@uv run --quiet cz commit

.PHONY: build
build: lint
	@uv build

.PHONY: help
help: lint
	@uv run --quiet http-tools --help

.PHONY: version
version: lint
	@uv run --quiet http-tools --version
