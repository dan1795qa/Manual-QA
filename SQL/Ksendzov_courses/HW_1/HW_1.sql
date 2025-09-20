--1)
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
		
SELECT * FROM employees;

--3)		
CREATE TABLE salary(
	id serial PRIMARY KEY,
	monthly_salary int  NOT NULL
);

--4)
INSERT INTO salary(monthly_salary)
VALUES(1000),(1100),(1200),(1300),(1400),(1500),(1600),(1700),(1800),(1900),(2000),(2100),(2200),(2300),(2400),(2500);

SELECT * FROM salary;

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
     
SELECT * FROM employee_salary;
     
--7)
CREATE TABLE roles(
	id serial PRIMARY KEY,
	role_name int NOT NULL UNIQUE
)


SELECT * FROM roles;

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

--11)
INSERT INTO roles_employee(employee_id, role_id)
VALUES(7,2),(20,4),(3,9),(5,13),(23,4),(11,2),(10,19),(22,13),(21,3),(34,4),
      (1,1),(6,4),(12,7),(15,10),(18,2),(25,5),(28,8),(31,11),(35,12),(38,14),
      (2,1),(8,4),(13,7),(16,10),(19,2),(26,5),(29,8),(32,11),(36,13),(39,15),
      (4,16),(9,17),(14,18),(17,19),(24,20),(27,19),(30,18),(33,18),(37,12),(40,1);






