/* Вывести абитуриентов, которые хотят поступать на образовательную программу «Мехатроника и робототехника» в отсортированном по фамилиям виде.*/
SELECT name_enrollee
FROM enrollee erl
    JOIN program_enrollee pr_erl USING(enrollee_id)
    JOIN program pr USING(program_id)
WHERE pr.name_program = 'Мехатроника и робототехника'
ORDER BY name_enrollee


/*Вывести образовательные программы, на которые для поступления необходим предмет «Информатика». Программы отсортировать в обратном алфавитном порядке.*/
SELECT name_program
FROM program pr
     JOIN program_subject pr_sbj USING(program_id)
     JOIN subject sbj USING(subject_id)
WHERE sbj.name_subject = 'Информатика'
ORDER BY name_program DESC


/*Выведите количество абитуриентов, сдавших ЕГЭ по каждому предмету, максимальное, минимальное и среднее значение баллов по предмету ЕГЭ. 
Вычисляемые столбцы назвать Количество, Максимум, Минимум, Среднее. 
Информацию отсортировать по названию предмета в алфавитном порядке, среднее значение округлить до одного знака после запятой.*/
SELECT sbj.name_subject, COUNT(erl_sbj.enrollee_id) AS 'Количество', MAX(erl_sbj.result) AS 'Максимум',
       MIN(erl_sbj.result) AS 'Минимум', ROUND(AVG(erl_sbj.result), 1) AS 'Среднее'
FROM subject sbj
       JOIN enrollee_subject erl_sbj USING(subject_id)
GROUP BY sbj.name_subject
ORDER BY name_subject


/*Вывести образовательные программы, для которых минимальный балл ЕГЭ по каждому предмету больше или равен 40 баллам. Программы вывести в отсортированном по алфавиту виде.*/
SELECT pr.name_program
FROM program pr
     JOIN program_subject pr_sbj USING(program_id)
GROUP BY pr.name_program 
HAVING MIN(pr_sbj.min_result) >= 40
ORDER BY pr.name_program


/*Вывести образовательные программы, которые имеют самый большой план набора,  вместе с этой величиной.*/
SELECT name_program, plan
FROM program
WHERE plan = (SELECT MAX(plan) FROM program)


/*Посчитать, сколько дополнительных баллов получит каждый абитуриент. Столбец с дополнительными баллами назвать Бонус. Информацию вывести в отсортированном по фамилиям виде.*/
SELECT erl.name_enrollee, IF(SUM(ach.bonus) IS NULL, 0, SUM(ach.bonus)) AS 'Бонус'
FROM enrollee erl 
     LEFT JOIN enrollee_achievement erl_ach USING(enrollee_id)
     LEFT JOIN achievement ach USING(achievement_id)
GROUP BY erl.name_enrollee
ORDER BY erl.name_enrollee
/* Относительно левой таблицы ставить всем LEFT
ИЛИ
enrollee  
LEFT JOIN (enrollee_achievement INNER JOIN achievement USING(achievement_id)) USING(enrollee_id)*/


/*Выведите сколько человек подало заявление на каждую образовательную программу и конкурс на нее (число поданных заявлений деленное на количество мест по плану), 
округленный до 2-х знаков после запятой. В запросе вывести название факультета, к которому относится образовательная программа, название образовательной программы, 
план набора абитуриентов на образовательную программу (plan), количество поданных заявлений (Количество) и Конкурс. Информацию отсортировать в порядке убывания конкурса.*/
SELECT dpt.name_department, pr.name_program, pr.plan, 
COUNT(pr_enl.enrollee_id) AS 'Количество', 
ROUND(COUNT(pr_enl.enrollee_id)/pr.plan, 2) AS 'Конкурс'
FROM department dpt
  JOIN program pr USING(department_id)
  JOIN program_enrollee pr_enl USING(program_id)
GROUP BY dpt.name_department, pr.name_program, pr.plan
ORDER BY Конкурс DESC


/*Вывести образовательные программы, на которые для поступления необходимы предмет «Информатика» и «Математика» в отсортированном по названию программ виде.*/
SELECT pr.name_program
FROM program pr
    JOIN program_subject pr_sbj USING(program_id)
    JOIN subject sbj USING(subject_id)
WHERE sbj.name_subject IN ('Математика', 'Информатика')
GROUP BY pr.name_program
HAVING COUNT(sbj.name_subject) = 2
ORDER BY pr.name_program


/*Посчитать количество баллов каждого абитуриента на каждую образовательную программу, на которую он подал заявление, по результатам ЕГЭ. 
В результат включить название образовательной программы, фамилию и имя абитуриента, а также столбец с суммой баллов, который назвать itog. 
Информацию вывести в отсортированном сначала по образовательной программе, а потом по убыванию суммы баллов виде.*/
SELECT pr.name_program, erl.name_enrollee, SUM(erl_sbj.result)AS 'itog'
FROM program pr
     JOIN program_enrollee pr_erl USING(program_id)
     JOIN enrollee erl USING(enrollee_id)
     JOIN enrollee_subject erl_sbj USING(enrollee_id)
     JOIN program_subject pr_sbj USING(subject_id, program_id)
GROUP BY pr.name_program, erl.name_enrollee
ORDER BY pr.name_program, itog DESC


/*Вывести название образовательной программы и фамилию тех абитуриентов, которые подавали документы на эту образовательную программу, но не могут быть зачислены на нее. 
Эти абитуриенты имеют результат по одному или нескольким предметам ЕГЭ, необходимым для поступления на эту образовательную программу, меньше минимального балла. 
Информацию вывести в отсортированном сначала по программам, а потом по фамилиям абитуриентов виде.

Например, Баранов Павел по «Физике» набрал 41 балл, а  для образовательной программы «Прикладная механика» минимальный балл по этому предмету определен в 45 баллов. Следовательно, абитуриент на данную программу не может поступить.*/
SELECT DISTINCT pr.name_program, erl.name_enrollee
FROM program pr
     JOIN program_enrollee pr_erl USING(program_id)
     JOIN enrollee erl USING(enrollee_id)
     JOIN enrollee_subject erl_sbj USING(enrollee_id)
     JOIN subject sbj USING(subject_id)
     JOIN program_subject pr_sbj USING(subject_id, program_id)
WHERE erl_sbj.result <= pr_sbj.min_result
ORDER BY pr.name_program, erl.name_enrollee




/*-----------------------------------------------------------------------ЗАДАНИЯ-------------------------------------------------------------------------*/


/*Найти программу, на которую легче всего поступить. Для этого составить список программ с указанием проходного балла и конкурса. 
Отсортировать сначала по проходному баллу, а потом по конкурсу.*/
SELECT pr.name_program, SUM(min_result) AS 'Проходной балл'
FROM program_subject
     JOIN program pr USING(program_id)
GROUP BY pr.program_id;


SELECT pr.name_program, COUNT(pr_erl.enrollee_id)/pr.plan AS 'Конкурс'
FROM program pr
     JOIN program_enrollee pr_erl USING(program_id)
GROUP BY pr_erl.program_id