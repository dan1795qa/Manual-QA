SELECT *
FROM products;

SELECT * 
FROM products
WHERE manufacturer = 'Apple' and category = 'Phones';

SELECT name, price
FROM products
WHERE price BETWEEN 100 AND 1000;

SELECT SUM(price) AS 'SAMSUNG TOTAL PRICE'
FROM products
WHERE manufacturer  = 'Samsung';

SELECT name, price
FROM products
ORDER BY price DESC;

SELECT DISTINCT  manufacturer
FROM products;

SELECT DISTINCT  category
FROM products
LIMIT 2;

SELECT name
FROM products
WHERE name LIKE "A%" AND LENGTH(NAME) = 12;

SELECT AVG(price) AS 'PRODUCTS AVG PRICE'
FROM products;

SELECT name, description
FROM products
WHERE manufacturer IN  ('Samsung', 'Huawei');


SELECT name
FROM products
UNION
SELECT order_id
FROM orders;

SELECT category, COUNT(name)
FROM products
GROUP BY category
HAVING COUNT(name) > 15;

SELECT manufacturer, category, price, name,
CASE manufacturer
	WHEN 'Apple' THEN 'Это продукт компании Apple'
	WHEN 'Samsung' THEN 'Это продукт компании Samsung'	
	WHEN 'Huawei' THEN 'Это продукт компании Huawei'	
	WHEN 'Xiaomi' THEN 'Это продукт компании Xiaomi'	
END AS 'message'
FROM products;



