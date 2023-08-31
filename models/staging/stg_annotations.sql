{%- set table_name = "stg_annotations" -%}
{%- set schema_name = "reports_data" -%}
{{ config(
    materialized = 'incremental',
    unique_key = 'id',
    schema = schema_name,
    alias = table_name,
    tags = ["annotations"]
) }}

WITH stg_project_datasets AS (

    SELECT
        *
    FROM
        {{ source(
            'public',
            'tasks_annotationdraft'
        ) }}
)
SELECT
    *
FROM
    stg_project_datasets
