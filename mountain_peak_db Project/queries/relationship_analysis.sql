/* 11. Calculate the total amount spent by each customer. 
Sort by total spend in descending order. */

SELECT c.first_name, c.last_name, SUM(s.total_amount) total_spend
FROM customers c
LEFT JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_spend DESC

/* Alex Roberts is the customer who spent the most(1009.95) while 
Matthew Wright is the customer with the least spend (309.98) */


/* 12. Find the average rating given by customers in each loyalty tier. 
Does loyalty tier correlate with how customers rate products? */


SELECT *
FROM product_reviews

SELECT loyalty_tier, COUNT(loyalty_tier)
FROM customers
GROUP BY loyalty_tier

SELECT c.loyalty_tier, round(AVG(pr.rating),2) average_rating, 
COUNT(c.loyalty_tier) no_loyalty_tier_ratings
FROM customers c
LEFT JOIN product_reviews pr
ON c.customer_id = pr.customer_id
WHERE rating IS NOT NULL
GROUP BY  c.loyalty_tier
ORDER BY AVG(pr.rating) DESC

/* The loyalty tier doesn't correlate with how customers rate products with
respect to the number of ratings from each loyalty tier . Customers in the
Silver loyalty tier with average rating of 4.17 has 6 customer ratings has higher 
average rating than customers in the Gold tier (3.86) with 7 customer ratings.
Customers in the Gold tier is meant to have a higher average rating*/


/* 13.Identify customers who have made purchases but have never left a product 
review. */

SELECT c.first_name, c.last_name, s.total_amount, pr.rating, pr.review_text
FROM customers c
LEFT JOIN sales s
ON c.customer_id = s.customer_id
LEFT JOIN product_reviews pr
ON s.customer_id = pr.customer_id
WHERE s.total_amount IS NOT NULL 
AND pr.review_text IS NULL

--- All customers who made purchases, left a product review


/* 14. Which customers have increased their spending in the second quarter of 2023
compared to the first quarter? */

WITH quarter1_sales AS(
	SELECT c.first_name, c.last_name, c.customer_id, 
	EXTRACT(QUARTER FROM s.sale_date) quarter, 
	SUM(s.total_amount) total_quarter_amount
	FROM customers c
	LEFT JOIN sales s
	ON c.customer_id = s.customer_id
	GROUP BY c.first_name, c.last_name, c.customer_id, 
	EXTRACT(QUARTER FROM s.sale_date)
)
SELECT q1.first_name, q1.last_name, q1.total_quarter_amount quarter1_total_amount,
q2.total_quarter_amount quarter2_total_amount
FROM quarter1_sales q1
RIGHT JOIN quarter1_sales q2 
ON q1.customer_id = q2.customer_id
WHERE  (q1.quarter=1 AND q2.quarter=2) 
AND q2.total_quarter_amount>q1.total_quarter_amount
ORDER BY first_name

--- USING SUB QUERY

SELECT q2.first_name,q2.last_name,q1.total_quarter_amount q1_total,
q2.total_quarter_amount q2_amount 
FROM
	(SELECT c.first_name, c.last_name, c.customer_id, 
		EXTRACT(QUARTER FROM s.sale_date) quarter, 
		SUM(s.total_amount) total_quarter_amount
		FROM customers c
		LEFT JOIN sales s
		ON c.customer_id = s.customer_id
		WHERE s.total_amount IS NOT NULL AND EXTRACT(QUARTER FROM s.sale_date)=1
		GROUP BY c.first_name, c.last_name, c.customer_id, 
		EXTRACT(QUARTER FROM s.sale_date)
		) AS q1
RIGHT JOIN 
	(SELECT c.first_name, c.last_name, c.customer_id, 
		EXTRACT(QUARTER FROM s.sale_date) quarter, 
		SUM(s.total_amount) total_quarter_amount
		FROM customers c
		LEFT JOIN sales s
		ON c.customer_id = s.customer_id
		WHERE s.total_amount IS NOT NULL AND EXTRACT(QUARTER FROM s.sale_date)=2
		GROUP BY c.first_name, c.last_name, c.customer_id, 
		EXTRACT(QUARTER FROM s.sale_date)
	) AS q2
ON q1.customer_id = q2.customer_id
WHERE q2.total_quarter_amount > q1.total_quarter_amount

--- Just 3 customers increased their spending in the second quarter of 2023


/* 15.	What are the favorite product categories for Gold tier customers 
based on their purchase history?  */

SELECT si.product_id, p.category_id, c.loyalty_tier, cat.category_name,
COUNT(si.quantity) quantity_purchased 
FROM sale_items si
LEFT JOIN products p
ON si.product_id = p.product_id
LEFT JOIN categories cat
ON p.category_id = cat.category_id
LEFT JOIN product_reviews pr
ON si.product_id =pr.product_id
LEFT JOIN customers c
ON pr.customer_id = c.customer_id
GROUP BY si.product_id, p.category_id, c.loyalty_tier, cat.category_name
HAVING c.loyalty_tier= 'Gold'
ORDER BY quantity_purchased DESC

/* The favorite product categories for Gold tier customers based on their 
purchase history are Tents(8) and GPS devices(3) */










	