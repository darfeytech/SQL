-- Create the products table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INTEGER NOT NULL,
    rating DECIMAL(3,1),
    is_available BOOLEAN DEFAULT TRUE,
    release_date DATE NOT NULL,
    description TEXT
);

-- Insert 60 sample products
INSERT INTO products (name, category, price, stock_quantity, rating, is_available, release_date, description) VALUES
-- Electronics
('Smartphone X', 'Electronics', 899.99, 45, 4.7, TRUE, '2023-09-15', 'Latest flagship smartphone with advanced camera'),
('Wireless Earbuds', 'Electronics', 129.99, 78, 4.5, TRUE, '2023-07-20', 'True wireless earbuds with noise cancellation'),
('Smart Watch Pro', 'Electronics', 249.99, 32, 4.3, TRUE, '2023-11-05', 'Health and fitness tracking smartwatch'),
('Laptop Ultra', 'Electronics', 1299.99, 15, 4.8, TRUE, '2023-08-10', 'Ultralight laptop with all-day battery life'),
('Bluetooth Speaker', 'Electronics', 79.99, 60, 4.2, TRUE, '2023-03-25', 'Portable speaker with rich bass'),
('Tablet Mini', 'Electronics', 349.99, 25, 4.4, TRUE, '2023-10-12', 'Compact tablet for entertainment and work'),
('Gaming Console', 'Electronics', 499.99, 8, 4.9, TRUE, '2023-12-01', 'Next-gen gaming with 4K support'),
('Wireless Charger', 'Electronics', 39.99, 94, 4.0, TRUE, '2023-02-14', 'Fast wireless charging pad'),
('Smart Home Hub', 'Electronics', 129.99, 37, 4.1, TRUE, '2023-05-30', 'Control all your smart devices'),
('Premium Headphones', 'Electronics', 199.99, 22, 4.6, TRUE, '2023-07-07', 'Over-ear headphones with studio quality sound'),

-- Clothing
('Cotton T-shirt', 'Clothing', 19.99, 120, 4.3, TRUE, '2023-04-10', 'Comfortable everyday t-shirt'),
('Jeans Classic', 'Clothing', 49.99, 85, 4.5, TRUE, '2023-03-15', 'Classic fit denim jeans'),
('Winter Jacket', 'Clothing', 89.99, 32, 4.7, TRUE, '2023-09-20', 'Warm insulated winter jacket'),
('Running Shoes', 'Clothing', 79.99, 45, 4.6, TRUE, '2023-06-12', 'Lightweight shoes for runners'),
('Summer Dress', 'Clothing', 39.99, 28, 4.2, TRUE, '2023-05-05', 'Flowy summer dress with floral pattern'),
('Casual Shorts', 'Clothing', 29.99, 67, 4.0, TRUE, '2023-04-22', 'Comfortable everyday shorts'),
('Premium Sweater', 'Clothing', 59.99, 42, 4.4, TRUE, '2023-08-30', 'Soft wool blend sweater'),
('Business Shirt', 'Clothing', 45.99, 53, 4.1, TRUE, '2023-07-25', 'Formal shirt for professional settings'),
('Athletic Socks', 'Clothing', 12.99, 110, 3.9, TRUE, '2023-02-10', 'Pack of 6 athletic performance socks'),
('Designer Scarf', 'Clothing', 34.99, 25, 4.3, FALSE, '2023-10-15', 'Elegant patterned scarf'),

