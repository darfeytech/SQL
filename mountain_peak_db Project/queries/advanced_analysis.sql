/* 16. Calculate the total sales amount and number of transactions for each employee.
Who are the top-performing sales associates? */

SELECT e.employee_id, e.first_name, e.last_name, e.position, SUM(total_amount) total_sales, 
COUNT(e.employee_id) total_transactions
FROM sales s
LEFT JOIN employees e
ON s.employee_id = e.employee_id
WHERE e.position = 'Sales Associate'
GROUP BY e.employee_id, e.first_name, e.last_name,e.position
ORDER BY total_sales DESC

--- The top-performing sales associates are employees with employee_id: 7 and 4

/* 17.	Find the average transaction value for each employee.
Who generates the highest average sale amount? */

SELECT e.employee_id, e.first_name, e.last_name, COUNT(e.employee_id) total_transactions,
ROUND(SUM(s.total_amount)/COUNT(e.employee_id),2) average_transaction_value
FROM sales s
LEFT JOIN employees e
ON s.employee_id = e.employee_id
WHERE s.employee_id IS NOT NULL
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY average_transaction_value DESC

--- employee_id 11 is the employee with the highest average sale amount

/* 18.	Create a report showing each store's name, manager's name, 
number of employees, and total sales amount.  */

WITH store_info AS(
SELECT st.store_id, st.store_name, count(e.store_id) no_store_employees 
FROM employees e
RIGHT JOIN stores st
ON e.store_id = st.store_id
GROUP BY st.store_id, st.store_name
)
SELECT si.store_id, si.store_name, sm.first_name manager_first_name, 
sm.last_name manager_last_name, si.no_store_employees, sa.total_sales_amount
FROM store_info si
LEFT JOIN (SELECT store_id, Sum(total_amount) total_sales_amount
FROM sales 
Group by store_id
) sa
ON si.store_id = sa.store_id
LEFT JOIN (SELECT *
FROM employees 
WHERE position = 'Store Manager') sm
ON si.store_id = sm.store_id
ORDER BY si.store_id

/* From the report table, it shows only 5 stores(with store_id 1,2,3,4,5) has a manager,
active employees working there and fully active. The store with store_id 6 made just
one sale which the details of the sales are not registered except the total amount.
Stores with store_id 6,7,8,9 and 10 are not operational or the details of the stores
are missing */

--- 19. Identify stores where the average employee salary is higher than the company-wide average.

SELECT s.store_id, s.store_name, round(AVG(e.salary),2) avg_store_salary
FROM employees e
RIGHT JOIN stores s 
ON e.store_id = s.store_id
GROUP BY s.store_id, s.store_name
HAVING AVG(e.salary) > (SELECT AVG(salary) 
                        FROM employees)

--- Stores with store_id 2,3,4,5 has their average employee salary higher than the company-wide average



/* 20.	Create a product performance matrix that categorizes products into 
four groups based on their sales volume and profit margin:
○	Stars: High sales, high margin
○	Volume Drivers: High sales, low margin
○	Opportunities: Low sales, high margin
○	Problems: Low sales, low margin
*/

WITH profit_table AS(
SELECT p.product_id, p.product_name, p.cost,
SUM(si.quantity) quantity_sold, si.price_sold, 
round(((si.price_sold/p.cost)-1)*100) percentage_profit_margin
FROM products p
LEFT JOIN sale_items si
ON p.product_id = si.product_id
GROUP BY p.product_id, p.product_name, p.cost, si.price_sold
ORDER BY quantity_sold DESC
)
SELECT *,
CASE 
  WHEN pt.quantity_sold > (SELECT AVG(quantity_sold) FROM profit_table)
  AND
    pt.percentage_profit_margin > (SELECT AVG(percentage_profit_margin) FROM profit_table)
  THEN 'Stars'
  
  WHEN pt.quantity_sold > (SELECT AVG(quantity_sold) FROM profit_table)
  AND
    pt.percentage_profit_margin < (SELECT AVG(percentage_profit_margin) FROM profit_table)
  THEN 'Volume Drivers'
  
  WHEN pt.quantity_sold < (SELECT AVG(quantity_sold) FROM profit_table)
  AND
    pt.percentage_profit_margin > (SELECT AVG(percentage_profit_margin) FROM profit_table)
  THEN 'Opportunities'
  
  ELSE 'Problems'
END AS performance_category
FROM profit_table pt

/* From the product performance matrix, just 2 out of the 16 products are on the 'Stars' group and majority of the
products falls under the 'Problem' group */


/* 21.	Generate a management hierarchy report showing the structure from store managers down 
to sales associates for each store. */

SELECT store_id, 
CASE
   WHEN e.manager_id IN (SELECT employee_id FROM employees)
   THEN (SELECT CONCAT(first_name,' ', last_name)FROM employees WHERE e.manager_id= employee_id) 
END AS manager_full_name,
CONCAT(first_name,' ', last_name) employee_full_name, position employee_position
FROM employees e
WHERE manager_id IS NOT NULL
ORDER BY store_id 



/* 22.	Create a comprehensive customer analysis that shows the purchasing patterns of customers 
in different loyalty tiers, including average transaction value, most purchased categories, 
and number of products reviewed.  */



WITH full_table AS (
        SELECT *
        FROM customers c
        LEFT JOIN sales s
        ON c.customer_id = s.customer_id
        LEFT JOIN sale_items si
        ON s.sale_id = si.sale_id
        LEFT JOIN products p
        ON si.product_id = p.product_id
        LEFT JOIN categories cat
        ON p.category_id = cat.category_id
        LEFT JOIN product_reviews pr
        ON c.customer_id = pr.customer_id
) 
SELECT t1.*, t2.most_purchased_categories 
FROM (SELECT loyalty_tier, round(AVG(total_amount),2) average_transaction_value, COUNT(review_id) no_product_review
FROM full_table
GROUP BY loyalty_tier
) AS t1
NATURAL JOIN
(SELECT loyalty_tier, STRING_AGG(category_name, ', ') most_purchased_categories
FROM (SELECT loyalty_tier, category_name, COUNT(category_name), 
RANK() OVER (PARTITION BY loyalty_tier ORDER BY COUNT(category_name) DESC
) ranking
FROM full_table
GROUP BY loyalty_tier, category_name)
WHERE ranking = 1
GROUP BY loyalty_tier
) AS T2
ORDER BY
  CASE loyalty_tier
    WHEN 'Gold' THEN 1
    WHEN 'Silver' THEN 2
    WHEN 'Bronze' THEN 3
  END

/* Customers with no loyalty tier has the highest average transaction amount, Gold loyalty tier customers 
does very well in dropping reviews of products after purchase and also purchases different categories of product unlike
other loyalty tiers customers which have unique categories they purchase more */

