source venv/bin/activate
source .env

export DBT_HOST=$DBT_HOST
export DBT_USERNAME=$DBT_USERNAME
export DBT_PASSWORD=$DBT_PASSWORD
export DBT_DB_NAME=$DBT_DB_NAME

dbt run --select tasks+ --target prod 
dbt run --select stg_choices+ --target prod 
dbt run --select stg_labels+ --target prod 
dbt run --select stg_reports+ --target prod 

deactivate