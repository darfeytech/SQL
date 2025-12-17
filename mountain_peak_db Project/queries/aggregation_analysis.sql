/* 6. What is the total sales amount for each store? Show the store name, region, 
and total sales. */

SELECT st.store_name, s.store_id, st.region, SUM(s.total_amount) total_store_sale
FROM sales s
LEFT JOIN stores st
ON s.store_id = st.store_id
GROUP BY st.store_name, st.region, s.store_id
ORDER BY total_store_sale DESC

/* Mountain Peak Denver from the west region has the highest amount of 
sales(1624.89) while Mountain Peak Portland from the west has the lowest amount 
of sales (299.99) */


/* 7.	Calculate the total sales amount for each month of 2023, 
along with the count of transactions for that month. */

SELECT *
FROM sales 

SELECT TO_CHAR (sale_date :: Date, 'Month'), SUM(total_amount) monthly_sales
FROM sales 
GROUP BY TO_CHAR (sale_date :: Date, 'Month')
ORDER BY monthly_sales DESC

/* The month of MAY has the highest amount of sales(1749.91) 
while the month of JUNE has the lowest amount of sales (299.99) */


/* 8.	Which product categories generate the most revenue? 
Rank categories by total sales amount. */

SELECT *
FROM sales

SELECT *
FROM sale_items

SELECT *
FROM categories

SELECT *
FROM products

SELECT  p.category_id, c.category_name, 
SUM(s.total_amount) total_sales_amount,
RANK() OVER (ORDER BY SUM(s.total_amount) DESC) rank
FROM products p
LEFT JOIN categories c
ON p.category_id = c.category_id
LEFT JOIN sale_items si
ON p.product_id = si.product_id
LEFT JOIN sales s
ON si.sale_id = s.sale_id
WHERE p.category_id IS NOT NULL
GROUP BY p.category_id, c.category_name

/* Tents Category generate the most revenue(2949.89) 
while Hiking poles generate the lowest revenue (684.85). 
The top two are Tents and Water Botteles and the bottow two are sleeping bags and 
hiking poles */


/* 9. Identify the top 5 most frequently purchased products along with their 
total quantity sold. */

SELECT *
FROM sales

SELECT sum(quantity)
FROM sale_items

SELECT p.product_name, SUM(si.quantity) total_quantity_sold
FROM products p
LEFT JOIN sale_items si
ON si.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC

/* EcoTrek Water Bottle(11), Expedition 3-Person Tent(4), NavPro GPS Device(3), 
Alpine Waterproof Jacket(3), TrailSupport Hiking Poles(3) are the 
top 5 most frequently purchased products */


/* 10. For each customer, list their name, email, number of purchases, 
and the date of their most recent purchase. */

SELECT c.first_name, c.last_name, c.email, s.sale_date, 
SUM(si.quantity) total_quantity
FROM customers c
LEFT JOIN sales s
ON c.customer_id = s.customer_id
LEFT JOIN sale_items si
ON s.sale_id = si.sale_id
WHERE si.quantity IS NOT NULL
GROUP BY c.first_name, c.last_name, c.email, s.sale_date
ORDER BY sale_date DESC

SELECT *
FROM sales
ORDER BY sale_date DESC

SELECT *
FROM sale_items



