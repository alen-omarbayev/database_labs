-- 1
create database lab6;

-- 2
create table locations (
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

CREATE TABLE departments (
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations(location_id)
);

CREATE TABLE employees (
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments(department_id)
);

-- insertions
insert into locations (street_address, postal_code, city, state_province) values
    ('123 Main St', '12345', 'New York', 'NY'),
    ('456 Oak Ave', '67890', 'Los Angeles', 'CA'),
    ('789 Pine Rd', '54321', 'Chicago', 'IL'),
    ('321 Maple Dr', '09876', 'Houston', 'TX');

insert into departments (department_name, budget, location_id) values
    ('Sales', 500000, 1),
    ('Marketing', 300000, 2),
    ('IT', 400000, 3),
    ('HR', 200000, 4);

insert into employees (first_name, last_name, email, phone_number, salary, department_id) values
    ('John', 'Doe', 'johndoe@example.com', '555-1234', 60000, 1),
    ('Jane', 'Smith', 'janesmith@example.com', '555-5678', 65000, 2),
    ('Alice', 'Johnson', 'alicej@example.com', '555-8765', 70000, 3),
    ('Bob', 'Brown', 'bobb@example.com', '555-4321', 55000, 1),
    ('Carol', 'White', 'carolw@example.com', '555-3456', 60000, 4);

-- 3
select employees.first_name, employees.last_name, employees.department_id, departments.department_name from employees left join departments on employees.department_id = departments.department_id;

-- 4
insert into departments (department_id, department_name, budget, location_id)
values (40, 'Temp Department 40', 100000, 1), (80, 'Temp Department 80', 150000, 2);

insert into employees (first_name, last_name, email, phone_number, salary, department_id)
values ('Alen', 'Omarbayev', 'alen_omarbayev@gmail.com', '555-1244', 500000, 40),
('Leo', 'Messi', 'leo_messi@gmail.com', '555-1223', 14500, 80);

select employees.first_name, employees.last_name, employees.department_id, departments.department_name
from employees join departments on employees.department_id = departments.department_id
where employees.department_id in (80, 40);

-- 5
select employees.first_name, employees.last_name, departments.department_name, locations.city, locations.state_province
from employees join departments on employees.department_id = departments.department_id
join locations on departments.location_id = locations.location_id;

-- 6
select departments.department_name from departments
left join employees on departments.department_id = employees.department_id
where employee_id is null;

-- 7
select employees.first_name, employees.last_name, employees.department_id,departments.department_name
from employees left join departments on employees.department_id = departments.department_id;