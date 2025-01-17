# Week 4 Project: snapshot, exposures, and artifacts

## Part 1: dbt snapshots
### 1. Which products had their inventory change from week 3 to week 4?
#### Bamboo, String of Pearls, Monstera, ZZ Plant, Philodendron, Pothos
### 2. Can you use the inventory changes to determine which products had the most fluctuations in inventory? Did we have any items go out of stock in the last 3 weeks?
#### String of Pearls, Pothos, Philodendron, and Monstera experienced the biggest fluctuations in inventory. String of Pearls and Pothos went out of stock within the last 3 weeks. 

## Part 2: modeling challenge
### 1. How are our users moving through the product funnel? 
#### 81% of users that viewed a product page successfully added it to their carts. 62% of users sucessfully checked-out. 
### 2. Which steps in the funnel have largest drop off points?
#### Of the sessions that do not lead to a purchase, 51% drop off after page views and 48% drop off after adding the products to their carts. 

## Part 3: reflection questions
### 3b.How would you go about setting up a production/scheduled dbt run of your project in an ideal state? 
#### I would first build the source tables, run data quality checks (freshness, null, unique tests), and build the downstream models according to the dag. As for the orchestration tool of choice, I'm more familiar with Airflow. The schedules will depend on the business need. If there are high priority dashboards that are viewed in real-time, and cost isn't a huge concern, tables could be schedulded to build on an hourly basis. If cost saving is a concern and the tables are of large volume, I would opt for incremental builds for order/events table, daily builds for dim user or product tables where the data will not be frequently changing, and schedule builds early in the morning. As for metadata, I'm interested in understanding the run-time, volume size, and run results. Tracking the run-time of the builds could help the team measure their optimization efforts. 
