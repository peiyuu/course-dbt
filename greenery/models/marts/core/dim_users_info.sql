{{
  config(
    materialized='table'
  )
}}

with users as (
  select * from {{ ref('stg_postgres__users') }}
)

, addresses as (
    select * from {{ ref('stg_postgres__addresses') }}
)

, final as (
    select
        u.user_guid
        , u.first_name 
        , u.last_name 
        , concat(u.first_name, ' ', u.last_name) as full_name
        , u.email
        , u.phone_number
        , u.created_at
        , u.updated_at
        , a.address_guid 
        , a.address 
        , a.state
        , a.zip_code 
        , a.country
    from users u
    left join addresses a on u.address_guid = a.address_guid
) 

select * from final