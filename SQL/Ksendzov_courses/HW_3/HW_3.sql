CREATE TABLE employees(
	id serial PRIMARY KEY,
	employee_name varchar(50) NOT NULL
);

--2)
INSERT INTO employees(employee_name)
VALUES('Philip'), ('Davie'),('TerrySuilven'),('Hamza'),('Maryk'),('Ruslan'),('Musse'),('Dylan-Jack'),('Gurdeep'),('Thierry'),('Gavin'),('Mikee'),('Bob'),('Creag'),
('Heddle'),('Kyren'),('Hamish'),('Prithvi'),('Kehinde'),('Kyel'),('Adam'),('Muneeb'),('Ramsay'),('Khai'),('Coban'),('Greig'),('Harish'),('Muneeb'),('Ashley'),
('Danny'),('Zainedin'),('Maddox'),('Lovell'),('Milo'),('Jaeda'),('Brisia'),('Kazzandra'),('Mystery'),('Neely'),('Dymin'),('Camie'),('Malasia'),('Joscelyn'),('Shamika'),
('Tamia'),('Jennae'),('Kaylanie'),('Tiffiney'),('Tranae'),('Kashauna'),('Sarita'),('Shyane'),('Alaijah'),('Faithlynn'),('Meenakshi'),('Mitali'),('Rossy'),
('Jaquisha'),('Bethani'),('Pearla'),('Tanesha'),('Shailah'),('Tylesha'),('Shadiamond'),('Freedom'),('Vida'),('Lauren'),('Jamison'),('Glorious'),('Lida');

--3)		
CREATE TABLE salary(
	id serial PRIMARY KEY,
	monthly_salary int  NOT NULL
);

--4)
INSERT INTO salary(monthly_salary)
VALUES(1000),(1100),(1200),(1300),(1400),(1500),(1600),(1700),(1800),(1900),(2000),(2100),(2200),(2300),(2400),(2500);


--5)
CREATE TABLE employee_salary(
	id serial PRIMARY KEY,
	employee_id int NOT NULL UNIQUE,
	salary_id int NOT NULL
)

--6)
INSERT INTO employee_salary(employee_id, salary_id)
VALUES(3,7),(1,4),(5,9),(40,13),(23,4),(11,2),(52,10),(15,13),(26,4),(16,1),
      (33,7),(2,16),(4,15),(6,14),(12,8),(17,9),(19,10),(20,10),(22,10),(24,7),
      (7,1),(8,2),(9,3),(10,4),(14,5),(13,11),(18,12),(71,13),(83,13),(95,15),
      (21,1),(30,2),(25,3),(72,4),(80,6),(81,7),(88,13),(92,12),(74,14),(75,15);

     
--7)
CREATE TABLE roles(
	id serial PRIMARY KEY,
	role_name int NOT NULL UNIQUE
)


--8)
ALTER TABLE roles ALTER COLUMN role_name TYPE varchar(30);

--9)
INSERT INTO roles(role_name)
VALUES('Junior Python developer'),
('Middle Python developer'),
('Senior Python developer'),
('Junior Java developer'),
('Middle Java developer'),
('Senior Java developer'),
('Junior JavaScript developer'),
('Middle JavaScript developer'),
('Senior JavaScript developer'),
('Junior Manual QA engineer'),
('Middle Manual QA engineer'),
('Senior Manual QA engineer'),
('Project Manager'),
('Designer'),
('HR'),
('CEO'),
('Sales manager'),
('Junior Automation QA engineer'),
('Middle Automation QA engineer'),
('Senior Automation QA engineer');

--10)
CREATE TABLE roles_employee(
	id serial PRIMARY KEY,
	employee_id int NOT NULL UNIQUE,
	role_id int NOT NULL,
	foreign key(employee_id) references employees(id),
	foreign key(role_id) references roles(id)
)


SELECT * FROM salary;
SELECT * FROM roles;
SELECT * FROM roles_employee;
SELECT * FROM employee_salary;
SELECT * FROM employees;
SELECT e.employee_name, s.monthly_salary, r.role_name  FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id;



--1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
SELECT e.employee_name, s.monthly_salary 
FROM employees e JOIN employee_salary es  ON e.id  = es.employee_id 
			     JOIN salary s ON es.salary_id = s.id;
			     
--2. Вывести всех работников у которых ЗП меньше 2000.
SELECT e.employee_name
FROM  employees e JOIN employee_salary es  ON e.id  = es.employee_id 
	  JOIN salary s ON es.salary_id = s.id
WHERE s.monthly_salary < 2000;
			     
--3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
SELECT s.monthly_salary 
FROM  employees e FULL JOIN employee_salary es  ON e.id  = es.employee_id 
	  FULL JOIN salary s ON es.salary_id = s.id
WHERE e.employee_name IS null;


--4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
SELECT s.monthly_salary 
FROM  employees e FULL JOIN employee_salary es  ON e.id  = es.employee_id 
	  FULL JOIN salary s ON es.salary_id = s.id
WHERE e.employee_name IS NULL AND s.monthly_salary < 2000;
 
--5. Найти всех работников кому не начислена ЗП.
SELECT e.employee_name
FROM  employees e FULL JOIN employee_salary es  ON e.id  = es.employee_id 
	  FULL JOIN salary s ON es.salary_id = s.id
WHERE  s.monthly_salary IS NULL;
 
--6. Вывести всех работников с названиями их должности.
SELECT e.employee_name, r.role_name 
FROM  employees e FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id 
WHERE  r.role_name IS NOT NULL AND e.employee_name IS NOT NULL;

