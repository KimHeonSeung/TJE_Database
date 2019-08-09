use world;
select * from city;
desc city;

create database chat;
use chat;

create table user(
	id varchar(20) primary key,
    password varchar(20) not null,
    name varchar(20) not null,
    alias varchar(20) not null,
    tel varchar(20)
);

select * from user;
delete from user ;
commit;