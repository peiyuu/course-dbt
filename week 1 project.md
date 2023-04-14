# 1. How many users do we have? 
Answer: 130
    
```sql
select 
  count(distinct user_guid) as user_count
from dbt_pzhang1195gmailcom.stg_postgres__users
```

# 2. On average, how many orders do we receive per hour?
Answer: 7.52
    
```sql
with orders_per_hour as (
  select
      date_Trunc('hour',created_at) as hour,
      count(distinct order_guid) as order_count
   from dbt_pzhang1195gmailcom.stg_postgres__orders
   group by date_Trunc('hour',created_at)
  ) 

select 
    round(avg(order_count),2)
from orders_per_hour
```
    
# 3. On average, how long does an order take from being placed to being delivered?
Answer: 3.89 days
    
```sql    
with order_time as (
select
  datediff('day',created_at, delivered_at) as time_diff
from dbt_pzhang1195gmailcom.stg_postgres__orders
where delivered_at is not null
) 

select 
  round(avg(time_diff),2)
from order_time
```
 

# 4. How many users have only made one purchase? Two purchases? Three+ purchases? Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
    Answer: 
        - 1 purchase = 25 
        - 2 purchases = 28
        - 3+ purchases = 71
    
```sql
with orders as (
select
  user_guid,
  count(distinct order_guid) as order_count
from dbt_pzhang1195gmailcom.stg_postgres__orders
group by user_guid
) 

select     
    case when order_count = 1 then '1'
         when order_count = 2 then '2'
         else '3+'
         end as order_bin, 
    count(distinct user_guid) as user_count
from orders 
group by order_bin  
```

# 5. On average, how many unique sessions do we have per hour?
Answer: 16.33
```sql    
with sessions_per_hour as (
 select 
    date_trunc('hour', created_at) as hour, 
    count(distinct session_guid) as session_count
 from dbt_pzhang1195gmailcom.stg_postgres__events
 group by date_trunc('hour', created_at) 
)

select 
    round(avg(session_count),2)
 from sessions_per_hour
```
