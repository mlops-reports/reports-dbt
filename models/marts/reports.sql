{%- set table_name = "reports" -%}
{%- set schema_name = "annotation" -%}
{{ config(
    alias = table_name,
    materialized = 'incremental',
    unique_key = 'protocol_no',
    schema = schema_name,
    post_hook = grant_schema_table_privileges(
        schema_name,
        table_name
    ),
    tags = [schema_name]
) }}

SELECT
    "HASTA_NO" as patient_no,
    "PROTOKOL_NO" as protocol_no,
    "AD_SOYAD" as full_name,
    "ACIKLAMA" as report
FROM
    {{ ref('stg_reports') }}
