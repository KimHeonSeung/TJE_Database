select *
from city;

select name, countrycode
from city;

-- 오라클에서 ||엿던 연산자
select concat(name, ' ', countrycode)
from city;

select distinct countrycode
from city;

use sakila;

select *
from payment
where amount >= 2;

select *
from actor
where first_name = 'CAMERON';

-- 2005년 7월 이후에 계산내역을 출력
select *
from payment
where payment_date >= '2005/07/05 22:57:00';

use world;
select *
from city
where countrycode = 'arg' and district = 'mendoza'
order by name desc;