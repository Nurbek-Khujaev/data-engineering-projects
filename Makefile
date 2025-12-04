# ======== GLOBAL SETTINGS ========
PYTHON = python3
VENV = venv

# ======== SETUP ========
setup:
	$(PYTHON) -m venv $(VENV)
	. $(VENV)/bin/activate && pip install --upgrade pip
	. $(VENV)/bin/activate && pip install -r requirements.txt

# ======== DATABASE ========
start-db:
	brew services start postgresql@17

stop-db:
	brew services stop postgresql@17

psql:
	psql -U dq -d dq

# ======== LINT & TEST ========
lint:
	. $(VENV)/bin/activate && black scripts/ --line-length 88

test:
	. $(VENV)/bin/activate && pytest -v

# ======== DATA ========
clean-data:
	rm -rf part_*/data/raw/*
	rm -rf part_*/data/temp/*
	rm -rf part_*/data/processed/*
	rm -rf part_*/data/output/*

# ======== HELP ========
help:
	@echo "Available commands:"
	@echo "  make setup        → setup virtual environment and install dependencies"
	@echo "  make start-db     → start PostgreSQL service"
	@echo "  make stop-db      → stop PostgreSQL service"
	@echo "  make psql         → open psql shell"
	@echo "  make lint         → run code formatter"
	@echo "  make test         → run tests"
	@echo "  make clean-data   → clear all data folders"

