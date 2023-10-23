{%- set table_name = "report_classifications" -%}
{%- set schema_name = "annotation" -%}
{{ config(
    alias = table_name,
    materialized = 'incremental',
    unique_key = 'annotation_id',
    schema = schema_name,
    post_hook = grant_schema_table_privileges(
        schema_name,
        table_name
    ),
    tags = [schema_name]
) }}

WITH report_classifications AS (

    SELECT
        c.annotation_id,
        c.choice,
        t.data ->> 'text' as translated_text,
        c.from_name,
        c.completion_id,
        c.project_id,
        c.task_id
    FROM
        {{ ref('choices') }} as c
    LEFT JOIN {{ ref('tasks') }} as t
    ON c.task_id = t.id
)
SELECT
    *
FROM
    report_classifications
