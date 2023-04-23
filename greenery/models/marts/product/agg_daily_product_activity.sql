{{
  config(
    materialized='table'
  )
}}

select
    concat(po.created_date, '_', po.product_guid) as key, 
    po.product_guid, 
    po.created_date as date, 
    po.product_name, 
    po.total_orders_per_day, 
    pv.total_page_views_per_day
from {{ ref('fct_product_orders')}} po
join {{ ref('fct_page_views')}} pv 
    on po.product_guid = pv.product_guid and po.created_date = pv.page_viewed_date
group by 
    po.created_date,
    po.product_guid, 
    po.product_name, 
    po.total_orders_per_day, 
    pv.total_page_views_per_day