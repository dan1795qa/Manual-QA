-- Создать таблицу author
CREATE TABLE author
(author_id INT PRIMARY KEY AUTO_INCREMENT,
 name_author VARCHAR(50)
 );


 -- Заполнить таблицу author
 INSERT INTO author (name_author)
VALUES 
('Булгаков М.А.'),
('Достоевский Ф.М.'),
('Есенин С.А.'),
('Пастернак Б.Л.')


-- Создание таблицы с внешними ключами
-- Перепишите запрос на создание таблицы book , чтобы ее структура соответствовала структуре, показанной на логической схеме
CREATE TABLE book
(book_id INT PRIMARY KEY AUTO_INCREMENT,
 title VARCHAR(50),
 author_id INT NOT NULL,
 genre_id INT,
 price DECIMAL(8,2),
 amount INT,
 FOREIGN KEY (author_id) REFERENCES author (author_id),
 FOREIGN KEY (genre_id) REFERENCES genre (genre_id)
);


-- Действия при удалении записи главной таблицы

(ПРИМИЧАНИЕ!!! 
CASCADE: автоматически удаляет строки из зависимой таблицы при удалении  связанных строк в главной таблице.
SET NULL: при удалении  связанной строки из главной таблицы устанавливает для столбца внешнего ключа значение NULL. (В этом случае столбец внешнего ключа должен поддерживать установку NULL).
SET DEFAULT похоже на SET NULL за тем исключением, что значение  внешнего ключа устанавливается не в NULL, а в значение по умолчанию для данного столбца.
RESTRICT: отклоняет удаление строк в главной таблице при наличии связанных строк в зависимой таблице.)

-- Создать таблицу book той же структуры, что и на предыдущем шаге. 
-- Будем считать, что при удалении автора из таблицы author, должны удаляться все записи о книгах из таблицы book, написанные этим автором. 
-- А при удалении жанра из таблицы genre для соответствующей записи book установить значение Null в столбце genre_id. 
CREATE TABLE book
(book_id INT PRIMARY KEY AUTO_INCREMENT,
 title VARCHAR(50),
 author_id INT NOT NULL,
 genre_id INT,
 price DECIMAL(8,2),
 amount INT,
 FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE,
 FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE SET NULL 
);