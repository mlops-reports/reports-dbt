# Variables
POETRY := poetry
PYTHON := python3
PIP := pip
DBT := pip

# Installs the dependencies
install_dependencies:
	rm -rf .venv;
	$(PYTHON) -m venv venv;
	$(PIP) install -r requirements.txt;
	$(DBT) deps;

# Activates poetry environment
activate_environment:
	$(PIP) source/venv/bin/activate


