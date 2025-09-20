/*В таблицу attempt включить новую попытку для студента Баранова Павла по дисциплине «Основы баз данных». Установить текущую дату в качестве даты выполнения попытки.*/
INSERT INTO attempt(student_id, subject_id, date_attempt)
SELECT student_id, subject_id, NOW()
FROM subject, student 
WHERE name_student = 'Баранов Павел' AND name_subject = 'Основы баз данных'



/*Случайным образом выбрать три вопроса (запрос) по дисциплине, тестирование по которой собирается проходить студент, занесенный в таблицу attempt последним, 
и добавить их в таблицу testing.id последней попытки получить как максимальное значение id из таблицы attempt.*/
INSERT INTO testing(attempt_id, question_id)
SELECT attempt_id, question_id
FROM question 
     JOIN attempt USING(subject_id)
WHERE attempt_id = (SELECT MAX(attempt_id) FROM attempt)
ORDER BY RAND()
LIMIT 3


/*Студент прошел тестирование (то есть все его ответы занесены в таблицу testing), далее необходимо вычислить результат(запрос) и занести его в таблицу attempt 
для соответствующей попытки.  Результат попытки вычислить как количество правильных ответов, деленное на 3 (количество вопросов в каждой попытке) и умноженное на 100. 
Результат округлить до целого.
Будем считать, что мы знаем id попытки,  для которой вычисляется результат, в нашем случае это 8.*/
UPDATE attempt 
SET result = (
    SELECT ROUND(SUM(asw.is_correct)/3*100, 2) AS 'result'
    FROM answer asw
         JOIN testing tst USING(answer_id)
    WHERE attempt_id = 8)
WHERE attempt_id = 8


/*Удалить из таблицы attempt все попытки, выполненные раньше 1 мая 2020 года. Также удалить и все соответствующие этим попыткам вопросы из таблицы testing, 
которая создавалась следующим запросом:
CREATE TABLE testing (
    testing_id INT PRIMARY KEY AUTO_INCREMENT, 
    attempt_id INT, 
    question_id INT, 
    answer_id INT,
    FOREIGN KEY (attempt_id)  REFERENCES attempt (attempt_id) ON DELETE CASCADE
);*/
DELETE
FROM attempt
WHERE date_attempt < '2020-05-17';


/*-----------------------------------------------------------------------ЗАДАНИЯ-------------------------------------------------------------------------*/

/*Создать таблицу grade в которую добавить фамилию и имя студентов, имя предмета, дату попытки сдачи, результат и столбец name_grade в которому указать 'Неудовлетворительно', если результат меньше 60, 'Удовлетворительно' если результат больше 60 и 'Отлично' если результат равен 100.*/
CREATE TABLE grade AS
SELECT std.name_student, sbj.name_subject, apt.date_attempt, apt.result, IF(apt.result = 100, 'Отлично', IF(apt.result > 60, 'Удовлетворительно', 'Неудовлетворительно')) AS name_grade  
FROM student std
    JOIN attempt apt USING(student_id)
    JOIN subject sbj USING(subject_id);
/*Второй запрос. Удалить из таблицы attempt попытки с оценкой 'Неудовлетворительно' (использовать столбец name_grade)*/
DELETE
FROM attempt
WHERE result=  ANY(SELECT result FROM grade WHERE name_grade = 'Неудовлетворительно')
