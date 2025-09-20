-- Вложенный запрос, возвращающий одно значение
SELECT author, title, price
FROM book
WHERE price <= (
    SELECT AVG(price)
    FROM book
              )
ORDER BY price DESC;


 -- Использование вложенного запроса в выражении
 -- Вывести информацию (автора, название и цену) о тех книгах, цены которых превышают минимальную цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде.
SELECT author, title, price
FROM book
WHERE (price - (SELECT MIN(price) FROM book)) <= 150
ORDER BY price 


-- Вложенный запрос, оператор IN
-- Вывести информацию (автора, книгу и количество) о тех книгах, количество экземпляров которых в таблице book не дублируется.
SELECT author, title, amount
FROM book
WHERE amount IN (
    SELECT amount
    FROM book
GROUP BY amount
HAVING COUNT(amount) = 1)


-- Вложенный запрос, операторы ANY и ALL
-- Вывести информацию о книгах(автор, название, цена), цена которых меньше самой большой из минимальных цен, вычисленных для каждого автора.
SELECT author, title, price
FROM book
WHERE price < ANY(
    SELECT MIN(price)
    FROM book
    GROUP BY author)


-- Вложенный запрос после SELECT
-- Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, чтобы на складе стало одинаковое количество экземпляров каждой книги, равное значению самого большего количества экземпляров одной книги на складе. 
-- Вывести название книги, ее автора, текущее количество экземпляров на складе и количество заказываемых экземпляров книг. Последнему столбцу присвоить имя Заказ. В результат не включать книги, которые заказывать не нужно.   
SELECT title, author, amount,
((SELECT MAX(amount) FROM book)  - amount) AS 'Заказ'
FROM book
WHERE amount < (SELECT MAX(amount)FROM book)



-- HARDENING TASK

--Определить стоимость покупки, если купить самую дешевую книгу каждого автора.SELECT
  SELECT SUM(price) AS 'Стоимость_покупки'
FROM book
WHERE price = ANY(
SELECT MIN(price) 
FROM book 
GROUP BY author)


-- Вывести информацию о тех книгах, цена для которых отличается от средней цены книг на складе не более, чем на 20%
SELECT author, title, price
FROM book
WHERE abs(1-(price/(SELECT AVG(price) FROM book)))<0.2


-- Вывести информацию (название, автора, цену) о самой дешевой книге каждого из авторов, а также цену самой дешевой книге из всех (как cheapest_book_price). Сортировка по цене от дешевой.
SELECT title, author, price,
(
    SELECT MIN(price) FROM book) AS cheapest_book_price
FROM book
WHERE price < ANY (
    SELECT MIN(price)
    FROM book
    GROUP BY author
    );