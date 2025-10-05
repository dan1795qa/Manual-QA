Сгруппируйте данные из таблицы Rooms по полю home_type и выведите тип жилья и количество комнат каждого типа. Используйте псевдоним count_rooms для количества комнат.

select home_type, count(home_type) as count_rooms 
from Rooms
group by home_type




Сгруппируйте данные из таблицы Rooms по полям home_type и has_tv. Выведите тип жилья, признак наличия телевизора (поле has_tv) и среднюю цену для каждой группы. Используйте псевдоним avg_price для средней цены.

select home_type, has_tv, avg(price) as avg_price
from Rooms
group by home_type, has_tv