-- Home
('Coffee Maker', 'Home', 89.99, 28, 4.5, TRUE, '2023-03-10', 'Programmable drip coffee maker'),
('Blender Pro', 'Home', 69.99, 36, 4.3, TRUE, '2023-05-20', 'High-powered blender for smoothies'),
('Toaster Deluxe', 'Home', 49.99, 42, 4.0, TRUE, '2022-11-15', 'Four-slot stainless steel toaster'),
('Bedding Set', 'Home', 79.99, 18, 4.7, TRUE, '2023-07-25', 'Luxury cotton bedding set'),
('Floor Lamp', 'Home', 59.99, 24, 4.2, TRUE, '2023-08-05', 'Modern standing lamp for living room'),
('Kitchen Knife Set', 'Home', 129.99, 15, 4.8, TRUE, '2023-09-18', 'Professional grade kitchen knife set'),
('Vacuum Cleaner', 'Home', 149.99, 12, 4.6, TRUE, '2023-04-30', 'Bagless vacuum with HEPA filter'),
('Dinner Plate Set', 'Home', 39.99, 30, 4.4, TRUE, '2023-06-12', 'Set of 6 ceramic dinner plates'),
('Premium Towels', 'Home', 29.99, 48, 4.1, TRUE, '2023-02-28', 'Soft cotton bath towels set of 4'),
('Wall Clock', 'Home', 24.99, 35, 3.9, TRUE, '2022-12-10', 'Modern design wall clock'),

-- Books
('Mystery Novel', 'Books', 14.99, 85, 4.4, TRUE, '2023-07-15', 'Bestselling mystery novel'),
('Cookbook', 'Books', 24.99, 42, 4.6, TRUE, '2023-05-22', 'Collection of gourmet recipes'),
('Science Fiction', 'Books', 12.99, 63, 4.2, TRUE, '2023-08-30', 'Award-winning sci-fi thriller'),
('Self-Help Guide', 'Books', 18.99, 55, 4.5, TRUE, '2023-03-12', 'Popular self-improvement book'),
('History Book', 'Books', 22.99, 28, 4.3, TRUE, '2023-04-05', 'Comprehensive historical account'),
('Children Story', 'Books', 9.99, 72, 4.7, TRUE, '2023-06-18', 'Illustrated children book'),
('Biography', 'Books', 19.99, 36, 4.1, TRUE, '2023-09-25', 'Biography of a famous figure'),
('Programming Guide', 'Books', 39.99, 25, 4.8, TRUE, '2023-10-10', 'Comprehensive programming reference'),
('Art Book', 'Books', 49.99, 12, 4.4, FALSE, '2023-11-05', 'Coffee table book of famous artworks'),
('Poetry Collection', 'Books', 17.99, 20, 4.0, TRUE, '2023-07-30', 'Collection of contemporary poems'),

-- Toys
('Building Blocks', 'Toys', 29.99, 45, 4.6, TRUE, '2023-05-15', 'Creative building blocks set'),
('Board Game', 'Toys', 34.99, 32, 4.7, TRUE, '2023-08-22', 'Family-friendly strategy board game'),
('Action Figure', 'Toys', 19.99, 60, 4.3, TRUE, '2023-07-10', 'Collectible action figure'),
('Puzzle Set', 'Toys', 14.99, 38, 4.1, TRUE, '2023-04-18', '1000-piece jigsaw puzzle'),
('Remote Car', 'Toys', 49.99, 22, 4.5, TRUE, '2023-09-30', 'Remote controlled racing car'),
('Stuffed Animal', 'Toys', 24.99, 48, 4.8, TRUE, '2023-06-25', 'Soft plush stuffed animal'),
('Art Kit', 'Toys', 19.99, 36, 4.2, TRUE, '2023-03-20', 'Creative art supplies for kids'),
('Science Kit', 'Toys', 29.99, 25, 4.4, TRUE, '2023-10-05', 'Educational science experiments kit'),
('Doll House', 'Toys', 79.99, 10, 4.6, TRUE, '2023-11-15', 'Detailed miniature doll house'),
('Outdoor Play Set', 'Toys', 149.99, 5, 4.9, FALSE, '2023-12-01', 'Backyard play set with swings'),

