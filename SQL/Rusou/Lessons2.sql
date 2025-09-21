CREATE DATABASE staff; 
SHOW DATABASES;
USE staff;

CREATE TABLE users (
	UserID int NOT NULL AUTO_INCREMENT,
	LastName varchar(255) NOT NULL,
	FirstName varchar(255) NOT NULL,
	Age int,
	Gender varchar(255),
	PRIMARY KEY (UserID)
);

SELECT * FROM users; 

CREATE TABLE bonuses (
	BonusID int NOT NULL AUTO_INCREMENT,
	Month varchar(255) NOT NULL,
	Salary int NOT NULL,
	Holidays int,
	Sick_Leave int,
	Prize int,
	UserID int,
	PRIMARY KEY (BonusID),
	FOREIGN KEY (UserID) REFERENCES
	Users(UserID)
);


SELECT * FROM bonuses; 

ALTER TABLE users
ADD email varchar(255);

ALTER TABLE users
ALTER COLUMN email int;

ALTER TABLE users
DROP COLUMN email;


INSERT INTO users
VALUES (1,'Smith', 'Liza', 24,
'female');


INSERT INTO users (LastName,
FirstName, Gender)
VALUES ('Blue', 'Olga',
'female');


INSERT INTO bonuses
VALUES (1,'January', 1000, 200,
20, 50, 1),
(2,'February', 1000, 300, 30,
40, 1),
(3,'March', 1000, 100, 10, 10,
1);


DELETE FROM users
WHERE FirstName = 'John';

DELETE FROM users;

DROP DATABASE staff;
DROP TABLE users;

DESC users;

SELECT LastName, FirstName
FROM users;


SELECT DISTINCT FirstName
FROM users;

SELECT LastName, FirstName
FROM users
WHERE LastName = 'Ivan';

SELECT Month
FROM bonuses
WHERE salary >= 200;

SELECT LastName, FirstName
FROM users
WHERE FirstName = 'Ivan' AND LastName = 
'Petrov';

SELECT LastName, FirstName
FROM users
WHERE FirstName = 'Ivan' OR LastName = 
'Petrov';

SELECT LastName
FROM users
WHERE NOT FirstName = 'Ivan';

SELECT LastName, FirstName
FROM users
WHERE NOT LastName = 'Smith' AND NOT
FirstName = 'Ivan';

SELECT LastName, FirstName
FROM users
WHERE LastName = 'Smith' AND (AGE > 20 OR
FirstName = 'Ivan');

SELECT * FROM users 
ORDER BY LastName ASC;

SELECT * FROM users 
ORDER BY LastName DESC;

SELECT * FROM users 
ORDER BY LastName, FirstName DESC;

SELECT * FROM users 
ORDER BY LastName ASC, FirstName DESC;

SELECT Age
FROM users
WHERE Gender IS NULL;

SELECT Age
FROM users
WHERE Gender IS NOT NULL;

SELECT Age, LastName
FROM users
WHERE Gender = 'male'
LIMIT 3;

SELECT MIN(Salary)
FROM bonuses;

SELECT MAX(Holidays)
FROM bonuses;

SELECT COUNT(Salary)
FROM bonuses
WHERE Month = 'January';

SELECT AVG(Holidays)
FROM bonuses;

SELECT SUM(Prize)
FROM bonuses;

SELECT * FROM users 
WHERE FirstName LIKE 'Li%';

SELECT * FROM users 
WHERE FirstName LIKE 'Li__';

SELECT * FROM users 
WHERE FirstName LIKE '%i%';

SELECT * FROM users 
WHERE FirstName LIKE '_i%';

SELECT *
FROM bonuses
WHERE Salary BETWEEN 500 AND 1500;

SELECT *
FROM bonuses
WHERE Salary NOT BETWEEN 500 AND 1500;

SELECT *
FROM users
WHERE FirstName BETWEEN 'Liza' AND 'Olga';

SELECT LastName
FROM users
WHERE Age IN (25, 35);

SELECT LastName FROM users
UNION
SELECT LastName FROM customers;

SELECT LastName FROM users
UNION ALL
SELECT LastName FROM customers;

SELECT Count(LastName), Gender
FROM users
WHERE Age > 30
GROUP BY Gender;

SELECT Avg(Salary)
FROM bonuses
WHERE Salary >= 1000
GROUP BY Month;

SELECT COUNT(UserID), Age
FROM users
GROUP BY AGE
HAVING COUNT(UserID) > 1;

CREATE PROCEDURE SelectAllUsers
AS
SELECT * FROM users
GO;

EXEC SelectAllUsers;

SELECT * FROM users;
SELECT * FROM bonuses;
