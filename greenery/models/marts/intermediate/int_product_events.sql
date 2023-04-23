{{
  config(
    materialized='table'
  )
}}

select 
    p.product_guid,
    p.product_name, 
    p.product_price,
    p.inventory, 
    e.event_guid, 
    e.user_guid, 
    e.created_at:: date as created_date,
    e.page_url, 
    e.order_guid, 
    sum(case when e.event_type = 'checkout' then 1 else 0 end) as check_out, 
    sum(case when e.event_type = 'page_view' then 1 else 0 end) as page_view,
    sum(case when e.event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart,
    sum(case when e.event_type = 'package_shipped' then 1 else 0 end) as package_shipped
from {{ ref('stg_postgres__products') }} p
join {{ ref('stg_postgres__events') }} e on p.product_guid = e.product_guid 
group by 
    p.product_name, 
    p.product_price,
    p.inventory, 
    e.event_guid, 
    e.user_guid, 
    e.created_at, 
    e.page_url, 
    e.order_guid,
    p.product_guid
