-- Соединение (INNER) JOIN
-- Вывести название, жанр и цену тех книг, количество которых больше 8, в отсортированном по убыванию цены виде.
SELECT b.title, g.name_genre, b.price
FROM book b JOIN genre g ON b.genre_id = g.genre_id
WHERE amount > 8
ORDER BY price DESC


-- Внешнее соединение LEFT и RIGHT OUTER JOIN
-- Вывести все жанры, которые не представлены в книгах на складе.
SELECT g.name_genre
FROM book b RIGHT JOIN genre g ON b.genre_id = g.genre_id
WHERE b.genre_id IS NULL


-- Перекрестное соединение CROSS JOIN (в запросе вместо ключевых слов можно поставить запятую между таблицами
/*Необходимо в каждом городе провести выставку книг каждого автора в течение 2020 года. 
Дату проведения выставки выбрать случайным образом. Создать запрос, который выведет город, автора и дату проведения выставки. Последний столбец назвать Дата. 
Информацию вывести, отсортировав сначала в алфавитном порядке по названиям городов, а потом по убыванию дат проведения выставок.*/
SELECT name_city, name_author, DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY) AS 'Дата'
FROM city, author
ORDER BY name_city, 3 DESC


-- Запросы на выборку из нескольких таблиц
/*Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде.*/
SELECT g.name_genre, b.title, a.name_author
FROM genre g JOIN book b ON g.genre_id = b.genre_id JOIN author a ON b.author_id = a.author_id
WHERE name_genre LIKE '%Роман%'
ORDER BY title


-- Запросы для нескольких таблиц с группировкой
/*Посчитать количество экземпляров  книг каждого автора из таблицы author.  
Вывести тех авторов,  количество книг которых меньше 10, в отсортированном по возрастанию количества виде. Последний столбец назвать Количество.*/
SELECT a.name_author, SUM(b.amount) AS 'Количество'
FROM author a LEFT JOIN book b ON a.author_id = b.author_id 
GROUP BY name_author
HAVING SUM(b.amount) < 10 OR COUNT(title) = 0  /* ЛИБО OR SUM(b.amount) IS NULL*/
ORDER BY Количество


-- Запросы для нескольких таблиц со вложенными запросами
-- Вывести авторов, общее количество книг которых на складе максимально.
SELECT name_author, SUM(amount) as Количество
FROM 
    author INNER JOIN book
    on author.author_id = book.author_id
GROUP BY name_author
HAVING SUM(amount) = 
     (/* вычисляем максимальное из общего количества книг каждого автора */
      SELECT MAX(sum_amount) AS max_sum_amount
      FROM 
          (/* считаем количество книг каждого автора */
            SELECT author_id, SUM(amount) AS sum_amount 
            FROM book GROUP BY author_id
          ) query_in
      );


-- Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре.
SELECT a.name_author
FROM author a JOIN book b ON a.author_id = b.author_id
GROUP BY name_author
HAVING COUNT(DISTINCT(genre_id)) = 1
ORDER BY name_author

ИЛИ

SELECT a.name_author
FROM author a JOIN (SELECT author_id, COUNT(genre_id)
        FROM (SELECT DISTINCT author_id, genre_id FROM book) q1
        GROUP BY author_id
        HAVING COUNT(genre_id) = 1) q2 ON a.author_id = q2.author_id


-- Вложенные запросы в операторах соединения
-- Вывести информацию о книгах (название книги, фамилию и инициалы автора, название жанра, цену и количество экземпляров книги), написанных в самых популярных жанрах, в отсортированном в алфавитном порядке по названию книг виде. 
-- Самым популярным считать жанр, общее количество экземпляров книг которого на складе максимально.
SELECT title, name_author, name_genre, price, amount
FROM author a JOIN book b ON a.author_id = b.author_id
              JOIN genre g ON b.genre_id = g.genre_id
WHERE g.genre_id IN 
(SELECT q1.genre_id FROM (SELECT genre_id, SUM(amount) AS 'sum_amount' FROM book GROUP BY genre_id) q1 
JOIN 
(SELECT genre_id, SUM(amount) AS 'sum_amount' FROM book GROUP BY genre_id LIMIT 1) q2 
ON q1.sum_amount = q2.sum_amount)              
ORDER BY title

ИЛИ

SELECT title, name_author, name_genre, price, amount
FROM author a JOIN book b ON a.author_id = b.author_id
              JOIN genre g ON b.genre_id = g.genre_id
WHERE g.genre_id IN 
        (SELECT genre_id
        FROM book
        GROUP BY genre_id
        HAVING  sum(amount) = (
            SELECT sum(amount) as 'sum_amount'
            FROM book
            GROUP BY genre_id
            LIMIT 1))         
ORDER BY title


-- Операция соединение, использование USING()
-- Если в таблицах supply  и book есть одинаковые книги, которые имеют равную цену,  вывести их название и автора, а также посчитать общее количество экземпляров книг в таблицах supply и book,  
-- столбцы назвать Название, Автор  и Количество.
SELECT b.title AS 'Название',
a.name_author AS 'Автор',
(b.amount + s.amount) AS 'Количество'
FROM author a JOIN book b
     USING(author_id) 
     JOIN supply s ON a.name_author = s.author AND b.title = s.title
WHERE s.price = b.price






---- HARDENING TASK


/*Для каждого автора из таблицы author вывести количество книг, написанных им в каждом жанре.
Вывод: ФИО автора, жанр, количество. Отсортировать по фамилии, затем - по убыванию количества написанных книг.*/

SELECT a.name_author, g.name_genre, IF(SUM(b.amount) > 0, SUM(b.amount), 0)  AS 'Количесвто'
FROM author a CROSS JOIN genre g LEFT JOIN book b ON a.author_id = b.author_id AND g.genre_id = b.genre_id
GROUP BY name_author, name_genre
ORDER BY name_author, Количесвто DESC


/*Для каждого автора из таблицы author и book вывести стоимость запаса по жанрам
Отсортировать по фамилии автора в алфавитном порядке*/

SELECT a.name_author, g.name_genre, SUM(b.price*b.amount) AS 'Стоимость'
FROM author a JOIN book b USING(author_id) JOIN genre g USING(genre_id)
GROUP BY a.name_author, g.name_genre
ORDER BY a.name_author