{% macro apply_row_mask_filter(tbls,col) %}

{% for tbl in tbls %}
        {% set sql %}
            ALTER TABLE {{tbl}} SET MASK row_filter_function ON {{col}};
        {% end set %}
    {% end for %}
{% end macro %}