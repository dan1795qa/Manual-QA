Выведите идентификаторы товаров (поле good) из таблицы Payments, стоимость которых больше 2000 единиц. Стоимость товара хранится в поле unit_price.

select good
from Payments
where unit_price > 2000



Выведите имена (поле member_name) членов семьи из таблицы FamilyMembers, чей статус (поле status) равен "father".

select member_name
from FamilyMembers
where status = 'father'



Выведите имя (поле member_name) и дату рождения (поле birthday) членов семьи из таблицы FamilyMembers, чей статус (поле status) равен "father" или "mother".

select member_name, birthday
from FamilyMembers
where status = 'father' or status = 'mother'


Выведите идентификаторы товаров (поле good) из таблицы Payments, стоимость которых больше 2000 единиц. Стоимость товара хранится в поле unit_price.

select good
from Payments
where unit_price > 2000