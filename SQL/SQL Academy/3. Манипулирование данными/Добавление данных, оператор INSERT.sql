-- Добавьте новый товар в таблицу Goods с именем «Table» и типом «equipment».
-- В качестве первичного ключа (good_id) укажите количество записей в таблице + 1.

INSERT INTO Goods 
SELECT MAX(good_id) + 1, 'Table', (select good_type_id from GoodTypes
where good_type_name = 'equipment') FROM Goods;