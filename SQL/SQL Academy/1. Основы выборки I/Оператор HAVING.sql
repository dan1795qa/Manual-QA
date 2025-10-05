Выведите типы комнат (поле home_type) и разницу между самым дорогим и самым дешевым представителем данного типа. В итоговую выборку включите только те типы жилья, количество которых в таблице Rooms больше или равно 2.

select home_type, (max(price) - min(price)) as 'difference'
from Rooms
group by home_type
having count(home_type) >= 2