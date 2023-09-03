{%- set table_name = "stg_labels" -%}
{%- set schema_name = "annotation" -%}
{{ config(
    schema = schema_name,
    alias = table_name,
    tags = ["annotations"]
) }}

WITH labels AS (
SELECT
	id,
	jsonb_array_elements("result")::json AS annotation_data,
	project_id,
	task_id,
	completed_by_id
FROM
	task_completion tc)
SELECT
    annotation_data ->> 'id' AS annotation_instance_id,
    id as annotation_id,
	-- annotation_data ->> 'type' AS annotation_type,
	CASE
		WHEN annotation_data ->> 'type' = 'choices' THEN (annotation_data ->> 'value')::json ->> 'choices'
		WHEN annotation_data ->> 'type' = 'labels' THEN (annotation_data ->> 'value')::json ->> 'text'
		ELSE NULL
	END annotation_value,
	CASE
		WHEN annotation_data ->> 'type' = 'labels' THEN (annotation_data ->> 'value')::json ->> 'labels'
		ELSE NULL
	END labels,
	project_id,
	task_id,
	completed_by_id
FROM
	labels
WHERE 
    annotation_data ->> 'type' = 'labels'

