/* Включить нового человека в таблицу с клиентами. Его имя Попов Илья, его email popov@test, проживает он в Москве. */
INSERT INTO client (name_client, city_id, email)
SELECT 'Попов Илья', city_id, 'popov@test'
FROM city
WHERE city.name_city = 'Москва'
/* OR*/
INSERT INTO client (name_client, city_id, email)
VALUES ('Попов Илья', (SELECT  city_id FROM city WHERE city.name_city = 'Москва'), 'popov@test')



/* Создать новый заказ для Попова Ильи. Его комментарий для заказа: «Связаться со мной по вопросу доставки». */
INSERT INTO buy (buy_description, client_id)
SELECT 'Связаться со мной по вопросу доставки', client_id
FROM client
WHERE name_client = 'Попов Илья'


/* В таблицу buy_book добавить заказ с номером 5. Этот заказ должен содержать книгу Пастернака «Лирика» в количестве двух экземпляров и книгу Булгакова «Белая гвардия» 
в одном экземпляре.  */
INSERT INTO buy_book (buy_id, book_id, amount)
SELECT 5, book_id, 2
FROM book b
     JOIN author a USING(author_id)
WHERE a.name_author LIKE 'Пастернак%' AND 
      b.title = 'Лирика';
      
INSERT INTO buy_book (buy_id, book_id, amount)
SELECT 5, book_id, 1
FROM book b
     JOIN author a USING(author_id)
WHERE a.name_author LIKE 'Булгаков%' AND 
      b.title = 'Белая гвардия'

/* OR*/

INSERT INTO buy_book (buy_id, book_id, amount)
VALUES
(5, (SELECT book_id FROM book b
     JOIN author a USING(author_id)
WHERE a.name_author LIKE 'Пастернак%' AND 
      b.title = 'Лирика'), 2),
(5, (SELECT book_id FROM book b
     JOIN author a USING(author_id)
WHERE a.name_author LIKE 'Булгаков%' AND 
      b.title = 'Белая гвардия'), 1)


/* Количество тех книг на складе, которые были включены в заказ с номером 5, уменьшить на то количество, которое в заказе с номером 5  указано. */
UPDATE book b
     JOIN buy_book bbk USING(book_id)
SET b.amount = b.amount - bbk.amount
WHERE bbk.buy_id = 5 AND bbk.book_id = b.book_id


/* Создать счет (таблицу buy_pay) на оплату заказа с номером 5, в который включить название книг, их автора, цену, количество заказанных книг и  стоимость. 
Последний столбец назвать Стоимость. Информацию в таблицу занести в отсортированном по названиям книг виде.*/
CREATE TABLE buy_pay AS
SELECT bk.title, a.name_author, bk.price, bbk.amount, (bk.price*bbk.amount) AS 'Стоимость'
FROM author a
     JOIN book bk USING(author_id)
     JOIN buy_book bbk USING(book_id)
WHERE bbk.buy_id = 5
ORDER BY bk.title


/*Создать общий счет (таблицу buy_pay) на оплату заказа с номером 5. 
Куда включить номер заказа, количество книг в заказе (название столбца Количество) и его общую стоимость (название столбца Итого).  
Для решения используйте ОДИН запрос.*/ ---- Можно решить и с группировкой!!! ----
CREATE TABLE buy_pay AS
SELECT bbk.buy_id, SUM(bbk.amount) AS 'Количество', SUM(bbk.amount * b.price) AS 'Итого'
FROM book b
    JOIN buy_book bbk USING(book_id)
WHERE bbk.buy_id = 5;


/* В таблицу buy_step для заказа с номером 5 включить все этапы из таблицы step, которые должен пройти этот заказ. 
В столбцы date_step_beg и date_step_end всех записей занести Null */
INSERT INTO buy_step(buy_id, step_id, date_step_beg, date_step_end)
SELECT b.buy_id, s.step_id, NULL, NULL
FROM buy b 
     CROSS JOIN 
     step s 
WHERE b.buy_id = 5


/* В таблицу buy_step занести дату 12.04.2020 выставления счета на оплату заказа с номером 5.
Правильнее было бы занести не конкретную, а текущую дату. Это можно сделать с помощью функции Now(). 
Но при этом в разные дни будут вставляться разная дата, и задание нельзя будет проверить, поэтому  вставим дату 12.04.2020.*/
UPDATE buy_step
SET buy_step.date_step_beg = '2020-04-12'
WHERE buy_id = 5 AND buy_step.step_id = 
           (SELECT step_id
            FROM step
            WHERE name_step = 'Оплата');


 /* Завершить этап «Оплата» для заказа с номером 5, вставив в столбец date_step_end дату 13.04.2020, и начать следующий этап («Упаковка»), 
 задав в столбце date_step_beg для этого этапа ту же дату. Реализовать два запроса для завершения этапа и начале следующего. 
 Они должны быть записаны в общем виде, чтобы его можно было применять для любых этапов, изменив только текущий этап. 
 Для примера пусть это будет этап «Оплата». */
 UPDATE buy_step
SET buy_step.date_step_end = '2020-04-13'
WHERE buy_id = 5 AND step_id = (SELECT step_id
                 FROM step
                 WHERE name_step = 'Оплата');
                 
UPDATE buy_step
SET buy_step.date_step_beg = '2020-04-13'
WHERE buy_id = 5 AND step_id = (SELECT step_id
                 FROM step
                 WHERE name_step = 'Упаковка');          



/*Необходимо узнать на каком сейчас этапе все незавершённые заказы.
Создать таблицу step_now с указанием Имени клиента, названия книги, даты текущего этапа и названия этапа.*/

CREATE TABLE step_now AS
SELECT c.name_client, bk.title, bs.date_step_beg, s.name_step
FROM client c
     JOIN buy b USING(client_id)
     JOIN buy_step bs USING(buy_id)
     JOIN step s USING(step_id)
     JOIN buy_book bbk USING(buy_id)
     JOIN book bk USING(book_id)
WHERE bs.date_step_beg IS NOT NULL AND bs.date_step_end IS NULL;
