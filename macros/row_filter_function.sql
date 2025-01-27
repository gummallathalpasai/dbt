{% macro row_filter_function() %}

CREATE OR REPLACE FUNCTION {{target.schema}}.row_filter_function(col STRING)
IF (current_catalog == dev & is_member('ADgroup')),true,col!='value'
IF (current_catalog == stg & is_member('ADgroup')),true,col!='value'
IF (current_catalog == prod & is_member('ADgroup')),true,col!='value'

{% end macro %}