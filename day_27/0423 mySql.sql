-- 주석처리
-- 데이터 베이스에 접속하는 명령어 
-- use 데이터베이스명(SCHEMA)
-- 오라클은 접속자체가 유즈를 했다는 뜻이라 필요가 없음
use world;

-- 특정 데이터베이스에 접속한 후, 
-- 해당 데이터의 테이블 목록을 검색하는 명령 
show tables;
-- desc 테이블명 : 테이블의 구조를 확인하기 위한 명령
desc city;

-- 테이블의 구조를 검색하는 명령
-- (반드시 데이터베이스에 접속한 후 실행해야함)
use sakila;
desc staff;

use world;
desc country;

select code, name, region, indepyear
from country;

select name, countrycode, population
from city;

desc country;

use sakila;
desc customer;
select store_id, first_name, last_name, create_date, last_update
from customer;

select *
from customer;

select customer_id, active, active*10+5
from customer;

select *
from rental;

use sakila;
select *
from staff;

-- mysql에서 널값을 대체하여 값을 검색하는 방법
-- ifnull( 컬럼명, 널값일 경우의 대체값 )
-- 이프널이란 함수로 널값이 있는 부분을 nvl처럼 처리가능
select staff_id, first_name, picture, ifnull(picture, '사진없음') as "n E w"
from staff;

select *
from actor;

select first_name as "이름", last_name as "성"
from actor;