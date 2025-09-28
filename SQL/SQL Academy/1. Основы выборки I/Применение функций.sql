"Выведите текст 'Hello world' в нижнем регистре с помощью соответствующей функции.
Для вывода текста используйте псевдоним lower_string."

SELECT  LOWER('Hello world') AS lower_string




"Выведите полное имя члена семьи и его год рождения, используя функцию YEAR.
Для вывода года рождения используйте псевдоним year_of_birth."

SELECT member_name, year(birthday) as year_of_birth
from FamilyMembers



"Выведите полное имя члена семьи и длину его фамилии.
Для вывода длины фамилии используйте псевдоним lastname_length."

select member_name, LENGTH(member_name) - INSTR(member_name, ' ') AS 'lastname_length'
from FamilyMembers