CREATE DATABASE "Lab1";

\c Lab1

CREATE TABLE users(
    id INTEGER,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

ALTER TABLE users
ADD COLUMN isadmin INTEGER;

ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN USING (isadmin = 1);

ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT FALSE;

ALTER TABLE users
ADD PRIMARY KEY (id);

CREATE TABLE tasks(
    id INT,
    name VARCHAR(50),
    user_id INT
);

DROP TABLE tasks;

DROP DATABASE "Lab1";