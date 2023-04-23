{{
  config(
    materialized='table'
  )
}}

select
    concat(created_date, '_', product_guid) as key,
    created_date, 
    product_guid, 
    product_name,
    count(distinct order_guid) as total_orders_per_day
from {{ref('int_product_orders')}} 
group by 
    created_date, 
    product_guid, 
    product_name
