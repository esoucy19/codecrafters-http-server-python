.PHONY: all clean test check review format watch
SHELL := /bin/bash
SRC_DIRS = ./app ./src ./test
SRC = $(shell find ./app -name *.py) $(shell find ./src -name *.py) $(shell find ./test -name *.py)
PYTHONPATH := ./app:./src:./test
PR := pipenv --quiet run

format:
	@$(PR) ruff check --select 'I' --fix $(SRC_DIRS) && \
	@$(PR) ruff format $(SRC_DIRS)

check:
	@$(PR) mypy $(SRC_DIRS)
	#@$(PR) ruff check --output-format=concise $(SRC_DIRS)

test:
	@$(PR) python -m pytest

watch:
	@while inotifywait -r '.' -e modify 1>/dev/null 2>&1; do \
  		make -i -s check; \
	done
