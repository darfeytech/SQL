--- 1.	Which products have less than 20 items in stock? 
--- Sort the results by stock quantity in ascending order.

SELECT * 
FROM products
WHERE stock_quantity < 20
ORDER BY stock_quantity

--- From my findings, only 6 products has stock quantity less than 20.

--- 2. What products are currently out of stock (stock_quantity = 0)?

SELECT * 
FROM products
WHERE stock_quantity = 0

--- Just 1 product(Trailblazer Hiking Boot) is out of stock

--- 3. Calculate the profit margin percentage for each product. 
---Which products have the highest profit margins?

SELECT *,round((price/cost -1)*100) profit
FROM products
ORDER BY profit DESC

/* Adventure Water Bottle, EcoTrek Water Bottle products has the 
highest profit margins of 400% */

--- 4. Find all products that have no assigned category or supplier.

SELECT * 
FROM products
WHERE category_id IS NULL 
OR supplier_id IS NULL

/* Just Orphan Product doesn't have either assigned category/supplier. 
It's also the only product that doesn't have both assigned category and supplier */



/* 5.	List all products along with their category name and supplier name. 
Include products that don't have a category or supplier assigned. */

SELECT p.*, c.category_name, s.supplier_name
FROM products p
LEFT JOIN categories c
ON p.category_id = c.category_id
LEFT JOIN suppliers s
ON p.supplier_id = s.supplier_id
