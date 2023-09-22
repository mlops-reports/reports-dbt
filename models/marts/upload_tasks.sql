{%- set table_name = "upload_tasks" -%}
{%- set schema_name = "annotation" -%}
{{ config(
    alias = table_name,
    materialized = 'incremental',
    unique_key = 'report_id',
    merge_update_columns = ['report_id', 'report_original', 'report_length', 'patient_report_count'],
    schema = schema_name,
    post_hook = grant_schema_table_privileges(
        schema_name,
        table_name
    ),
    tags = [schema_name]
) }}

WITH general_tb AS (

    SELECT
        *,
        COUNT(*) over (
            PARTITION BY patient_no
        ) AS patient_report_count,
        LENGTH(report_original) - LENGTH(REPLACE(report_original, ' ', '')) + 1 AS report_length,
        DENSE_RANK() over (
            PARTITION BY patient_no
            ORDER BY
                protocol_no ASC
        ) AS protocol_no_ranking
    FROM
        {{ ref('reports') }}
)
SELECT
    report_id,
    patient_no,
    protocol_no,
    report_original,
    NULL as report_prompted,
    report_length,
    patient_report_count
FROM
    general_tb
WHERE
    protocol_no_ranking = 1
