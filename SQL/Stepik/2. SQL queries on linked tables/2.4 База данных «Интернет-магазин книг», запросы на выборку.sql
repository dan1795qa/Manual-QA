/* ВСЯ БАЗА*/
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);

INSERT INTO author (name_author)
VALUES ('Булгаков М.А.'),
       ('Достоевский Ф.М.'),
       ('Есенин С.А.'),
       ('Пастернак Б.Л.'),
       ('Лермонтов М.Ю.');

CREATE TABLE genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(30)
);

INSERT INTO genre(name_genre)
VALUES ('Роман'),
       ('Поэзия'),
       ('Приключения');

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8, 2),
    amount INT,
    FOREIGN KEY (author_id)
        REFERENCES author (author_id)
        ON DELETE CASCADE,
    FOREIGN KEY (genre_id)
        REFERENCES genre (genre_id)
        ON DELETE SET NULL
);

INSERT INTO book (title, author_id, genre_id, price, amount)
VALUES  ('Мастер и Маргарита', 1, 1, 670.99, 3),
        ('Белая гвардия ', 1, 1, 540.50, 5),
        ('Идиот', 2, 1, 460.00, 10),
        ('Братья Карамазовы', 2, 1, 799.01, 2),
        ('Игрок', 2, 1, 480.50, 10),
        ('Стихотворения и поэмы', 3, 2, 650.00, 15),
        ('Черный человек', 3, 2, 570.20, 6),
        ('Лирика', 4, 2, 518.99, 2);

CREATE TABLE city (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name_city VARCHAR(30),
    days_delivery INT
);

INSERT INTO city(name_city, days_delivery)
VALUES ('Москва', 5),
       ('Санкт-Петербург', 3),
       ('Владивосток', 12);

CREATE TABLE client (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    name_client VARCHAR(50),
    city_id INT,
    email VARCHAR(30),
    FOREIGN KEY (city_id) REFERENCES city (city_id)
);

INSERT INTO client(name_client, city_id, email)
VALUES ('Баранов Павел', 3, 'baranov@test'),
       ('Абрамова Катя', 1, 'abramova@test'),
       ('Семенонов Иван', 2, 'semenov@test'),
       ('Яковлева Галина', 1, 'yakovleva@test');

CREATE TABLE buy(
    buy_id INT PRIMARY KEY AUTO_INCREMENT,
    buy_description VARCHAR(100),
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES client (client_id)
);

INSERT INTO buy (buy_description, client_id)
VALUES ('Доставка только вечером', 1),
       (NULL, 3),
       ('Упаковать каждую книгу по отдельности', 2),
       (NULL, 1);

CREATE TABLE buy_book (
    buy_book_id INT PRIMARY KEY AUTO_INCREMENT,
    buy_id INT,
    book_id INT,
    amount INT,
    FOREIGN KEY (buy_id) REFERENCES buy (buy_id),
    FOREIGN KEY (book_id) REFERENCES book (book_id)
);

INSERT INTO buy_book(buy_id, book_id, amount)
VALUES (1, 1, 1),
       (1, 7, 2),
       (1, 3, 1),
       (2, 8, 2),
       (3, 3, 2),
       (3, 2, 1),
       (3, 1, 1),
       (4, 5, 1);

CREATE TABLE step (
    step_id INT PRIMARY KEY AUTO_INCREMENT,
    name_step VARCHAR(30)
);

INSERT INTO step(name_step)
VALUES ('Оплата'),
       ('Упаковка'),
       ('Транспортировка'),
       ('Доставка');

CREATE TABLE buy_step (
    buy_step_id INT PRIMARY KEY AUTO_INCREMENT,
    buy_id INT,
    step_id INT,
    date_step_beg DATE,
    date_step_end DATE,
    FOREIGN KEY (buy_id) REFERENCES buy (buy_id),
    FOREIGN KEY (step_id) REFERENCES step (step_id)
);

INSERT INTO buy_step(buy_id, step_id, date_step_beg, date_step_end)
VALUES (1, 1, '2020-02-20', '2020-02-20'),
       (1, 2, '2020-02-20', '2020-02-21'),
       (1, 3, '2020-02-22', '2020-03-07'),
       (1, 4, '2020-03-08', '2020-03-08'),
       (2, 1, '2020-02-28', '2020-02-28'),
       (2, 2, '2020-02-29', '2020-03-01'),
       (2, 3, '2020-03-02', NULL),
       (2, 4, NULL, NULL),
       (3, 1, '2020-03-05', '2020-03-05'),
       (3, 2, '2020-03-05', '2020-03-06'),
       (3, 3, '2020-03-06', '2020-03-10'),
       (3, 4, '2020-03-11', NULL),
       (4, 1, '2020-03-20', NULL),
       (4, 2, NULL, NULL),
       (4, 3, NULL, NULL),
       (4, 4, NULL, NULL);

