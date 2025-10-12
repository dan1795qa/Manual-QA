-- Из таблицы Rooms выведите идентификаторы сдаваемых жилых помещений (поле id) и наличие телевизора в помещении: если телевизор присутствует выведите «YES», иначе «NO».
-- Для вывода наличия телевизора используйте псевдоним has_tv.

select id, if(has_tv = True, "YES", "NO") as has_tv
from Rooms



-- Из таблицы Teacher выведите имена (поле first_name), отчества (поле middle_name) и фамилии (поле last_name) учителей. Если отчество у учителя отсутствует, выведите в поле middle_name значение «Empty».

SELECT Teacher.first_name, IFNULL(Teacher.middle_name, 'Empty') AS 'middle_name', Teacher.last_name
FROM Teacher