-- Из таблицы Reviews выведите идентификаторы отзывов (поле id) и их категорию: для рейтинга 4-5 проставьте категорию «positive», для 3 проставьте «neutral», а для 1-2 - «negative».
-- Для вывода категории рейтинга используйте псевдоним rating.

select id,
case
when rating = 4 or rating = 5 then "positive"
when rating = 3 then "neutral"
when rating = 1 or rating = 2 then "negative"
else "error"
end as rating
from Reviews