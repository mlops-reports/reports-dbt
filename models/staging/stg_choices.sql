{%- set table_name = "stg_choices" -%}
{%- set schema_name = "annotation" -%}
{{ config(
    schema = schema_name,
    alias = table_name,
    tags = ["annotations"]
) }}

WITH choices AS (

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
),
with_text AS (
    SELECT
        annotation_data ->> 'id' AS annotation_instance_id,
        id AS annotation_id,
        -- annotation_data ->> 'type' AS annotation_type,
        CASE
            WHEN annotation_data ->> 'type' = 'choices' THEN (
                annotation_data ->> 'value'
            ) :: json ->> 'choices'
            WHEN annotation_data ->> 'type' = 'labels' THEN (
                annotation_data ->> 'value'
            ) :: json ->> 'text'
            ELSE NULL
        END annotation_value,
        project_id,
        task_id,
        completed_by_id
    FROM
        choices
    WHERE
        annotation_data ->> 'type' = 'choices'
)
SELECT
    annotation_instance_id,
    annotation_id,
    CASE
        WHEN annotation_value = '["Emergency"]' THEN 0 :: INT
        WHEN annotation_value = '["Normal"]' THEN 1 :: INT
        WHEN annotation_value = '["Non Emergency [No Doctor]"]' THEN 3 :: INT
        WHEN annotation_value = '["Non Emergency [Doctor]"]' THEN 2 :: INT
        ELSE NULL
    END annotation_value_flag,
	annotation_value,
	 CASE
        WHEN annotation_value = '["Exclude"]' THEN TRUE :: BOOLEAN
        ELSE FALSE :: BOOLEAN
    END AS exclude,
    project_id,
    task_id,
    completed_by_id
FROM
    with_text
