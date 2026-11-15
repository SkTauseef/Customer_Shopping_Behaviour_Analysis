select * from sales limit 50;

--total revenue
select sum(purchase_amount) from sales;

--total number of transactions
select count(transaction_id) from sales;

--total number of transactions
select sum(quantity) from sales;

--average purchase amount
select round(avg(purchase_amount), 2)from sales;

--average quantity per transaction
select round(avg(quantity), 2)from sales;

--average discount
select round(avg(discount), 2)from sales;

--total shipping cost
select sum(shipping_charge) from sales;

--average shipping cost per transaction
select round(avg(shipping_charge),2) from sales;

--average review rating
select round(avg(review_rating),2) from sales;

--How many transactions were returned?
select count(return_status) from sales
where return_status = 'Returned';

--How many transactions were not returned?
select count(return_status) from sales
where return_status = 'Not Returned';

--What is the overall return rate?
SELECT
    ROUND(
        (SELECT COUNT(*)
         FROM sales
         WHERE return_status = 'Returned') * 100.0 / COUNT(*),
        2
    ) AS return_rate
FROM sales;


--transactions were made using each payment method
SELECT payment_method, COUNT(*)
FROM sales
GROUP BY payment_method;

--payment method generated the most revenue
select payment_method,
sum(purchase_amount)
from sales
GROUP BY payment_method order by sum(purchase_amount) desc;

--payment method has the highest average transaction value
select payment_method,
round(avg(purchase_amount), 2)
from sales
GROUP BY payment_method order by avg(purchase_amount) desc;

