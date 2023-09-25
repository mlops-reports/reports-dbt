{%- set table_name = "textareas" -%}
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

WITH textareas AS (

    SELECT
        annotation_id,
        annotation_value ->> 'text' AS text,
        annotation_type,
        from_name,
        completion_id,
        project_id,
        task_id,
        completed_by_id
    FROM
        {{ ref('stg_task_completion') }}
    WHERE
        annotation_type = 'textarea'
)
SELECT
    *
FROM
    textareas
