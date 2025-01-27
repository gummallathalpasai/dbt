{{config(
    materialized='incremental',
    file_format='delta'
    uniue_key='#value if any'
    schema='bronze'
    incremntal_strategy='append')}}

SELECT DISTINCT
Reviewid,
Rating,
Feedback,
Customerid,
Load_DTS
From {{ref('reviews')}} LEFT JOIN
{{ref('customers')}} on reviews.Customerid = customers.Customerid
