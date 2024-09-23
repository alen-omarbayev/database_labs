-- 1
CREATE DATABASE "lab2"
\c lab2
-- 2
CREATE TABLE countries(
    country_id INT PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INT,
    population INT
);
-- 3
INSERT INTO countries VALUES (1, 'Kazakhstan', 1, 20);
-- 4
INSERT INTO countries (country_id, country_name) VALUES (2, 'Brazil');
-- 5
INSERT INTO countries (country_id, country_name, region_id, population) VALUES (3, 'Spain', NULL, 5155100);
-- 6
INSERT INTO countries (country_id, country_name, region_id, population) VALUES
    (4, 'Poland', 4, 41412),
    (5, 'USA', 5, 25000),
    (6, 'Vietnam', 10, 524895);
-- 7
ALTER TABLE countries ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';
-- 8
INSERT INTO countries (country_id,country_name, region_id, population) VALUES (7,DEFAULT, 2, 2000000);
-- 9
INSERT INTO countries DEFAULT VALUES;
-- 10
CREATE TABLE countries_new (LIKE countries INCLUDING ALL);
-- 11
INSERT INTO countries_new SELECT * FROM countries;
-- 12
UPDATE countries_new SET region_id = 1 WHERE region_id IS NULL;
-- 13
UPDATE countries_new
SET population = population * 1.1
RETURNING country_name, population AS New_Population;
-- 14
DELETE FROM countries WHERE population < 100000;
-- 15
DELETE FROM countries_new USING countries WHERE countries_new.country_id = countries.country_id RETURNING countries_new.*;
-- 16
DELETE FROM countries RETURNING *;