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
    tags = [schema_name, "annotation_output"]
) }}

WITH tasks AS (

    SELECT
        *,
        ('https://label.drgoktugasci.com/projects/' || project_id || '/data?task=' || id) as report_link
    FROM
        {{ source(
            'label_studio',
            'task'
        ) }}
)
select * from tasks