Подсчитайте количество учеников в каждом классе, а также отсортируйте их по убыванию количества учеников. Принадлежность ученика к конкретному классу вы можете получить из таблицы Student_in_class. В качестве результата необходимо вывести идентификатор класса (поле class) и количество учеников в этом классе.

SELECT class, count(student) AS count 
FROM Student_in_class 
GROUP BY class 
ORDER BY count DESC




Для каждого из существующих статусов (поле status) найдите самого старого человека (используйте поле birthday). Выведите статус и дату рождения.
Для вывода даты рождения используйте псевдоним birthday.

select status, min(birthday) as 'birthday'
from FamilyMembers
group by status





Получите среднее время полётов, совершённых на каждой из моделей самолёта. Выведите поле plane и среднее время полётов в секундах.
Для вывода времени используйте псевдоним time.

select plane, avg(TIMESTAMPDIFF(second, time_out, time_in)) as 'time'
from Trip
group by plane




Выведите идентификатор комнаты (поле room_id), среднюю стоимость за один день аренды (поле price, для вывода используйте псевдоним avg_price), а также количество резерваций этой комнаты (используйте псевдоним count). Полученный результат отсортируйте в порядке убывания сначала по количеству резерваций, а потом по средней стоимости.

select room_id, avg(price) as 'avg_price', count(room_id) as 'count'
from Reservations
group by room_id
order by count desc, avg_price desc