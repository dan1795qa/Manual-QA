/* Создать вспомогательную таблицу applicant,  куда включить id образовательной программы,  id абитуриента, сумму баллов абитуриентов (столбец itog) в отсортированном сначала 
по id образовательной программы, а потом по убыванию суммы баллов виде (использовать запрос из предыдущего урока).*/
CREATE TABLE applicant
SELECT pr.program_id, erl.enrollee_id, SUM(erl_sbj.result)AS 'itog'
FROM program pr
     JOIN program_enrollee pr_erl USING(program_id)
     JOIN enrollee erl USING(enrollee_id)
     JOIN enrollee_subject erl_sbj USING(enrollee_id)
     JOIN program_subject pr_sbj USING(subject_id, program_id)
GROUP BY pr.program_id, erl.enrollee_id
ORDER BY pr.program_id, itog DESC;


/*Из таблицы applicant,  созданной на предыдущем шаге, удалить записи, если абитуриент на выбранную образовательную программу не набрал минимального 
балла хотя бы по одному предмету (использовать запрос из предыдущего урока).*/
DELETE 
FROM applicant
WHERE (program_id, enrollee_id) IN
(SELECT pr.program_id, erl.enrollee_id
FROM program pr 
     JOIN program_enrollee pr_erl USING(program_id)
     JOIN enrollee erl USING(enrollee_id)
     JOIN enrollee_subject erl_sbj USING(enrollee_id)
     JOIN subject sbj USING(subject_id)
     JOIN program_subject pr_sbj USING(subject_id, program_id)
WHERE erl_sbj.result <= pr_sbj.min_result)
/*OR*/
DELETE
FROM applicant
USING applicant 
      JOIN program_subject USING(program_id)
      JOIN enrollee_subject USING(enrollee_id, subject_id)
WHERE enrollee_subject.result <= program_subject.min_result


/*Повысить итоговые баллы абитуриентов в таблице applicant на значения дополнительных баллов (использовать запрос из предыдущего урока).*/
UPDATE applicant
JOIN (SELECT erl_ach.enrollee_id, IF(SUM(ach.bonus) IS NULL, 0, SUM(ach.bonus)) AS 'Бонус'
FROM  enrollee_achievement erl_ach 
     LEFT JOIN achievement ach USING(achievement_id)
GROUP BY erl_ach.enrollee_id
ORDER BY erl_ach.enrollee_id) AS bonus ON applicant.enrollee_id = bonus.enrollee_id
SET itog = applicant.itog + bonus.Бонус;


/*Поскольку при добавлении дополнительных баллов, абитуриенты по каждой образовательной программе могут следовать не в порядке убывания суммарных баллов, 
необходимо создать новую таблицу applicant_order на основе таблицы applicant. При создании таблицы данные нужно отсортировать сначала 
по id образовательной программы, потом по убыванию итогового балла. А таблицу applicant, которая была создана как вспомогательная, необходимо удалить.*/
CREATE TABLE applicant_order AS
SELECT program_id, enrollee_id, itog
FROM applicant
ORDER BY program_id, itog DESC;

DROP TABLE applicant;


/*ЗАДАНИЕ НОВОЕ НА ALTER TABLE*/

Для вставки нового столбца используется SQL запросы:
ALTER TABLE таблица ADD имя_столбца тип; - вставляет столбец после последнего
ALTER TABLE таблица ADD имя_столбца тип FIRST; - вставляет столбец перед первым
ALTER TABLE таблица ADD имя_столбца тип AFTER имя_столбца_1; - вставляет столбец после укзанного столбца

Для удаления столбца используется SQL запросы:
ALTER TABLE таблица DROP COLUMN имя_столбца; - удаляет столбец с заданным именем
ALTER TABLE таблица DROP имя_столбца; - ключевое слово COLUMN не обязательно указывать
ALTER TABLE таблица DROP имя_столбца,
                    DROP имя_столбца_1; - удаляет два столбца

Для переименования столбца используется  запрос (тип данных указывать обязательно):
ALTER TABLE таблица CHANGE имя_столбца новое_имя_столбца ТИП ДАННЫХ;

Для изменения типа  столбца используется запрос (два раза указывать имя столбца обязательно): 
ALTER TABLE таблица CHANGE имя_столбца имя_столбца НОВЫЙ_ТИП_ДАННЫХ;

/*Включить в таблицу applicant_order новый столбец str_id целого типа , расположить его перед первым.*/
ALTER TABLE applicant_order 
ADD str_id INT FIRST



/*ЗАДАНИЕ НОВОЕ НА Нумерация строк*/
/*Занести в столбец str_id таблицы applicant_order нумерацию абитуриентов, которая начинается с 1 для каждой образовательной программы.*/
SET @num_pr := 0;
SET @row_num := 1;
UPDATE applicant_order
    SET str_id = IF(program_id = @num_pr, @row_num := @row_num + 1, @row_num := 1 AND @num_pr := @num_pr + 1);


/*Создать таблицу student,  в которую включить абитуриентов, которые могут быть рекомендованы к зачислению  в соответствии с планом набора. 
Информацию отсортировать сначала в алфавитном порядке по названию программ, а потом по убыванию итогового балла.*/
CREATE TABLE student
SELECT pr.name_program, erl.name_enrollee, apl_ord.itog
FROM program pr
      JOIN applicant_order apl_ord USING(program_id)
      JOIN enrollee erl USING(enrollee_id)
WHERE apl_ord.str_id <= pr.plan
ORDER BY pr.name_program, apl_ord.itog DESC;



/*---------------------------------------------------------------------ЗАДАНИЯ-------------------------------------------------------------------------*/


