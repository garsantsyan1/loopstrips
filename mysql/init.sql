-- Создание таблицы codes
CREATE DATABASE IF NOT EXISTS loopstrips CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE loopstrips;

CREATE TABLE IF NOT EXISTS codes
(
    id         VARCHAR(255) PRIMARY KEY,
    scan_count INT DEFAULT 0,
    flavor     VARCHAR(255)
) CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

DELIMITER //
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
                            ELT(flavor_index + 1, 'Мята', 'Виноград', 'Яблоко', 'Персик', 'Клубника'));
                    SET i = i + 1;
                END WHILE;
            SET flavor_index = flavor_index + 1;
        END WHILE;
END //
DELIMITER ;

CALL generate_flavored_codes();