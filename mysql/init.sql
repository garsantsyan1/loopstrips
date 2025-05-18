-- Создаём новую базу данных `loopstrips` с поддержкой расширенной кодировки UTF-8,
-- которая позволяет хранить любые символы, включая эмодзи и символы из разных языков.
CREATE DATABASE loopstrips CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


-- Создаём таблицу `codes`, где:
-- `id` — строка (UUID без дефисов) длиной до 255 символов, используется как первичный ключ.
-- `used` — булево значение, по умолчанию FALSE (не использован).
CREATE TABLE codes
(
    id         VARCHAR(255) PRIMARY KEY,
    scan_count INT DEFAULT 0,
    flavor     VARCHAR(255)
);


-- Меняем разделитель команд на `//`, чтобы корректно описать многострочную хранимую процедуру.
DELIMITER //

-- Создаём хранимую процедуру `generate_codes`, которая:
-- - запускает цикл от 0 до 2999 (итого 3000 итераций),
-- - в каждой итерации вставляет уникальный UUID (без дефисов) в таблицу `codes`.
CREATE PROCEDURE generate_flavored_codes()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE flavor_index INT DEFAULT 0;

    WHILE flavor_index < 5
        DO
            SET i = 0;
            WHILE i < 2000
                DO
                    INSERT INTO codes (id, scan_count, flavor)
                    VALUES (REPLACE(UUID(), '-', ''), 0,
                            ELT(flavor_index + 1, 'Мято', 'Виноград', 'Яблоко', 'Персик', 'Клубника'));
                    SET i = i + 1;
                END WHILE;
            SET flavor_index = flavor_index + 1;
        END WHILE;
END;

-- Возвращаем стандартный разделитель `;`.
DELIMITER ;


-- Вызываем процедуру и вставляем 3000 новых кодов в таблицу.
CALL generate_flavored_codes();

-- Удаляем процедуру `generate_codes`, если она больше не нужна.
-- Это хороший способ избежать ошибок "процедура уже существует", если будешь переопределять её.
DROP PROCEDURE IF EXISTS generate_flavored_codes;

-- Считаем общее количество записей в таблице `codes` (после всех операций).
SELECT COUNT(*)
FROM codes;


