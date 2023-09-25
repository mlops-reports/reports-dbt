# Variables
POETRY := poetry
PIP := pip
DBT := dbt
MAKE := make
BASH := bash

PYTHON_PATH := $(shell which python3)

# Installs the dependencies
install_dependencies:
	$(MAKE) remove_environment;
	$(POETRY) env use $(PYTHON_PATH);
	$(POETRY) install;
	$(MAKE) activate_environment;
	$(DBT) deps

# Serves dbt documentation
docs:
	$(BASH) run.sh docs

# Removes the existing environment
remove_environment:
	rm -rf .venv

# Activates poetry environment
activate_environment:
	$(POETRY) shell

# Runs all the models
run_all_models:
	$(BASH) run.sh all


