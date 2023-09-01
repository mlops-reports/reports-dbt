{%- set table_name = "choices" -%}
{%- set schema_name = "annotation" -%}
{{ config(
    alias = table_name,
    materialized = 'incremental',
    unique_key = 'annotation_instance_id',
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
    {{ ref('stg_choices') }}
