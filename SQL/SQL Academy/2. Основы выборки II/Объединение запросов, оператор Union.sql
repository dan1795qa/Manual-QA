-- Выведите полные имена (поля first_name, middle_name и last_name) всех студентов и преподавателей.

SELECT  first_name, middle_name, last_name
FROM Student
UNION ALL
SELECT first_name, middle_name, last_name
FROM Teacher