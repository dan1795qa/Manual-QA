-- С помощью коррелированного подзапроса выведите имена всех членов семьи (member_name) и цену их самого дорогого купленного товара.
-- Для вывода цены самого дорогого купленного товара используйте псевдоним good_price. Если такого товара нет, выведите NULL.

select member_name,
(select max(unit_price) from Payments
where FamilyMembers.member_id = Payments.family_member)
as good_price
from FamilyMembers