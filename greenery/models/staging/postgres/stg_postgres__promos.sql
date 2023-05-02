{{ 
    config(
        materialized='table'
    )
}}

with source as (
    select * from {{source('postgres','promos')}}
)

, renamed_recast as (
    select
        lower(promo_id) as promo_id
        , discount
        , status as promo_status
    from source
)

select * from renamed_recast