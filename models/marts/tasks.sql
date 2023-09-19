{%- set table_name = "tasks" -%}
{%- set schema_name = "annotation" -%}
{{ config(
    alias = table_name,
    materialized = 'incremental',
    unique_key = 'id',
    schema = schema_name,
    post_hook = grant_schema_table_privileges(
        schema_name,
        table_name
    ),
    tags = [schema_name]
) }}

WITH tasks AS (

    SELECT
        *
    FROM
        {{ source(
            'label_studio',
            'task'
        ) }}
)
select * from tasks