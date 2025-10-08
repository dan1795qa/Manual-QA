Выведите имя first_name и фамилию last_name каждого учителя из таблицы Teacher, а также количество занятий, в которых он был назначен преподавателем. Если преподаватель не был назначен ни на одно занятие, то выведите 0.
Для вывода количества занятий используйте псевдоним amount_classes.

select Teacher.first_name, Teacher.last_name, count(Schedule.id) as amount_classes
from Teacher 
left join Schedule
on Teacher.id = Schedule.teacher
group by Teacher.first_name, Teacher.last_name