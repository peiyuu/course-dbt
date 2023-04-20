--  define config as table or view 

{{ 
    config(
        materialized='table'
    )
}}

-- create cte to reference source TABLE
with source as (
    select * from {{source('postgres','order_items' )}}
)

, renamed_recast as (
    select 
        order_id as order_guid
        , product_id as product_guid
        , quantity
    from source
)

select * from renamed_recast