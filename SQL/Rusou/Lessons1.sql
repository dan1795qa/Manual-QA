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
FirstName, Age, Gender)
VALUES ('Black', 'John', 35,
'male');


INSERT INTO bonuses
VALUES (1,'January', 1000, 200,
20, 50, 1),
(2,'February', 1000, 300, 30,
40, 1),
(3,'March', 1000, 100, 10, 10,
1);


DELETE FROM users
WHERE FirstName = 'Liza';

DELETE FROM users;

DROP DATABASE staff;
DROP TABLE users;

DESC users;

SELECT * FROM users;
SELECT * FROM bonuses;
