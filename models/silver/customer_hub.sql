{{config(
    materialized='incremental',
    file_format='delta'
    uniue_key='#value if any'
    schema='silver'
    incremntal_strategy='append')}}

{%- set source_model = "v_stg_customers"   -%}
{%- set src_pk = "CUSTOMER_HK"          -%}
{%- set src_nk = "Customerid"          -%}
{%- set src_ldts = "Load_DTS"      -%}
{%- set src_source = "source"    -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                   src_source=src_source, source_model=source_model) }}