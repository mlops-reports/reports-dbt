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
        c.annotation_value_flag,
        t.data ->> 'text' as translated_text,
        t.data ->> 'patient_no' as patient_no,
        t.data ->> 'report_length' as report_length,
        c.from_name,
        c.project_id,
        c.task_id
    FROM
        {{ ref('choices') }} as c
    LEFT JOIN {{ ref('tasks') }} as t
    ON c.task_id = t.id
    ORDER BY task_id ASC
)
SELECT
    *
FROM
    report_classifications

