{% macro apply_column_mask_filter(tbl_cols_tuples) %}
{% for tuple in tbl_col_tuples %}
    {% set tbl = tuple[0] %}
    {% set cols = tuple[1] %}
    {% for col in cols %}
        {% set sql %}
            ALTER TABLE {{tbl}} ALTER COLUMN {{col}} SET MASK column_mask_function;
        {% end set %}
    {% end for %}
{% end macro %}