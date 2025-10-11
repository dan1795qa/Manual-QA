Выведите названия товаров из таблицы Goods (поле good_name), которые ещё ни разу не покупались ни одним из членов семьи (таблица Payments).

select good_name
from Goods
where good_id not in (select good from Payments)