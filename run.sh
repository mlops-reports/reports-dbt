source .venv/bin/activate
source .env

MODEL=${1:-all}
ENV=${2:-prod}

export DBT_HOST=$DBT_HOST
export DBT_USERNAME=$DBT_USERNAME
export DBT_PASSWORD=$DBT_PASSWORD
export DBT_DB_NAME=$DBT_DB_NAME


if [ $MODEL == "all" ] || [ $MODEL == "report_classifications" ]
then
    # create a snaphot of the report_classifications table
    dbt snapshot --select report_classifications_snapshot --target $ENV 
fi

if [ $MODEL == "all" ]
then
    # run the given models
    dbt run --select tag:annotation_input+ --target $ENV 
    dbt run --select tag:annotation_output+ --threads 1 --full-refresh --target $ENV 
elif [ $MODEL == "docs" ]
then
    # generate docs
    dbt docs generate
    dbt docs serve
else
    # run the given model
    dbt run --select $MODEL --target $ENV 
fi

deactivate