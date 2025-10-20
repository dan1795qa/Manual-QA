-- На основании таблицы Student создайте представление ViewStudent, содержащие только поля id, first_name и last_name.

create view ViewStudent as 
select id, first_name, last_name
from Student