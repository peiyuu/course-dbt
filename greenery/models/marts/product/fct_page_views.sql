{{
  config(
    materialized='table'
  )
}}

with prod_sessions as (
  select * from {{ ref('fct_prod_sessions_orders') }}
) 

, products as (
  select * from {{ ref('stg_postgres__products') }}
)

, final as (
  select 
      s.session_created_at::date as page_viewed_at
      , s.product_guid
      , p.product_name
      , sum(s.page_view) as total_page_views_per_day
  from prod_sessions s
  join products p on p.product_guid = s.product_guid
  group by 
      page_viewed_at
      , s.product_guid
      , p.product_name 
) 

select 
    {{ dbt_utils.generate_surrogate_key([
            'page_viewed_at', 
            'product_guid',
        ]) 
    }} as key 
    , *
from final
