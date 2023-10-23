{% macro grant_schema_privileges(
        schema
    ) %}
    {% set role_name = 'read_only_all' %}
    {% if target.name == 'prod' %}
        GRANT usage
        ON schema {{ schema }} TO GROUP {{ role_name }}
    {% endif %}
{% endmacro %}

{% macro grant_table_privileges(
        schema,
        table
    ) %}
    {% set role_name = 'read_only_all' %}
    {% if target.name == 'prod' %}
        GRANT
    SELECT
        ON {{ schema }}.{{ table }} TO GROUP {{ role_name }}
    {% endif %}
{% endmacro %}

{% macro grant_schema_table_privileges(
        schema,
        table
    ) %}
    {% if target.name == 'prod' %}
GRANT usage
        ON schema {{ schema }} TO GROUP maintenance;
GRANT
    INSERT,
    UPDATE,
    SELECT,
    DELETE
        ON {{ schema }}.{{ table }} TO GROUP maintenance;
GRANT usage
        ON schema {{ schema }} TO GROUP read_only_all;
GRANT
    SELECT
        ON {{ schema }}.{{ table }} TO GROUP read_only_all;
    {% endif %}
{% endmacro %}