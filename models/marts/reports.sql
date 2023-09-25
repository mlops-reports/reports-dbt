{%- set table_name = "reports" -%}
{%- set schema_name = "annotation" -%}
{{ config(
    alias = table_name,
    materialized = 'table',
    unique_key = 'report_id',
    schema = schema_name,
    post_hook = grant_schema_table_privileges(
        schema_name,
        table_name
    ),
    tags = [schema_name]
) }}

SELECT
    *
FROM
    {{ ref('stg_reports') }}
