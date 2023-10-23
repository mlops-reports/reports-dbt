{%- set table_name = "choices" -%}
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

WITH choices AS (

    SELECT
        annotation_id,
        annotation_value ->> 'choices' AS choice,
        annotation_type,
        from_name,
        completion_id,
        project_id,
        task_id,
        completed_by_id
    FROM
        {{ ref('stg_task_completion') }}
    WHERE
        annotation_type = 'choices'
)
SELECT
    *,
    CASE
        WHEN choice = '["Exclude"]' THEN 0 :: INT
        WHEN choice = '["Emergency"]' THEN 1 :: INT
        WHEN choice = '["Normal"]' THEN 2 :: INT
        WHEN choice = '["Non Emergency [No Doctor]"]' THEN 3 :: INT
        WHEN choice = '["Non Emergency [Doctor]"]' THEN 4 :: INT
        ELSE NULL
    END annotation_value_flag
FROM
    choices
