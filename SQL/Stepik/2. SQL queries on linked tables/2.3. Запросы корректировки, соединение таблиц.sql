-- Запросы на обновление, связанные таблицы
/* Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем в поставке (supply),  необходимо в таблице book увеличить количество на значение, указанное в поставке,  
и пересчитать цену. А в таблице  supply обнулить количество этих книг. Формула для пересчета цены:

price={(p_1*k_1+p_2*k_2)\over k_1+k_2}
где  p1, p2 - цена книги в таблицах book и supply;

       k1, k2 - количество книг в таблицах book и supply. */
UPDATE 
book b INNER JOIN supply s ON b.title = s.title
       INNER JOIN author a ON a.author_id = b.author_id AND a.name_author = s.author
SET b.amount = b.amount + s.amount, 
    s.amount = 0, 
    b.price = ((b.price*b.amount + s.price*s.amount)/(b.amount + s.amount))
WHERE b.price <> s.price;

SELECT * FROM book;

SELECT * FROM supply;


-- Запросы на добавление, связанные таблицы
/* Включить новых авторов в таблицу author с помощью запроса на добавление, а затем вывести все данные из таблицы author. 
 Новыми считаются авторы, которые есть в таблице supply, но нет в таблице author.  */
 INSERT INTO author (name_author)
SELECT s.author
FROM author a RIGHT JOIN supply s ON a.name_author = s.author
WHERE a.name_author IS NULL


-- Запрос на добавление, связанные таблицы
/* Добавить новые книги из таблицы supply в таблицу book на основе сформированного выше запроса. Затем вывести для просмотра таблицу book.*/
INSERT INTO book (title, author_id, price, amount)
SELECT title, author_id, price, amount
FROM 
    author 
    INNER JOIN supply ON author.name_author = supply.author
WHERE amount <> 0;


-- Запрос на обновление, вложенные запросы
/*  Занести для книги «Стихотворения и поэмы» Лермонтова жанр «Поэзия», а для книги «Остров сокровищ» Стивенсона - «Приключения». (Использовать два запроса). */
UPDATE book
SET genre_id = 
    (
        SELECT genre_id
        FROM genre
        WHERE name_genre = 'Поэзия'
     )
WHERE title = 'Стихотворения и поэмы' AND author_id =(SELECT author_id
                  FROM author
                  WHERE name_author = 'Лермонтов М.Ю.');

UPDATE book
SET genre_id = 
    (
        SELECT genre_id
        FROM genre
        WHERE name_genre = 'Приключения'
     )
WHERE title = 'Остров сокровищ' AND author_id =(SELECT author_id
                  FROM author
                  WHERE name_author = 'Стивенсон Р.Л.')


-- Каскадное удаление записей связанных таблиц
/* Удалить всех авторов и все их книги, общее количество книг которых меньше 20. */
DELETE FROM author
WHERE author_id IN 
          (SELECT author_id 
           FROM book
           GROUP BY author_id
           HAVING SUM(amount) < 20)


-- Удаление записей главной таблицы с сохранением записей в зависимой
/*  далить все жанры, к которым относится меньше 4-х книг. В таблице book для этих жанров установить значение Null. */
DELETE FROM genre
WHERE genre_id IN (
    SELECT genre_id
    FROM book
    GROUP BY genre_id
    HAVING COUNT(amount) < 4)


-- Удаление записей, использование связанных таблиц
/* Удалить всех авторов, которые пишут в жанре "Поэзия". Из таблицы book удалить все книги этих авторов. В запросе для отбора авторов использовать полное название жанра, а не его id.  */
DELETE FROM a
USING author a INNER JOIN book b USING(author_id) INNER JOIN genre g USING(genre_id)
WHERE g.name_genre IN (
    SELECT name_genre
    FROM genre
    WHERE name_genre = 'Поэзия')




    ---- HARDENING TASK

/*Удалить авторов, общее число книг которых минимально.*/
DELETE FROM author
WHERE author_id	IN (
    SELECT author_id
    FROM book
    GROUP BY author_id
    HAVING SUM(amount) = (
        SELECT SUM(amount)
        FROM book
        GROUP BY author_id
        HAVING SUM(amount)
        ORDER BY SUM(amount)
         LIMIT 1)
    );
    


/* Удалить тех авторов из таблиц author и book, у кого в таблице book есть книги, названия которых состоит из двух или более слов. */
DELETE FROM a
USING book b INNER JOIN author a USING(author_id)
WHERE b.author_id IN (
    SELECT author_id
    FROM book
    WHERE title LIKE '%_ _%');