-- Stationery
('Notebook Pack', 'Stationery', 12.99, 95, 4.3, TRUE, '2023-01-15', 'Set of 3 premium notebooks'),
('Fountain Pen', 'Stationery', 24.99, 42, 4.7, TRUE, '2023-02-20', 'Elegant writing fountain pen'),
('Desk Organizer', 'Stationery', 19.99, 38, 4.2, TRUE, '2023-03-10', 'Multi-compartment desk organizer'),
('Premium Journal', 'Stationery', 29.99, 25, 4.5, TRUE, '2023-05-05', 'Leather-bound writing journal'),
('Colored Pencils', 'Stationery', 15.99, 60, 4.4, TRUE, '2023-06-12', 'Set of 24 artist quality colored pencils'),
('Sticky Notes', 'Stationery', 7.99, 110, 4.0, TRUE, '2023-04-22', 'Assorted sizes and colors sticky notes'),
('Desk Lamp', 'Stationery', 34.99, 28, 4.3, TRUE, '2023-07-30', 'Adjustable LED desk lamp'),
('Filing Cabinet', 'Stationery', 129.99, 12, 4.6, TRUE, '2023-08-15', 'Two-drawer metal filing cabinet'),
('Planner', 'Stationery', 18.99, 45, 4.5, TRUE, '2023-09-22', 'Annual daily planner and organizer'),
('Premium Stapler', 'Stationery', 16.99, 35, 4.1, TRUE, '2023-01-30', 'Heavy duty desktop stapler');

--- Write a query to find all products whose name starts with the letter 'S'.
SELECT 
	*
		FROM
			products
					WHERE
						"name"
							ILIKE
								'S%'

--- Write a query to find all products whose description contains the word 'with'.
SELECT 
	*
		FROM
			products
					WHERE
						description
							ILIKE
								'%with%'

--- Write a query to find all products whose name ends with 'er'.
SELECT 
	*
		FROM
			products
					WHERE
						name
							ILIKE
								'%er'

--- 4. Write a query to find all products whose category contains 'on' (case-insensitive).
SELECT 
	*
		FROM
			products
					WHERE
						category
								ILIKE
									'%on%'

--- 5. Write a query to find all products whose name contains exactly 5 characters.
SELECT 
	*
		FROM
			products
					WHERE
						name
							LIKE '_____'

--- 6. Write a query to display the product names and their corresponding lengths.
SELECT 
	name,
		lENGTH(name)
				FROM
					products

--- 7. Write a query to display product names in uppercase.
SELECT 
	UPPER(name)
		FROM
			products

--- 8. Write a query to extract the first 10 characters of each product description
SELECT 
	LEFT
		(description,10) 
				FROM
					products
					
--- 9. Write a query to replace 'Premium' with 'Luxury' in all product names.
SELECT 
	REPLACE(name,'Premium','Luxury')
 		FROM
			products

--- 10. Write a query to concatenate the product name and category with a hyphen in between.

SELECT 
	CONCAT(name,'-',category)
		AS "Concat name and category"
		 		FROM
					products

--- 11. Write a query to round all product prices to the nearest integer.

SELECT 
	Round(price)
		FROM
			products	

--- 12. Write a query to calculate the sale price after a 15% discount.
SELECT 
	price*(1-0.15) AS "discounted price"
		FROM
			products

--- 13. Write a query to display the day of the week (name) when each product was released.
SELECT 
	TO_CHAR(release_date::DATE, 'Day')
		FROM
			products

--- 14. Write a query to find all products released in the current month, regardless of year.
SELECT 
	*
		FROM
			products
				WHERE
					EXTRACT(MONTH FROM release_date) = 10

/* 15. Write a query to calculate how many days each product has 
been in the inventory since its release date.*/
SELECT 
	CURRENT_DATE-release_date AS "days in the inventory"
		FROM
			products

--- 16. Write a query to find the average price of all products.
SELECT 
	ROUND(AVG(price),2) AS "average price"
		FROM
			products

--- 17. Write a query to find the total stock quantity of all products
SELECT 
	SUM(stock_quantity) AS "stock quantity"
		FROM
			products

--- 18. Write a query to find the highest and lowest product ratings
SELECT 
	MIN(rating) AS "minimum rating",MAX(rating) AS "maximum rating"
		FROM
			products
					
--- 19. Write a query to count the total number of products available for sale.
SELECT 
	COUNT(name) AS "total number of products"
		FROM 
			products
/* 20. Write a query to find the average price, minimum price, maximum price, 
and total number of products in a single result */
SELECT 
	AVG(price) AS "average price",
	Min(price) AS "minimum price",
	MAX(price) AS "maximum price",
	COUNT(name) AS "total number of products"
			FROM 
				products
		FROM
			products
					