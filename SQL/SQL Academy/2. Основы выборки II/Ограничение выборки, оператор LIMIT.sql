Отсортируйте список компаний (таблица Company) по их названию в алфавитном порядке и выведите первые две записи.

SELECT *
FROM Company
ORDER BY Company.name
LIMIT 2




Выведите начало (поле start_pair) и окончание (поле end_pair) второго и третьего занятия из таблицы Timepair.

SELECT start_pair, end_pair
FROM Timepair
LIMIT 2 OFFSET 1