-- 1
create database lab8;

-- 2
create table salesman (
    salesman_id int primary key,
    name varchar(50),
    city varchar(50),
    commission decimal(4, 2)
);

insert into salesman (salesman_id, name, city, commission) values
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'London', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

create table customers (
    customer_id int primary key,
    cust_name varchar(50),
    city varchar(50),
    grade int,
    salesman_id int,
    foreign key (salesman_id) references salesman(salesman_id)
);

insert into customers (customer_id, cust_name, city, grade, salesman_id) values
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

create table orders (
    ord_no int primary key ,
    purch_amt decimal(10, 2),
    ord_date date,
    customer_id int,
    salesman_id int,
    foreign key (customer_id) references customers(customer_id),
    foreign key (salesman_id) references salesman(salesman_id)
);

insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);

-- 3
create role junior_dev with login;

-- 4
create view NewYorkSalesman as select name from salesman where city = 'New York';
select * from newyorksalesman;

-- 5
create view ordDetails as select orders.ord_no, salesman.name, customers.cust_name from orders
join salesman on orders.salesman_id = salesman.salesman_id
join customers on orders.customer_id = customers.customer_id;

grant all on ordDetails to junior_dev;

select * from ordDetails;

-- 6
create view highestGradeCustomers as select cust_name from customers where grade = (select max(grade) from customers);

grant all on highestGradeCustomers to junior_dev;

select * from highestGradeCustomers;

-- 7
create view numberOfSalesman as select city, count(*) from salesman group by city;

select * from numberOfSalesman;

-- 8
create view moreThanOneCustomers as
select name from salesmen join customers on salesmen.salesman_id = customers.salesman_id
group by salesmen.salesman_id, salesmen.name having count(customers.customer_id) > 1;

select * from moreThanOneCustomers;

-- 9
create role intern with login;

grant junior_dev to intern;
