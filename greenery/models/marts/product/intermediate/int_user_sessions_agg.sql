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
        session_guid
        , user_guid
        , count(event_guid) as event_count
        , min(created_at) as first_session_event
        , max(created_at) as last_session_event
        {%- for event_type in event_types %}
        , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}
        {%- endfor %}
    from events
    group by 
        session_guid
        , user_guid
)

select * from final