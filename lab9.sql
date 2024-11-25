create database lab9;

-- 1
create procedure increase_value(value integer) as
    $$
    begin
        value = value + 10;
    end;
    $$
language plpgsql;

call increase_value(30);

-- 2
create function compare_numbers(value1 integer, value2 integer)
    returns varchar as
    $$
    begin
        if value1 < value2 then return 'Lesser';
        elsif value1 > value2 then return 'Greater';
        else return 'Equal';
        end if;
    end;
    $$
language plpgsql;
select compare_numbers(20, 10);

-- 3
create function number_series(n integer) returns text as
    $$
    declare result text := '';
    begin
        for i in 1..n loop
            result := result || i || ' ';
            end loop;
        return result;
    end;
    $$
language plpgsql;
select number_series(6);

-- 4
create table employees (
    emp_id serial primary key ,
    emp_name varchar(255) not null ,
    emp_salary integer not null
);

insert into employees (emp_name, emp_salary) values
    ('Alice', 60000),
    ('Bob', 50000),
    ('Charlie', 70000);


create function find_employee(employee_name varchar) returns table(id integer, name varchar, salary integer) as
    $$
    begin
        return query select emp_id, emp_name, emp_salary from employees where employee_name = emp_name;
    end;
    $$
language plpgsql;
select * from find_employee('Bob');

-- 5
create table products (
    id serial primary key ,
    name varchar(255) not null ,
    category varchar(255) not null
);

insert into products (name, category) values
    ('Laptop', 'Electronics'),
    ('Smartphone', 'Electronics'),
    ('Refrigerator', 'Appliances'),
    ('Microwave', 'Appliances'),
    ('Desk', 'Furniture'),
    ('Chair', 'Furniture');


create function list_products(category_name varchar) returns table(product_id integer, product_name varchar, product_category varchar) as
    $$
    begin
        return query select id, name, category from products where category = category_name;
    end;
    $$
language plpgsql;

select * from list_products('Electronics');

-- 6
create function calculate_bonus(employee_id integer) returns integer as
    $$
    declare bonus integer;
    begin
        select emp_salary*0.1 into bonus from employees where emp_id = employee_id;
        return bonus;
    end;
    $$
language plpgsql;

create function update_salary(employee_id integer) returns table(id integer, name varchar, salary integer) as
    $$
    declare bonus integer;
    begin
        bonus := calculate_bonus(employee_id);
        return query update employees set emp_salary = emp_salary + bonus where emp_id = employee_id returning *;
    end;
    $$
language plpgsql;
drop function update_salary(employee_id integer);
select * from update_salary(1);

-- 7
create function complex_calculation(n integer, str varchar)
returns varchar as
$$<<outer_block>>
    declare result varchar;
    begin
    <<inner_block1>>
    begin
        n := n * n;
    end inner_block1;
    <<inner_block2>>
    begin
        str := '!' || str || '!';
    end inner_block2;
    result := str || n;
    return result;
    end outer_block;
$$
language plpgsql;

select * from complex_calculation(5, 'hello');