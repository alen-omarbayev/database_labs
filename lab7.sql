create database lab7;

-- 1
select * from countries where name = 'string';
create index stringNameIndex on countries (name);

-- 2
select * from employees where name = 'string' and surname = 'string';
create  index employeeNameIndex on employees (name, surname);

-- 3
select * from employees where salary < value1 and salary > value2;

create index employeeSalaryIndex on employees (salary);

-- 4
select * from employees where substring(name from 1 for 4) = 'abcd';
create index employeeSubstrIndex on employees (substring(name from 1 for 4));

-- 5
select * from employees e join departments d on d.department_id = e.department_id where d.budget > value2 and e.salary < value2;
create index employeeSalaryIndex on employees (department_id, salary);
create index departmentBudgetIndex on departments (department_id, budget);