--7. Вывести имена и должность только Java разработчиков.
SELECT e.employee_name, r.role_name 
FROM  employees e FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id 
WHERE  r.role_name like  '%Java%' AND e.employee_name IS NOT NULL;
 
--8. Вывести имена и должность только Python разработчиков.
 SELECT e.employee_name, r.role_name 
FROM  employees e FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id 
WHERE  r.role_name like  '%Python%' AND e.employee_name IS NOT NULL;

--9. Вывести имена и должность всех QA инженеров.
SELECT e.employee_name, r.role_name 
FROM  employees e FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id 
WHERE  r.role_name like  '%QA%' AND e.employee_name IS NOT NULL;
 
--10. Вывести имена и должность ручных QA инженеров.
SELECT e.employee_name, r.role_name 
FROM  employees e FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id 
WHERE  r.role_name like  '%Manual%QA%' AND e.employee_name IS NOT NULL;
 
--11. Вывести имена и должность автоматизаторов QA
SELECT e.employee_name, r.role_name 
FROM  employees e FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id 
WHERE  r.role_name like  '%Automation%QA%' AND e.employee_name IS NOT NULL;

--12. Вывести имена и зарплаты Junior специалистов
SELECT e.employee_name, s.monthly_salary 
FROM  employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id  
WHERE  r.role_name like  '%Junior%' AND e.employee_name IS NOT NULL AND s.monthly_salary IS NOT NULL;
 
--13. Вывести имена и зарплаты Middle специалистов
SELECT e.employee_name, s.monthly_salary 
FROM  employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id  
WHERE  r.role_name like  '%Middle%' AND e.employee_name IS NOT NULL AND s.monthly_salary IS NOT NULL;
 
--14. Вывести имена и зарплаты Senior специалистов
SELECT e.employee_name, s.monthly_salary 
FROM  employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id  
WHERE  r.role_name like  '%Senior%' AND e.employee_name IS NOT NULL AND s.monthly_salary IS NOT NULL;
 
--15. Вывести зарплаты Java разработчиков
SELECT s.monthly_salary, r.role_name  
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%Java%' AND s.monthly_salary IS NOT NULL;
 
--16. Вывести зарплаты Python разработчиков
SELECT s.monthly_salary, r.role_name  
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%Python%' AND s.monthly_salary IS NOT NULL;
 
--17. Вывести имена и зарплаты Junior Python разработчиков
SELECT e.employee_name, s.monthly_salary  
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%Junior%Python%' AND s.monthly_salary IS NOT NULL;
 
--18. Вывести имена и зарплаты Middle JS разработчиков
SELECT e.employee_name, s.monthly_salary  
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%Middle%JavaScript%' AND s.monthly_salary IS NOT NULL;
 
--19. Вывести имена и зарплаты Senior Java разработчиков
SELECT e.employee_name, s.monthly_salary  
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%Senior%Java%' AND s.monthly_salary IS NOT NULL;
 
--20. Вывести зарплаты Junior QA инженеров
SELECT s.monthly_salary, r.role_name  
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%Junior%QA%' AND s.monthly_salary IS NOT NULL;
 
--21. Вывести среднюю зарплату всех Junior специалистов
SELECT  avg(s.monthly_salary)
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%Junior%';

--22. Вывести сумму зарплат JS разработчиков
SELECT  sum(s.monthly_salary)
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%JavaScript%';
 
-- 23. Вывести минимальную ЗП QA инженеров
SELECT  min(s.monthly_salary)
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%QA engineer%';

-- 24. Вывести максимальную ЗП QA инженеров
SELECT  max(s.monthly_salary) as "максимальная ЗП QA инженеров"
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%QA engineer%';

-- 25. Вывести количество QA инженеров
SELECT  count(r.role_name) as "количество QA инженеров"
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%QA engineer%';

-- 26. Вывести количество Middle специалистов.
SELECT  count(r.role_name) as "количество Middle специалистов"
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%Middle%';

-- 27. Вывести количество разработчиков
SELECT  count(*) as "количество разработчиков"
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%developer%';		

-- 28. Вывести фонд (сумму) зарплаты разработчиков.
SELECT  sum(s.monthly_salary) as "Фонд зарплат разработчиков"
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE r.role_name like  '%developer%';

-- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию
SELECT  e.employee_name, r.role_name, s.monthly_salary  
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE e.employee_name IS NOT NULL AND r.role_name IS NOT NULL AND s.monthly_salary IS NOT NULL			
ORDER BY s.monthly_salary;

-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
SELECT  e.employee_name, r.role_name, s.monthly_salary  
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE e.employee_name IS NOT NULL AND r.role_name IS NOT NULL AND s.monthly_salary IS NOT NULL 
					  AND s.monthly_salary BETWEEN 1700 AND  2300  	
ORDER BY s.monthly_salary;

-- 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
SELECT  e.employee_name, r.role_name, s.monthly_salary  
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE e.employee_name IS NOT NULL AND r.role_name IS NOT NULL AND s.monthly_salary IS NOT NULL 
					  AND s.monthly_salary < 2300  	
ORDER BY s.monthly_salary;

-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
SELECT  e.employee_name, r.role_name, s.monthly_salary  
FROM employees e FULL JOIN employee_salary es  ON e.id = es.employee_id 
			FULL JOIN salary s  ON  es.salary_id = s.id
			FULL JOIN roles_employee re ON e.id = re.employee_id 
			FULL JOIN roles r ON r.id = re.role_id
WHERE e.employee_name IS NOT NULL AND r.role_name IS NOT NULL AND s.monthly_salary IS NOT NULL 
					  AND s.monthly_salary IN (1100, 1500, 2000) 	
ORDER BY s.monthly_salary;

