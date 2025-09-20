-- Создание пустой таблицы
CREATE TABLE supply
  (supply_id INT PRIMARY KEY AUTO_INCREMENT,
   title VARCHAR(50),
   author VARCHAR(30),
   price DECIMAL(8, 2),
   amount INT
   );


  -- Добавление записей в таблицу и вывод результата
  INSERT INTO supply (title, author, price, amount)
VALUES
 ('Лирика', 'Пастернак Б.Л.', 518.99, 2),
 ('Черный человек' , 'Есенин С.А.', 570.20, 6),
 ('Белая гвардия', 'Булгаков М.А.', 540.50, 7),
 ('Идиот', 'Достоевский Ф.М.', 360.80, 3);
  SELECT * FROM supply


  -- Добавление записей из другой таблицы
  INSERT INTO book (title, author, price, amount)
SELECT title, author, price, amount
FROM supply
WHERE author <> 'Булгаков М.А.' AND author <> 'Достоевский Ф.М.';


  -- Добавление записей, вложенные запросы
  INSERT INTO book (title, author, price, amount)
SELECT title, author, price, amount
FROM supply
WHERE author NOT IN (SELECT author FROM book);


  -- Запросы на обновление
  UPDATE book 
SET price = 0.90 * price
WHERE amount BETWEEN 5 AND 10


  -- Запросы на обновление нескольких столбцов
  UPDATE book
  SET buy = IF(amount < buy, amount, buy), price = IF(buy = 0, price*0.9, price)


  -- Запросы на обновление нескольких таблиц
  UPDATE book, supply
  SET book.amount = book.amount + supply.amount, book.price = (book.price + supply.price)/2
  

  -- Запросы на удаление
  DELETE
FROM supply
WHERE author IN 
   (SELECT author
    FROM book
    GROUP BY author
    HAVING SUM(amount) > 10)


   -- Запросы на создание таблицы
   -- Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, количество экземпляров которых в таблице book меньше среднего количества экземпляров книг в таблице book. 
   -- В таблицу включить столбец   amount, в котором для всех книг указать одинаковое значение - среднее количество экземпляров книг в таблице book.
    CREATE TABLE ordering AS
    SELECT author, title,
    (SELECT AVG (amount) FROM book) AS amount
    FROM book
    WHERE amount < (SELECT AVG (amount) FROM book)


    
---- HARDENING TASK

-- Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, количество которых в таблице book меньше максимального (15). 
-- Для всех книг в таблице ordering указать такое значение, которое позволит выровнять количество книг до максимального в таблице book.
CREATE TABLE ordering AS
SELECT author, title, ((SELECT MAX(amount) FROM book) - amount) AS amount 
FROM book
WHERE amount < (SELECT MAX(amount) FROM book);