select * from dates limit 10;

select * from sales limit 10;


--What is the total revenue by year?
select year, sum(purchase_amount) as TR_by_year
from sales s
join dates d on s.date_id = d.date_id
group by year
order by year;



--What is the total number of transactions by year?
select year, count(transaction_id) as TT_by_year
from sales s
join dates d on s.date_id = d.date_id
group by year
order by year;

--What is the total revenue by month?
select month, sum(purchase_amount) as TT_by_months
from sales s
join dates d on s.date_id = d.date_id
group by month
order by month;



--What is the number of transactions by month?
select month, count(transaction_id) as TT_by_months
from sales s
join dates d on s.date_id = d.date_id
group by month
order by month;

--Which month generates the most revenue?
select month, sum(purchase_amount) as TT_by_months
from sales s
join dates d on s.date_id = d.date_id
group by month
order by TT_by_months desc;

--Which year generated the most revenue?
select year, sum(purchase_amount) as TT_by_year
from sales s
join dates d on s.date_id = d.date_id
group by year
order by TT_by_year desc;

--What is the average order value by month?
select month, avg(purchase_amount) as avg_by_months
from sales s
join dates d on s.date_id = d.date_id
group by month
order by avg_by_months desc;

--What is the monthly return rate?
SELECT month,
    ROUND(
        COUNT(*) FILTER (WHERE return_status = 'Returned') * 100.0
        / COUNT(*),
        2
    ) AS return_rate
from sales s
join dates d on s.date_id = d.date_id
group by month
order by month;