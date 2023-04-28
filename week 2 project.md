# Week 2 Project: data modeling & testing

### What is our user repeat rate?
#### Answer: 79.84% We calculate repeat users as users who have ordered 2 or more times. 

<details> 
<summary> sql </summary>

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
</details>

#### What are good indicators of a user who will likely purchase again? 
Good indicators of a user who will purchase again: 
- High engagement with the website. Browses product catalog often
- Refers product to someone they know
- High customer lifetime value
- Received product on time
- Already a repeat customer
### What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
Indicators of a user who are likely not to purchase again:
- Product dissatification - returned orders, negative feedback 
- Delivery dissatisfaction - late delivery, order never arrived, damaged product
- Last purchase was a long time ago 
- Users who have churned - account inactivity and doesn't frequent the product catalog
If I had more data, I want to take a look at user feedback and their customer satisfaction scores. Additionally, I want to take a look at the user journey of users who have made one purchase and never made a purchase again. 
### Explain the product mart models you added. Why did you organize the models in the way you did?
#### 
I added an intermediate table to join orders to products to measure product performance by revenue/total orders. I also joined product to events to measure the website engagement level of each product i.e. which product has the highest page views. Then, I built daily fact tables to view product activity on a day to day basis. Becase these fact tables are on a low granularity (day), we could aggregate and build summary tables for other time periods (monthly, quarterly, annual). I leveraged the fact tables to create an aggregated daily summary where analysts could query to determine whethere there is a corelation between page views and order count. 

### What assumptions are you making about each model? (i.e. why are you adding each test?)
Answer: I concatenated the date and product_guid to create a primary key for the fact tables. Assuming that the keys are unique, I added tests on the model layer to verify this assumption. On the staging layer, I added tests to verify the primary id's for the tables are not null. 
 
### Which products had their inventory change from week 1 to week 2? 
#### Answer: Monstera, Philodendron, Pothos, and String of pearls
