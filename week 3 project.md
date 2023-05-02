# Week 3 Project: data modeling & testing

### What is our overall conversion rate?
#### Answer: 62.46% We define conversion rate as # of unique sessions with a purchase event / # of unique sessions 

<details> 
<summary> sql </summary>

```sql

select 
    round(div0(count(distinct order_guid), count(distinct session_guid))*100,2) as conversion_rate 
from DEV_DB.DBT_PZHANG1195GMAILCOM.FCT_PROD_SESSIONS_ORDERS o
left join DEV_DB.DBT_PZHANG1195GMAILCOM.STG_POSTGRES__products p on p.product_guid = o.product_guid

```
</details>

### What is our overall conversion rate by product?

<details> 
<summary> sql </summary>

```sql
select 
    product_name
    ,round(div0(count(distinct order_guid), count(distinct session_guid))*100,2) as conversion_rate 
from DEV_DB.DBT_PZHANG1195GMAILCOM.FCT_PROD_SESSIONS_ORDERS o
left join DEV_DB.DBT_PZHANG1195GMAILCOM.STG_POSTGRES__products p on p.product_guid = s.new_product_guid
group by product_name
order by conversion_rate desc
```
</details>

|PRODUCT_NAME	       |CONVERSION_RATE|
-------------------- |-------------|
String of pearls     |60.94
Arrow Head	         |55.56
Cactus	             |54.55
ZZ Plant	           |53.97
Bamboo	             |53.73
Rubber Plant	       |51.85
Monstera	           |51.02
Calathea Makoyana	   |50.94
Fiddle Leaf Fig	     |50.00
Majesty Palm	       |49.25
Aloe Vera	           |49.23
Devil's Ivy	         |48.89
Philodendron	       |48.39
Jade Plant	         |47.83
Spider Plant	       |47.46
Pilea Peperomioides	 |47.46
Dragon Tree	         |46.77
Money Tree	         |46.43
Orchid	             |45.33
Bird of Paradise	   |45.00
Ficus	               |42.65
Birds Nest Fern	     |42.31
Pink Anthurium	     |41.89
Boston Fern	         |41.27
Alocasia Polly	     |41.18
Peace Lily	         |40.91
Ponytail Palm	       |40.00
Snake Plant	         |39.73
Angel Wings Begonia	 |39.34
Pothos	             |34.43


### Which products had their inventory change from week 3 to week 3? 
#### Answer: Bamboo, Monstera, Philodendron, Pathos, String of pearls, ZZ plant

