Найдите все жилые помещения (таблица Rooms), в адресе которых содержится строка «Avenue». В результирующей выборке выведите поля id и address.

select id, address
from Rooms
where address regexp '(Avenue)'



Выведите name, email пользователей, чей адрес электронной почты заканчивается на «@outlook.com» или «@live.com».

select name, email
from Users
where email regexp '(@outlook.com|@live.com)$' 