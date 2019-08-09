use world;
create table wor01
as
select * from city where 0=1;
select * from wor01;
alter table wor01
add test char(2);
desc wor01;
-- 여기는 괄호 생략
alter table wor01
modify test char(10);
desc wor01;

alter table wor01
drop column test;

show tables;
drop table wor01;

use sakila;
show tables;

create table actor01
as
select actor_id, first_name from actor where 0=1;

select * from actor01;
insert into actor01 
values (1, 'Hong');

insert into actor01 (first_name)
values ('Kim');

drop table actor01;

use world;