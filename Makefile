# Variables
POETRY := poetry
PYTHON := python3
PIP := pip
DBT := pip

# Installs the dependencies
install_dependencies:
	$(PYTHON) -m venv venv;
	$(PIP) install -r requirements.txt;
	$(DBT) deps;

# Removes the existing environment
remove_environment:
	rm -rf .venv;

# Activates poetry environment
activate_environment:
	$(PIP) source/venv/bin/activate


