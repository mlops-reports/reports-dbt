## Project Setup and Usage Guide

### Environment Setup
```
# Remove existing environment and install dependencies
make remove_environment
make install_dependencies
```

This will:
1. Remove any existing virtual environment
2. Create a new Poetry environment using Python 3
3. Install all project dependencies
4. Activate the environment
5. Install dbt dependencies

### Required Environment Variables
Set the following environment variables before running the project:
```
DBT_HOST=<database_host>
DBT_USERNAME=<database_username>
DBT_PASSWORD=<database_password>
DBT_DB_NAME=<database_name>
```

## Running Models
### Run Specific Models by Tag
```
bash run.sh 'tag:annotation_output+ --threads 1'
```

### Run All Models
```
make run_all_models
```

### Additional Commands
```
# Activate the Poetry environment
make activate_environment

# Remove the virtual environment
make remove_environment
```

## Project Structure
The project uses:
* Poetry for dependency management
* dbt for data transformation
* Makefile for common operations