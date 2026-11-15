select * from sales limit 10;

--unique customers
select  count(distinct customer_id) from sales;

--How many transactions does each customer make?
select customer_id, sum(purchase_amount) from sales
group by customer_id limit 10; 

--What is the average order value for each customer?
select customer_id, avg(purchase_amount) from sales
group by customer_id limit 10;

--Who are the top 10 customers by revenue?
select customer_id, sum(purchase_amount) as max_revenue  from sales
group by customer_id
order by max_revenue desc
limit 10;

--How many purchases did this customer make?
SELECT customer_id,
       COUNT(*) AS purchase_count
FROM sales
GROUP BY customer_id
ORDER BY purchase_count DESC
LIMIT 10;

--Which customers have the highest average order value?

SELECT customer_id,
       avg(purchase_amount) AS avg_order
FROM sales
GROUP BY customer_id
ORDER BY avg_order DESC
LIMIT 10;



--How many customers have a subscription?
select count(*) from sales
where subscription_status = 'Yes';


select subscription_status,sum(purchase_amount) as rev_by_sub_status
from sales
group by subscription_status
order by rev_by_sub_status;

--Do subscribed customers have a higher average order value?
--Answer is NO
select subscription_status, avg(purchase_amount) from sales
group by subscription_status;


--Do subscribed customers purchase more frequently?
--Answer is NO
select subscription_status,
count(*) as purchase_count
from sales
group by  subscription_status;