{{config(
    materialized='view/materialized_view',
    file_format='delta',
    uniue_key='#value if any',
    schema='gold')}}