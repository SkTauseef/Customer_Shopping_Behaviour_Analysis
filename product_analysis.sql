select * from sales limit 50;

select * from products limit 50;


--How many customers belong to each age group?
select age_group,count(*) from sales
group by age_group
order by age_group asc;

--Which age group generates the most revenue?
select age_group,sum(purchase_amount) as rev_by_age from sales
group by age_group
order by rev_by_age desc;

--Which age group has the highest average purchase amount?

select age_group,avg(purchase_amount) as avg_by_age from sales
group by age_group
order by avg_by_age desc;


--Which category generates the most revenue?
select category, sum(purchase_amount)
from sales
group by category
order by category desc;

--Which category sells the most units?
select category, sum(quantity) as total_quantity
from sales
group by category
order by total_quantity desc;

--Which category has the highest number of transactions?
select category, count(transaction_id) as no_of_txn
from sales
group by category
order by no_of_txn desc;

--Which category has the highest average purchase amount?
select category, round(avg(purchase_amount), 2) as avg_purchase_amount
from sales
group by category
order by avg_purchase_amount desc;

--Which category has the highest return rate?
SELECT
    category,
    ROUND(
        COUNT(*) FILTER (WHERE return_status = 'Returned') * 100.0
        / COUNT(*),
        2
    ) AS return_rate
FROM sales
GROUP BY category
ORDER BY return_rate DESC;

--Which products generate the most revenue?

select category, sum(purchase_amount) rev_by_cat from sales
group by category
order by rev_by_cat desc;

select category, sum(quantity) from sales
group by category
order by sum(quantity) desc;

--What are the top 10 products by revenue?
select item_purchased, sum(purchase_amount) from sales
group by item_purchased
order by sum(purchase_amount) desc
limit 10;


--What are the top 10 products by quantity sold?
select item_purchased, sum(quantity) from sales
group by item_purchased
order by sum(quantity) desc
limit 10;

--Which products have the highest average rating?

select item_purchased, round(avg(review_rating),2) as avg_rating
from sales
group by item_purchased
order by avg_rating desc
limit 1;

--Which brands sell the most units?
select brand, sum(quantity) from sales
group by brand
order by sum(quantity) desc
limit 10;


--Which brands have the highest average rating?

select brand, round(avg(review_rating),2) as avg_rating
from sales
group by brand
order by avg_rating desc
limit 10;

--Which brand has the highest average transaction value?
select brand, round(avg(purchase_amount),2) as avg_amount
from sales
group by brand
order by avg_amount desc
limit 10;

--Which colors are most popular?
select color, sum(quantity) from sales s
join products p on s.product_id = p.product_id
group by color
order by sum(quantity) desc
limit 10;


--Which sizes are most popular?
select size, sum(quantity) from sales s
join products p on s.product_id = p.product_id
group by size
order by sum(quantity) desc
limit 10;

--Which category has the highest average discount?
select category, round(avg(discount),2) h_avg_dis from sales
group by category 
order by h_avg_dis
limit 10;

--Which brands receive the highest average ratings?

select brand, round(avg(review_rating),2) as avg_rating
from sales
group by brand
order by avg_rating desc
limit 10;

