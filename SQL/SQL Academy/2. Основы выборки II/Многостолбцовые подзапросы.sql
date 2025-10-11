-- Выведите список комнат (все поля, таблица Rooms), которые по своим удобствам (has_tv, has_internet, has_kitchen, has_air_con) совпадают с комнатой с идентификатором "11".

SELECT *
FROM Rooms
WHERE (has_tv, has_internet, has_kitchen, has_air_con) IN (
    SELECT has_tv, has_internet, has_kitchen, has_air_con
    FROM Rooms
    WHERE Rooms.id = '11')