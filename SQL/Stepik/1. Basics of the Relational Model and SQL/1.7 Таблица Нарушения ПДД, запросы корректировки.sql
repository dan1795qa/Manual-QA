-- Создать таблицу fine
CREATE TABLE fine(
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    number_plate VARCHAR(6),
    violation VARCHAR(50),
    sum_fine DECIMAL(8,2),
    date_violation DATE,
    date_payment DATE
    );


-- Добавить в таблицу записи с ключевыми значениями 6, 7, 8.
INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES
('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14', NULL), -- Кавычек в дате может и не быть !!!!!!!
('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL);


-- Использование временного имени таблицы (алиаса)
-- Занести в таблицу fine суммы штрафов, которые должен оплатить водитель, в соответствии с данными из таблицы traffic_violation. При этом суммы заносить только в пустые поля столбца  sum_fine.
UPDATE fine f, traffic_violation tv
SET f.sum_fine = tv.sum_fine
WHERE f.sum_fine IS NULL AND f.violation = tv.violation


-- Группировка данных по нескольким столбцам
-- Вывести фамилию, номер машины и нарушение только для тех водителей, которые на одной машине нарушили одно и то же правило   два и более раз. При этом учитывать все нарушения, независимо от того оплачены они или нет. 
-- Информацию отсортировать в алфавитном порядке, сначала по фамилии водителя, потом по номеру машины и, наконец, по нарушению.
SELECT name, number_plate, violation
FROM fine
GROUP BY name, number_plate, violation
HAVING COUNT(name) >= 2 AND COUNT(number_plate) >= 2 AND COUNT(violation) >= 2
ORDER BY name, number_plate, violation


-- В таблице fine увеличить в два раза сумму неоплаченных штрафов для отобранных на предыдущем шаге записей. 
UPDATE fine, 
 (SELECT name, number_plate, violation
 FROM fine
 GROUP BY name, number_plate, violation
 HAVING COUNT(number_plate) >= 2
 ORDER BY name, number_plate, violation) fine2
SET sum_fine = sum_fine*2
WHERE date_payment IS NULL AND fine.name = fine2.name AND fine.number_plate = fine2.number_plate AND fine.violation = fine2.violation


-- в таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment;
-- уменьшить начисленный штраф в таблице fine в два раза  (только для тех штрафов, информация о которых занесена в таблицу payment) , если оплата произведена не позднее 20 дней со дня нарушения.
UPDATE fine f, payment p
SET f.date_payment = p.date_payment, f.sum_fine = IF(DATEDIFF(p.date_payment, p.date_violation) <= 20, f.sum_fine/2, f.sum_fine)
WHERE f.date_payment IS NULL AND f.name = p.name AND f.number_plate = p.number_plate AND f.violation = p.violation AND f.date_violation = p.date_violation


-- Создать новую таблицу back_payment, куда внести информацию о неоплаченных штрафах (Фамилию и инициалы водителя, номер машины, нарушение, сумму штрафа  и  дату нарушения) из таблицы fine.
CREATE TABLE back_payment AS
SELECT name, number_plate, violation, sum_fine, date_violation
FROM fine
WHERE date_payment IS NULL


-- Удалить из таблицы fine информацию о нарушениях, совершенных раньше 1 февраля 2020 года.
DELETE
FROM fine
WHERE date_violation < '2020-02-01'