{%- set table_name = "stg_reports" -%}
{%- set schema_name = "staging" -%}
{{ config(
    materialized = 'incremental',
    unique_key = 'report_id',
    schema = schema_name,
    alias = table_name,
    tags = ["annotations", "annotation_input"]
) }}

WITH reports AS (

    SELECT
       *
    FROM
        {{ source(
            'raw_data',
            'reports'
        ) }}
)
SELECT
   *
FROM
    reports
