.ONESHELL:
SHELL := /bin/bash  # Ensure the script runs in bash

.DEFAULT_GOAL := run

PYTHON = venv/bin/python
PIP = venv/bin/pip

venv/bin/activate:  
	python3 -m venv venv
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt
	$(PIP) install -r requirements.dev.txt
	touch venv/bin/activate  # Ensures Make sees this as a completed step

venv: venv/bin/activate

run: venv
	$(PYTHON) manage.py runserver 0.0.0.0:8000

migrate: venv
	$(PYTHON) manage.py migrate

lint: venv
	$(PYTHON) -m flake8 .

test: venv
	$(PYTHON) -m pytest

clean:
	rm -rf __pycache__
	rm -rf venv
