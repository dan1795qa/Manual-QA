CREATE TABLE City(
	id serial,
	title varchar(50)
)

CREATE TABLE Person(
	id serial,
	person_name varchar(50),
	city_id int
)


INSERT INTO City(title)
VALUES ('Berlin'),
	('Tokio'),
	('Antalya'),
	('Paris'),
	('Rome')
	
	
	
INSERT INTO Person(person_name, city_id)
VALUES ('Victor', 1),
	('Elena', 2),
	('Anna', 1),
	('Vadim', 3),
	('Ivan', 7),
	('Irina', 9)

SELECT * FROM Person;


SELECT Person.person_name, Person.city_id, City.title, City.id 
FROM Person INNER JOIN City ON Person.city_id = City.id;


SELECT Person.person_name, Person.city_id, City.title, City.id 
FROM Person LEFT JOIN City ON Person.city_id = City.id;

SELECT Person.person_name, Person.city_id, City.title, City.id 
FROM Person RIGHT JOIN City ON Person.city_id = City.id;

SELECT Person.person_name, Person.city_id, City.title, City.id 
FROM Person FULL OUTER JOIN City ON Person.city_id = City.id;

SELECT Person.person_name, Person.city_id, City.title, City.id 
FROM Person CROSS JOIN City;



SELECT *FROM phones_apple;

SELECT * FROM phones_apple
WHERE price > 600;

SELECT * FROM phones_apple
WHERE price IN (750, 700, 1000);


SELECT avg(price)  FROM phones_samsung; 


SELECT * FROM phones_apple
WHERE price > (SELECT avg(price) FROM phones_samsung);

SELECT * FROM phones_apple
WHERE price in  (SELECT price FROM phones_samsung WHERE price < 1000);


SELECT * FROM phones_apple
WHERE price NOT IN  (SELECT price FROM phones_samsung WHERE price < 1000);


SELECT * FROM phones_apple
WHERE price > ALL(SELECT price FROM phones_samsung WHERE price < 1000)
ORDER BY price  desc ;


SELECT * FROM phones_apple
WHERE price > ANY(SELECT price FROM phones_samsung WHERE price < 1000)
ORDER BY price  desc ;


SELECT * FROM phones_apple
WHERE price <> ALL(SELECT price FROM phones_samsung WHERE price < 1000)
ORDER BY price  desc ;


SELECT * FROM phones_apple
WHERE price <> ANY(SELECT price FROM phones_samsung WHERE price < 1000)
ORDER BY price  desc ;




