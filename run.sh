source .venv/bin/activate
source .env

MODEL=${1:-all}

export DBT_HOST=$DBT_HOST
export DBT_USERNAME=$DBT_USERNAME
export DBT_PASSWORD=$DBT_PASSWORD
export DBT_DB_NAME=$DBT_DB_NAME

if [ $MODEL == "all" ]
then
    dbt run --select tag:annotation_input+ --target prod 
    dbt run --select tag:annotation_output+ --threads 1 --target prod 
elif [ $MODEL == "docs" ]
then
    dbt docs generate
    dbt docs serve
else
    dbt run --select $MODEL --target prod 
fi

deactivate