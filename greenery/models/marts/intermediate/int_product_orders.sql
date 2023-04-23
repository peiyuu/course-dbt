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
    o.order_guid, 
    o.promo_id,
    o.user_guid,
    o.address_guid,
    o.created_at:: date as created_date,
    o.order_cost,
    o.shipping_cost,
    o.order_total,
    o.tracking_id,
    o.shipping_service, 
    o.estimated_delivery_at, 
    o.delivered_at, 
    o.order_status,
    i.quantity, 
    datediff('day',estimated_delivery_at, delivered_at) as days_to_deliver,
    case when datediff('day',estimated_delivery_at, delivered_at) > 0 then 'late'
         when datediff('day',estimated_delivery_at, delivered_at) < 0 then 'early'
         when datediff('day',estimated_delivery_at, delivered_at) = 0 then 'on time' 
         else 'pending'
    end as product_delivered
from {{ ref('stg_postgres__products')}} p
join {{ ref('stg_postgres__order_items')}} i on p.product_guid = i.product_guid
join {{ ref('stg_postgres__orders')}} o on o.order_guid = i.order_guid
group by
    p.product_guid, 
    p.product_name, 
    p.product_price,
    p.inventory, 
    o.order_guid, 
    o.promo_id,
    o.user_guid,
    o.address_guid,
    o.created_at, 
    o.order_cost,
    o.shipping_cost,
    o.order_total,
    o.tracking_id,
    o.shipping_service, 
    o.estimated_delivery_at, 
    o.delivered_at,
    o.order_status,
    i.quantity