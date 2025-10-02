Выведите имена first_name и фамилии last_name студентов из таблицы Student, у кого отсутствует отчество middle_name

select first_name, last_name
from Student
where middle_name is null




Выведите резервации комнат (поля room_id, start_date, end_date) из таблицы Reservations, у которых итоговая стоимость аренды (поле total) находится в промежутке от 500 до 1200 включительно.

select room_id, start_date, end_date
from Reservations
where total between 500 and 1200




Выведите информацию о студентах из таблицы Student, у которых год рождения соответствует одному из перечисленных: 2000, 2002 и 2004.

select *
from Student
where YEAR(birthday) in ('2000', '2002', '2004')