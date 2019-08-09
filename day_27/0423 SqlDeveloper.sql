-- 해당 계정에 존재하는 테이블의 목록을 검색하는 SQL 문

select *
from TAB;

desc employees;

-- 잘 안바꿀 때 varchar2 사용. 남으면 줄여서 딱맞춰줌. 한번 들어가면 거의 바뀌지 않을 것들
-- char는 고정길이 문자 데이터 언제든 바뀔 가능성 있을 때

-- 절단위로 끊어서 작성하는것이 좋다.


select *
from employees;

select employee_id, first_name, last_name
from employees;

-- 사원의 이름과 급여, 입사일자를 검색하는 쿼리문
select  first_name, last_name, salary, hire_date
from employees;

desc employees;

-- 사원의 이름과 급여, 연봉을 검색하는 쿼리문.
select first_name, last_name, salary, salary*12
from employees;

-- 널값을 연산하면 널값이 결과로 나온다.
select first_name, last_name, salary, commission_pct, salary*12, salary*12+commission_pct
from employees;

-- nvl(열, 값) 은 해당 열에 널값을 주어진 값으로 바꿔준다.
select first_name, last_name, salary, commission_pct, salary*12, salary*12+commission_pct, nvl(commission_pct, 0), salary*12+nvl(commission_pct, 0)
from employees;

-- as 별칭 을 사용하면 열이 그 이름으로 바뀐다. 공백 사용은 안됨.
-- 대소문자 구별은 쌍따옴표를 사용 ( "A n n s a l" ) 이렇게 하면 공백도 사용 가능
select first_name, last_name, salary, commission_pct, salary*12 as annsal, salary*12+commission_pct as annsalcomm, nvl(commission_pct, 0) as comm_nvl, salary*12+nvl(commission_pct, 0) as annsalcomm_nvl
from employees;

select *
from departments;

select department_id as "부서번호" , department_name as "부서명"
from departments;