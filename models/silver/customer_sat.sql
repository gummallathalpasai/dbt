{{config(
    materialized='incremental',
    file_format='delta'
    uniue_key='#value if any'
    schema='silver'
    incremntal_strategy='append')}}

{%- set yaml_metadata -%}
source_model: "v_stg_customers"
src_pk: "CUSTOMER_HK"
src_hashdiff: 
  source_column: "CUSTOMER_HASHDIFF"
  alias: "HASHDIFF"
src_payload:
  - "Customerid"
  - "CustomerName"
  - "MobileNumber"
  - "Gender"
  - "Age"
  - "Address"
  - "City"
  - "State"
  - "ZipCode"
  - "Load_DTS"

src_eff: "Load_DTS"
src_ldts: "Load_DTS"
src_source: "source"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(src_pk=metadata_dict["src_pk"],
                   src_hashdiff=metadata_dict["src_hashdiff"],
                   src_payload=metadata_dict["src_payload"],
                   src_eff=metadata_dict["src_eff"],
                   src_ldts=metadata_dict["src_ldts"],
                   src_source=metadata_dict["src_source"],
                   source_model=metadata_dict["source_model"])   }}