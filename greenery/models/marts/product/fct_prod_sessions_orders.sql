{{
  config(
    materialized='table'
  )
}}

with prod_sessions as (
  select * from {{ ref('int_prod_sessions_agg') }}
)

, orders as (
    select * from {{ ref('fct_orders') }}
)

, final as (
    select
        p.session_guid
        , p.order_guid
        , p.created_at as session_created_at
        , p.page_view
        , p.add_to_cart
        , p.checkout 
        , p.package_shipped
        , o.user_guid
        , o.created_at as order_created_at
        , o.order_cost
        , o.shipping_cost
        , o.order_total
        , o.tracking_id
        , o.shipping_service
        , o.estimated_delivery_at
        , o.delivered_at 
        , o.order_status
        , o.quantity
        , o.discount
        , o.promo_status
        , coalesce(o.product_guid, p.product_guid) as product_guid
    from prod_sessions p
    left join orders o on o.order_guid = p.order_guid
)

select
  -- {{ dbt_utils.generate_surrogate_key(['product_guid',  'order_guid'])}} as key
  -- ,
  * 
from final