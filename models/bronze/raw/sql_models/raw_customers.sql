{{config(
    materialized='incremental',
    file_format='delta'
    uniue_key='#value if any'
    schema='bronze'
    incremntal_strategy='append')}}

SELECT DISTINCT
Customerid,
CustomerName,
MobileNumber,
Gender,
Age,
Address,
City,
State,
ZipCode,
Customerid,
Load_DTS
From {{ref('customers')}}
