-- Из таблицы Rooms вывести id, home_type и price у всех жилых помещений, а также в отдельной колонке room_rank вывести ранг данного жилого помещения в его категории (home_type) по цене, используя для этого функцию DENSE_RANK так, чтобы самое дешёвое жилое помещение имело ранг 1, следующие за ним по цене — 2 и так далее.

select id, home_type, price,
DENSE_RANK() OVER(PARTITION BY home_type ORDER BY price) AS 'room_rank'
from Rooms