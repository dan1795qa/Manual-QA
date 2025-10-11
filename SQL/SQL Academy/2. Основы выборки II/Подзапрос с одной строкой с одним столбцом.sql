-- Выведите всю информацию о пользователе из таблицы Users, кто является владельцем самого дорогого жилья (таблица Rooms).

SELECT *
FROM Users
WHERE Users.id = (
    select owner_id
    from Rooms 
    where Rooms.price = (
        select max(price)
        from Rooms)
    )