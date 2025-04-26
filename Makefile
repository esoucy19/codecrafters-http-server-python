.PHONY: all clean test check review format
SHELL := /bin/bash
SRC := $(shell find ./app -name *.py) $(shell find ./src -name *.py) $(shell find ./test -name *.py)
PYTHONPATH := ./app:./src:./test

format:
	pipenv run ruff check --select 'I' --fix $(SRC) && \
	pipenv run ruff format $(SRC)

check:
	pipenv run mypy $(SRC)
	pipenv run ruff check $(SRC)

test:
	pipenv run python -m pytest
