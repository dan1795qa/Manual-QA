SELECT u.login, o.order_id, o.total
FROM users u
JOIN
orders o
ON u.user_id = o.user_id
WHERE u.login = 'dan12345';

SELECT oi.order_id, p.name, oi.quantity  
FROM order_items oi
JOIN
products p
ON oi.product_id = p.product_id; 

SELECT u.login, o.order_id  
FROM users u
LEFT JOIN
orders o
ON u.user_id = o.user_id;


SELECT oip.order_id, p.name  
FROM products p
LEFT JOIN
order_items_paid oip
ON p.product_id = oip.product_id;

SELECT name, price
FROM products
WHERE price > (SELECT price FROM products WHERE name = 'Samsung Active 5');