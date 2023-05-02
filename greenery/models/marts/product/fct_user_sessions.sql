{{
  config(
    materialized='table'
  )
}}

with user_sessions_agg as (
  select * from {{ ref('int_user_sessions_agg') }}
)

, users as (
    select * from {{ ref('dim_users_info') }}
)

, final as (
    Select
         u.user_guid
        , u.first_name 
        , u.last_name 
        , concat(u.first_name, ' ', u.last_name) as full_name
        , u.email
        , u.phone_number
        , u.created_at
        , u.updated_at
        , u.address_guid 
        , u.address 
        , u.state
        , u.zip_code 
        , u.country
        , s.session_guid
        , s.event_count
        , s.first_session_event
        , s.last_session_event
        , s.page_view
        , s.add_to_cart
        , s.checkout 
        , s.package_shipped
    From user_sessions_agg s
    left Join users u on s.user_guid = u.user_guid
)

select * from final