Для каждого отдельного платежа выведите идентификатор товара и сумму, потраченную на него, в отсортированном по убыванию этой суммы виде. Список платежей находится в таблице Payments.
Для вывода суммы используйте псевдоним sum.

select good, (amount * unit_price) as 'sum'
from Payments
order by sum DESC



Выведите все данные членов семьи с фамилией Quincey из таблицы FamilyMembers и отсортируйте их по возрастанию сначала по столбцу status, а затем по member_name.

select *
from FamilyMembers
where member_name regexp '(Quincey)'
order by status, member_name
