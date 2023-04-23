{{
  config(
    materialized='table'
  )
}}

select 
    concat(created_date, '_', product_guid) as key,
    created_date as page_viewed_date, 
    product_guid,
    product_name, 
    sum(page_view) as total_page_views_per_day
from {{ ref('int_product_events') }}
group by 
    page_viewed_date, 
    product_guid,
    product_name 