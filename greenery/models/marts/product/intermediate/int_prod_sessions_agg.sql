{{
  config(
    materialized='table'
  )
}}

{%- set event_types = dbt_utils.get_column_values(
    table = ref('stg_postgres__events'),
    column = 'event_type'
    )
%}

with events as (
  select * from {{ ref('stg_postgres__events') }}
)

, final as (
    select 
        product_guid
        , session_guid
        , order_guid
        , created_at
         {%- for event_type in event_types %}
        , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }} 
        {%- endfor %}
    from events
    group by
        product_guid
        , session_guid
        , order_guid
        , created_at
)

select * from final 