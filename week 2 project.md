# What is our user repeat rate?
We calculate repeat users as users who have ordered 2 or more times. 
Answer: 79.84%
    
```sql
with repeat_users as (
select 
     user_guid
from DEV_DB.DBT_PZHANG1195GMAILCOM.STG_POSTGRES__ORDERS 
group by user_guid
having count (distinct order_guid) >= 2)
 
select 
     round(div0(count(user_guid), (select count(distinct user_guid) from DEV_DB.DBT_PZHANG1195GMAILCOM.STG_POSTGRES__ORDERS))*100,2)
from repeat_users
```

# What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
    
    
# Explain the product mart models you added. Why did you organize the models in the way you did?
Answer:

# Dag
<img width="1337" alt="Screenshot 2023-04-23 at 2 51 45 PM" src="https://user-images.githubusercontent.com/35935915/233859544-68757595-91b8-46eb-a88a-2d1b448d6c14.png">

# What assumptions are you making about each model? (i.e. why are you adding each test?)
    Answer: 
 
# Which products had their inventory change from week 1 to week 2? 
Answer: Pathos and String of Pearls
