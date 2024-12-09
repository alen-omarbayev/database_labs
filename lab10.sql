create database lab10;

create table books(
    book_id integer primary key,
    title varchar(250),
    author varchar(250),
    price decimal,
    quantity integer
);

create table ordrs(
    order_id integer primary key,
    book_id integer,
    customer_id integer,
    order_date date,
    quantity integer,
    foreign key (book_id) references books(book_id)
);

create table cstmrs(
    customer_id integer primary key,
    name varchar(250),
    email varchar(250)
);

insert into books values
  (1, 'database 101', 'a. smith', 40.00, 10),
  (2, 'learn sql', 'b. johnson', 35.00, 15),
  (3, 'advanced db', 'c.lee', 50.00, 5);

insert into cstmrs values
  (101, 'john doe', 'johndoe@example.com'),
  (102, 'john doe', 'johndoe@example.com');

--1
begin transaction;
insert into ordrs values (1, 1, 101, '2024-12-05', 2);
update books set quantity = quantity - 2 where book_id = 1;
commit;

--2
begin transaction;
insert into ordrs values (2, 3, 102, '2024-12-15', 10);
do $$
    begin
    if (select quantity from books where book_id = 3) >= 10
        then update books set quantity = quantity - 10 where book_id = 3;
    else
        raise notice 'unsufficient quantity';
    end if;
end $$;
rollback;

--3
begin transaction isolation level read committed;
update books set price = 25 where book_id = 2;
commit;

--4
begin transaction;
update cstmrs set email = 'newemail@com' where customer_id = 102;
commit;