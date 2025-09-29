Выведите только уникальные имена first_name студентов из таблицы Student.

SELECT DISTINCT first_name
FROM Student;



Выведите только уникальные пары значений идентификатор учителя teacher и идентификатор предмета subject из таблицы Schedule. Пара 2, 3 отличается от 3, 2.

SELECT DISTINCT teacher, subject
FROM Schedule