1) genre - название жанра
2) book - автор
3) author - название книги, автор, цена, количество на складе, id жанра и автора
4) city - город клиента и время доставки
5) client - имя клиента, почта, id города
6) buy - пожелания покупателя и id клиента
7) buy_book - таблица с количество заказа покупателей, id книг и таблицы с данными клиента
8) step - этапы обработки заказа клиента
9) buy_step - даты начала и окончания этапов обработки заказа с id данными клиента и этапа

-- ЗАДАНИЯ

-- Запросы на основе трех и более связанных таблиц
/* Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал) в отсортированном по номеру заказа и названиям книг виде. */
SELECT buy.buy_id, book.title, book.price, buy_book.amount 
FROM client JOIN buy USING(client_id)
            JOIN buy_book USING(buy_id)
            JOIN book USING( book_id)
WHERE client.name_client = 'Баранов Павел'
ORDER BY buy.buy_id, book.title;


/* Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора (нужно посчитать, в каком количестве заказов фигурирует каждая книга).  
Вывести фамилию и инициалы автора, название книги, последний столбец назвать Количество. Результат отсортировать сначала  по фамилиям авторов, а потом по названиям книг.*/
SELECT author.name_author, book.title, COUNT(buy_book.book_id) AS 'Количество'
FROM author JOIN book USING(author_id)
            LEFT OUTER JOIN buy_book USING(book_id)
GROUP BY book.book_id
ORDER BY author.name_author, book.title;


/* Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине. Указать количество заказов в каждый город, этот столбец назвать Количество. 
Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов. */
SELECT city.name_city, COUNT(buy.client_id) AS 'Количество'
FROM city 
     JOIN client USING(city_id)
     JOIN buy USING(client_id)
GROUP BY buy.client_id
ORDER BY Количество DESC, city.name_city;


/* Вывести номера всех оплаченных заказов и даты, когда они были оплачены. */
SELECT buy_step.buy_id, buy_step.date_step_end
FROM step 
     INNER JOIN buy_step USING(step_id)
WHERE buy_step.date_step_end IS NOT Null AND step.name_step = 'Оплата';


/* Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) и его стоимость (сумма произведений количества заказанных книг и их цены), 
в отсортированном по номеру заказа виде. Последний столбец назвать Стоимость. */
SELECT buy.buy_id, client.name_client, SUM(buy_book.amount * book.price) AS  'Стоимость'
FROM client
     INNER JOIN buy USING(client_id)
     INNER JOIN buy_book USING(buy_id)
     INNER JOIN book USING(book_id)
GROUP BY buy.buy_id, client.name_client 
ORDER BY buy.buy_id;


/* Вывести номера заказов (buy_id) и названия этапов, на которых они в данный момент находятся. Если заказ доставлен –  информацию о нем не выводить. 
Информацию отсортировать по возрастанию buy_id. */
SELECT buy_step.buy_id, step.name_step
FROM step
     JOIN buy_step USING(step_id)
WHERE buy_step.date_step_beg IS NOT NULL AND buy_step.date_step_end IS NULL
ORDER BY buy_step.buy_id;


/* В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот город (рассматривается только этап "Транспортировка"). 
Для тех заказов, которые прошли этап транспортировки, вывести количество дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием, 
указать количество дней задержки, в противном случае вывести 0. В результат включить номер заказа (buy_id), а также вычисляемые столбцы Количество_дней и Опоздание. 
Информацию вывести в отсортированном по номеру заказа виде. */
SELECT bs.buy_id, DATEDIFF(bs.date_step_end, bs.date_step_beg) AS 'Количество_дней', 
IF(DATEDIFF(bs.date_step_end, bs.date_step_beg) > city.days_delivery, DATEDIFF(bs.date_step_end, bs.date_step_beg) - city.days_delivery, 0) AS 'Опоздание'
FROM city
     JOIN client c USING(city_id)
     JOIN buy b USING(client_id)
     JOIN buy_step bs USING(buy_id)
     JOIN step s USING(step_id)
WHERE s.name_step = 'Транспортировка' AND bs.date_step_end IS NOT NULL
ORDER BY bs.buy_id;


/* Выбрать всех клиентов, которые заказывали книги Достоевского, информацию вывести в отсортированном по алфавиту виде. 
В решении используйте фамилию автора, а не его id. */
SELECT DISTINCT c.name_client 
FROM client c
     JOIN buy b USING(client_id)
     JOIN buy_book bbk USING(buy_id)
     JOIN book bk USING(book_id)
     JOIN author a USING(author_id)
