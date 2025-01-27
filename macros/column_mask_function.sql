{% macro column_mask_function() %}
{% set sql %}
    CREATE OR REPLACE FUNCTION {{target.schema}}.column_mask_function(col STRING)
    RETURN CASE
    WHEN (current_catalog()=='dev_env') THEN
        CASE
        WHEN is_member('ADgroup/service pricipal') THEN col
        THEN is_member('restricted ADgroup') THEN mask(col, 'x','x','x','x')
    WHEN (current_catalog()=='stg_env') THEN
        CASE
        WHEN is_member('ADgroup/service pricipal') THEN col
        THEN is_member('restricted ADgroup') mask(col, 'x','x','x','x')
    WHEN (current_catalog()=='prod_env') THEN
        CASE
        WHEN is_member('ADgroup/service pricipal') THEN col
        THEN is_member('restricted ADgroup') mask(col, 'x','x','x','x')
{% endset %}
{% end macro %}