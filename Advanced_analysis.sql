CREATE TABLE retail_raw (
    transaction_id VARCHAR(20),
    customer_id VARCHAR(20),
    purchase_date DATE,
    age INT,
    gender VARCHAR(20),
    location VARCHAR(100),
    online_offline VARCHAR(20),
    online_store VARCHAR(100),
    category VARCHAR(100),
    item_purchased VARCHAR(100),
    brand VARCHAR(100),
    color VARCHAR(50),
    size VARCHAR(20),
    quantity INT,
    purchase_amount DECIMAL(10,2),
    discount DECIMAL(5,2),
    festival_sale VARCHAR(50),
    shipping_charge DECIMAL(10,2),
    delivery_speed VARCHAR(50),
    delivery_days INT,
    subscription_status VARCHAR(20),
    payment_method VARCHAR(50),
    review_rating INT,
    return_status VARCHAR(30),
    previous_purchases INT,
    purchase_frequency VARCHAR(50)
);

SELECT
    COUNT(*) - COUNT(customer_id) AS missing_customers,
    COUNT(*) - COUNT(purchase_amount) AS missing_amount,
    COUNT(*) - COUNT(review_rating) AS missing_reviews
FROM retail_raw;

SELECT transaction_id, COUNT(*)
FROM retail_raw
GROUP BY transaction_id
HAVING COUNT(*) > 1;

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    age INT,
    gender VARCHAR(20),
    location VARCHAR(100),
    subscription_status VARCHAR(20)
);

INSERT INTO customers (
    customer_id,
    age,
    gender,
    location,
    subscription_status
)
SELECT DISTINCT
    customer_id,
    age,
    gender,
    location,
    subscription_status
FROM retail_raw;

INSERT INTO products (
    category,
    item_purchased,
    brand,
    color,
    size
)
SELECT DISTINCT
    category,
    item_purchased,
    brand,
    color,
    size
FROM retail_raw;

CREATE TABLE stores (
    store_id SERIAL PRIMARY KEY,
    online_offline VARCHAR(20),
    online_store VARCHAR(100)
);

INSERT INTO stores (
    online_offline,
    online_store
)
SELECT DISTINCT
    online_offline,
    online_store
FROM retail_raw;

CREATE TABLE dates (
    date_id SERIAL PRIMARY KEY,
    purchase_date DATE,
    year INT,
    month INT,
    quarter INT,
    weekday VARCHAR(20)
);

INSERT INTO dates (
    purchase_date,
    year,
    month,
    quarter,
    weekday
)
SELECT DISTINCT
    purchase_date,
    EXTRACT(YEAR FROM purchase_date),
    EXTRACT(MONTH FROM purchase_date),
    EXTRACT(QUARTER FROM purchase_date),
    TO_CHAR(purchase_date, 'Day')
FROM retail_raw;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category VARCHAR(100),
    item_purchased VARCHAR(100),
    brand VARCHAR(100),
    color VARCHAR(50),
    size VARCHAR(30)
);

CREATE TABLE sales (
    transaction_id VARCHAR(20) PRIMARY KEY,

    customer_id VARCHAR(20) NOT NULL,
    product_id INT NOT NULL,
    store_id INT NOT NULL,
    date_id INT NOT NULL,

    quantity INT NOT NULL,
    purchase_amount DECIMAL(10,2) NOT NULL,
    discount DECIMAL(5,2),

    festival_sale VARCHAR(50),

    shipping_charge DECIMAL(10,2),
    delivery_speed VARCHAR(50),
    delivery_days INT,

    payment_method VARCHAR(50),
    review_rating INT CHECK (review_rating BETWEEN 1 AND 5),
    return_status VARCHAR(30),

    previous_purchases INT,
    purchase_frequency VARCHAR(50),

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_store
        FOREIGN KEY (store_id)
        REFERENCES stores(store_id),

    CONSTRAINT fk_date
        FOREIGN KEY (date_id)
        REFERENCES dates(date_id)
);



SELECT
    r.transaction_id,
    c.customer_id,
    p.product_id,
    s.store_id,
    d.date_id,
    r.quantity,
    r.purchase_amount,
    r.discount,
    r.festival_sale,
    r.shipping_charge,
    r.delivery_speed,
    r.delivery_days,
    r.payment_method,
    r.review_rating,
    r.return_status,
    r.previous_purchases,
    r.purchase_frequency
FROM retail_raw r
JOIN customers c
    ON r.customer_id = c.customer_id
JOIN products p
    ON r.category = p.category
    AND r.item_purchased = p.item_purchased
    AND r.brand = p.brand
    AND r.color = p.color
    AND r.size = p.size
JOIN stores s
    ON r.online_offline = s.online_offline
    AND r.online_store = s.online_store
JOIN dates d
    ON r.purchase_date = d.purchase_date;



INSERT INTO sales (
    transaction_id,
    customer_id,
    product_id,
    store_id,
    date_id,
    quantity,
    purchase_amount,
    discount,
    festival_sale,
    shipping_charge,
    delivery_speed,
    delivery_days,
    payment_method,
    review_rating,
    return_status,
    previous_purchases,
    purchase_frequency
)
SELECT
    r.transaction_id,
    c.customer_id,
    p.product_id,
    s.store_id,
    d.date_id,
    r.quantity,
    r.purchase_amount,
    r.discount,
    r.festival_sale,
    r.shipping_charge,
    r.delivery_speed,
    r.delivery_days,
    r.payment_method,
    r.review_rating,
    r.return_status,
    r.previous_purchases,
    r.purchase_frequency

FROM retail_raw r

JOIN customers c
    ON r.customer_id = c.customer_id

JOIN products p
    ON r.category = p.category
    AND r.item_purchased = p.item_purchased
    AND r.brand = p.brand
    AND r.color = p.color
    AND r.size = p.size

JOIN stores s
    ON r.online_offline = s.online_offline
    AND r.online_store = s.online_store

JOIN dates d
    ON r.purchase_date = d.purchase_date;


SELECT COUNT(*) AS total_sales
FROM sales;

