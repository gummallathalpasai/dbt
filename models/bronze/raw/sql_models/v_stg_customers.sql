{{config(
    materialized='incremental',
    file_format='delta'
    uniue_key='#value if any'
    schema='bronze'
    incremntal_strategy='append',
    post_hook = appl)}}


{%- set yaml_metadata -%}
source_model: 'raw_customers'
hashed_columns:
    CUSTOMER_HK:
    - Customerid

    CUSTOMER_HASHDIFF:
        is_hashdiff: true
        columns:
            - Customerid
            - CustomerName
            - MobileNumber
            - Gender
            - Age
            - Address
            - City
            - State
            - ZipCode
            - Load_DTS

{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     null_columns=null_columns,
                     hashed_columns=hashed_columns,
                     ranked_columns=ranked_columns) }}