{{
  config(
    materialized='table'
  )
}}

with orders as (
  select * from {{ ref('stg_postgres__orders') }}
)

, order_items as (
  select * from {{ ref('stg_postgres__order_items') }}
)

, promos as (
    select * from {{ ref('stg_postgres__promos') }}
)

, final as (
    select
        o.order_guid 
        , o.user_guid
        , o.created_at 
        , o.order_cost
        , o.shipping_cost
        , o.order_total
        , o.tracking_id
        , o.shipping_service
        , o.estimated_delivery_at
        , o.delivered_at 
        , o.order_status
        , order_items.product_guid
        , order_items.quantity
        , p.discount
        , p.promo_status
    from orders o
    left join order_items on o.order_guid = order_items.order_guid
    left join promos p on p.promo_id = o.promo_id
) 

select * from final