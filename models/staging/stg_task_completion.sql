{%- set table_name = "stg_task_completion" -%}
{%- set schema_name = "annotation" -%}
{{ config(
    schema = schema_name,
    alias = table_name,
    tags = ["annotations", "annotation_output"]
) }}

WITH task_completion AS (

    SELECT
        id,
        jsonb_array_elements("result") :: json AS annotation_data,
        project_id,
        task_id,
        completed_by_id
    FROM
        {{ source(
            'label_studio',
            'task_completion'
        ) }}
)
SELECT
    annotation_data ->> 'id' AS annotation_id,
    (annotation_data ->> 'value')::json AS annotation_value,
    annotation_data ->> 'type' AS annotation_type,
    annotation_data ->> 'from_name' AS from_name,
    id as completion_id,
    project_id,
    task_id,
    completed_by_id
FROM
    task_completion
