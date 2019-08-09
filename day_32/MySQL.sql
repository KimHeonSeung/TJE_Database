use world;
SET SQL_SAFE_UPDATES = 0;

create table ci04
as
select * from city;

select * from ci01;
delete from ci04;
rollback;

SELECT @@AUTOCOMMIT;
set autocommit = false;

create database hr;

delete from ci04;

drop table ci04;

create table ci01
as
select * from city;

select * from ci01
order by countrycode;


delete from ci01
where countrycode = 'NLD';
savepoint s1;

delete from ci01
where countrycode = 'AFG';
savepoint s2;

delete from ci01
where countrycode = 'DZA';
savepoint s3;

delete from ci01
where population >= 100000;
savepoint s4;

rollback;
rollback to s2;

use world;

use hr;
create table test (
	empno int(4) not null,
    ename varchar(10) not null,
    deptno int(2)
);
select * from test;

insert into test
values (1, 'T_1', 10);

insert into test (ename, deptno)
values ('T_2', 20);

create table emp03 (
	empno int(4) unique,
    ename varchar(10) not null,
	job varchar(9),
	deptno int(2)
);
select * from emp03;

insert into emp03
values (7499, 'ALLEN', 'SALESMAN', 30);
insert into emp03
values (7499, 'JONES', 'MANAGER', 20);
insert into emp03
values (null, 'JONES', 'MANAGER', 20);

delete from emp03
where empno is null;

USE HR;
CREATE TABLE USERS (
	ID VARCHAR(20) PRIMARY KEY,
    PW VARCHAR(20) NOT NULL
);
SELECT * FROM USERS;
INSERT INTO USERS
VALUES ('AAA', '1A' );