WHERE a.name_author LIKE 'Достоевский%'
ORDER BY c.name_client;


/* Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг, указать это количество . 
Последний столбец назвать Количество. */
SELECT g.name_genre, SUM(bb.amount) AS 'Количество'
     FROM genre g
     JOIN book b USING(genre_id)
     JOIN buy_book bb USING(book_id)
     GROUP BY g.name_genre
     HAVING SUM(bb.amount) = (
         SELECT MAX(sum_amount) AS max_sum_amount
         FROM 
         (SELECT g.name_genre, SUM(bb.amount) AS sum_amount
          FROM genre g
          JOIN book b USING(genre_id)
          JOIN buy_book bb USING(book_id)
          GROUP BY g.name_genre) AS query1);


/*Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы. 
Для этого вывести год, месяц, сумму выручки в отсортированном сначала по возрастанию месяцев, затем по возрастанию лет виде. 
Название столбцов: Год, Месяц, Сумма. */
SELECT YEAR(date_payment) AS 'Год', MONTHNAME(date_payment) AS 'Месяц', SUM(price*amount) AS 'Сумма'
FROM buy_archive
GROUP BY MONTHNAME(date_payment), YEAR(date_payment)

UNION ALL

SELECT YEAR(bs.date_step_end) AS 'Год', MONTHNAME(bs.date_step_end) AS 'Месяц', SUM(bk.price * bbk.amount)
FROM book bk
     JOIN buy_book bbk USING(book_id)
     JOIN buy b USING(buy_id)
     JOIN buy_step bs USING(buy_id)
     JOIN step s USING(step_id)
WHERE bs.date_step_end IS NOT NULL and s.name_step = "Оплата"
GROUP BY MONTHNAME(bs.date_step_end), YEAR(bs.date_step_end)

ORDER BY Месяц, Год;


/* Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров и их стоимости за текущий и предыдущий год . 
Вычисляемые столбцы назвать Количество и Сумма. Информацию отсортировать по убыванию стоимости.*/
SELECT title, SUM(Количество1) AS 'Количество', SUM(Сумма1) AS 'Сумма'
FROM(
    SELECT bk.title, SUM(ba.amount) AS 'Количество1', SUM(ba.price * ba.amount) AS 'Сумма1'
    FROM buy_archive ba
     JOIN book bk USING(book_id)
    GROUP BY bk.title
    
   UNION ALL

    SELECT bk.title, SUM(bbk.amount) AS 'Количество1', SUM(bk.price * bbk.amount) AS 'Сумма1'
    FROM book bk
     JOIN buy_book bbk USING(book_id)
     JOIN buy b USING(buy_id)
     JOIN buy_step bs USING(buy_id)
     JOIN step s USING(step_id)
    WHERE bs.date_step_end IS NOT NULL and s.name_step = "Оплата"
    GROUP BY bk.title) AS query1
GROUP BY title
ORDER BY Сумма DESC;
    
/*Обратить внимание то что не поставил SUM в количесвте!!!!!*/


/* Вывести имена клиентов и количество дней опоздания, которым книги были доставлены позже срока.*/
SELECT cl.name_client, (DATEDIFF(bs.date_step_end, bs.date_step_beg) - ct.days_delivery) AS 'Опоздание'
FROM city ct
    JOIN client cl USING(city_id)
    JOIN buy b USING(client_id)
    JOIN buy_step bs USING(buy_id)
    JOIN step s USING(step_id)
WHERE bs.date_step_end IS NOT NULL
    AND s.name_step = 'Транспортировка'
    AND (DATEDIFF(bs.date_step_end, bs.date_step_beg) - ct.days_delivery) > 0


/* Вывести клиентов в алфавитном порядке, каждый из которых за два года приобрел книг более чем на 4000 рублей. */
select Клиент,
       sum(Сумма) as Сумма
from (select c.name_client as Клиент,
             sum(bb.amount * b.price) as Сумма
      from client c
      join buy 
      using (client_id)
      join buy_book bb
      on buy.buy_id = bb.buy_id
      join book b
      using (book_id)
      join buy_step bs
      on buy.buy_id = bs.buy_id
      join step s
      using (step_id)
      where s.name_step = 'Оплата' and bs.date_step_end is not null
      group by Клиент
  UNION
          select c.name_client as Клиент,
                 sum(ba.amount * ba.price) as Сумма
          from buy_archive ba
          join client c
          on ba.client_id = c.client_id
          group by Клиент) as o
group by Клиент
having Сумма > 4000
order by Клиент;