{% macro grant_schema_privileges(
        schema
    ) %}
    {% set role_name = 'read_only_{{ schema }}' %}
    {% if target.name == 'prod' %}
        GRANT usage
        ON schema {{ schema }} TO GROUP {{ role_name }}
    {% endif %}
{% endmacro %}

{% macro grant_table_privileges(
        schema,
        table
    ) %}
    {% set role_name = 'read_only_{{ schema }}' %}
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
    {% set role_name = 'read_only_{{ schema }}' %}
    {% if target.name == 'prod' %}
        GRANT usage
        ON schema {{ schema }} TO GROUP {{ role_name }};
GRANT
    SELECT
        ON {{ schema }}.{{ table }} TO GROUP {{ role_name }}
    {% endif %}
{% endmacro %}
