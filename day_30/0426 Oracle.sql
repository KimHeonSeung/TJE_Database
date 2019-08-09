select *
from departments;

select *
from locations;

select *
from regions;

select *
from countries;

select *
from jobs;

select *
from job_history;

select *
from employees;

-- 테이블에 별칭 부여하기. 프롬절 다음에 테이블 이름을 명시하고 공백을 두고 지정하면 된다.
select  e.first_name, d.department_name, e.employee_id, d.department_id
from employees e, departments d
where e.department_id = d.DEPARTMENT_ID and lower(e.first_name) = 'david'
order by first_name;

-- 시애틀에서 근무하는 사원의 이름과 급여 출력
select e.first_name || ' ' || e.last_name as 이름, salary as 급여
from employees e, departments d, locations l
where e.DEPARTMENT_ID = d.DEPARTMENT_ID and d.LOCATION_ID = l.LOCATION_ID and lower(l.CITY) = 'seattle'
order by salary desc;

-- Accounting 부서에서 근무하는 사원을 출력
select e.first_name || ' ' || e.last_name as 이름, hire_date as 입사일
from employees e, departments d
where e.department_id = d.department_id and d.department_name = 'Accounting';

-- 직급이 manager인 사원의 이름, 부서명
select e.first_name || ' ' || e.last_name as 이름, d.DEPARTMENT_name as 부서명, j.job_title as 직급
from employees e, departments d, jobs j
where e.department_id = d.department_id and e.job_id= j.job_id and lower(j.job_title) like '%manager%'
order by 직급;

-- 각 국가별 근무중인 사원수 출력
-- 국가명, 사원수
-- 조인수 -1 = 조건수
select c.country_name as 국가명, count(*) as 사원수
from locations l, countries c, employees e, departments d
where e.department_id = d.department_id and d.location_id = l.location_id and l.country_id = c.country_id
group by c.country_name
order by 사원수;

-- 테이블 생성
create table Salary_Grade (
  grade number(1), 
  min_salary number(10,2),
  max_salary number(10,2)
);

select *
from salary_grade;

select *
from employees
order by salary desc;

-- 내용 추가
insert into salary_grade values (1, 2000, 5000);
insert into salary_grade values (2, 5001, 10000);
insert into salary_grade values (3, 10001, 15000);
insert into salary_grade values (4, 15001, 20000);
insert into salary_grade values (5, 20001, 25000);

-- 사원의 급여와 등급을 출력
select first_name||' '||last_name as 이름, salary as 급여, grade as 등급
from employees e, salary_grade s
where e.salary between s.min_salary and s.max_salary;

-- 등급별 사원수 출력
select grade as 등급, count(*) as 사원수
from employees e, salary_grade s
where e.salary between s.min_salary and s.max_salary
group by grade
order by grade;

-- 그룹별 평균급여
select grade as 등급, count(*) as 사원수, round(avg(salary),2) as 평균급여
from employees e, salary_grade s
where e.salary between s.min_salary and s.max_salary
group by grade
order by grade;

-- manager_id 는 직속상사
select *
from employees;

select e1.first_name||' '||e1.last_name as 사원명, e2.first_name||' '||e2.last_name as 관리자명
from employees e1, employees e2
where e1.manager_id = e2.employee_id;

-- 각 관리자별 사원수
select e2.first_name||' '||e2.last_name as 관리자명, count(*) as 사원수
from employees e1, employees e2
where e1.manager_id = e2.employee_id
group by e2.first_name||' '||e2.last_name
order by 사원수 desc;

-- john chen와 같이 근무하는 사원들 출력
select e1.first_name||' '||e1.last_name as "John Chen과 같이 일하는 사원", e1.salary as 급여, e1.department_id as 부서번호
from employees e1, employees e2
where lower(e2.first_name) = 'john' and lower(e2.last_name) = 'chen' and e1.department_id = e2.department_id
  -- e2는 지금 존첸임. 존첸을 제거하는 조건절
  and e2.employee_id != e1.employee_id
order by 급여;

-- 킹이 포함되지 않음 (manager_id = null)
-- e1은 사원값 (employee 테이블의 전체 사원들 107명)
-- e2의 employee_id는 모두존재
-- e1의 manager_id는 모두존재하지가 않음
-- e1의 manager_id와 맞는게 없어도 그냥 추가시켜주겠다는 의미
select e1.first_name||' '||e1.last_name as 사원명, e2.first_name||' '||e2.last_name as 관리자명
-- 왼쪽에있는 테이블 정보는 안맞아도 다 가져오겠다는 의미
from employees e1 LEFT OUTER JOIN employees e2 on e1.manager_id = e2.employee_id;

-- 아래와 같이 작성해도 됨
-- select e1.first_name||' '||e1.last_name as 사원명, e2.first_name||' '||e2.last_name as 관리자명
-- from employees e1, employees e2 
-- where e1.manager_id = e2.employee_id(+);

-- 사원 테이블과 부서 테이블을 조인하여 사원 테이블의 부서는 없지만 부서의 이름도 출력되도록
select e.first_name||' '||e.last_name as 사원명, d.department_id as 부서번호, d.department_name as 부서명
from employees e, departments d
where e.department_id(+) = d.department_id;
-- 아래와 같이 써도 된다.
select e.first_name||' '||e.last_name as 사원명, d.department_id as 부서번호, d.department_name as 부서명
from employees e RIGHT OUTER JOIN departments d on e.department_id = d.department_id;

select e.first_name||' '||e.last_name as 사원명, e.hire_date, d.department_id as 부서번호, d.department_name as 부서명
from employees e, departments d
where e.department_id = d.department_id(+);



-- on으로 조인의 조건을 설정한다.
-- 그냥 join으로 써도 inner join으로 인식
select e.first_name||' '||e.last_name as 사원명, d.department_name as 부서명
from employees e inner join departments d
on e.department_id = d.department_id
where lower(e.first_name) = 'john' and lower(e.last_name) = 'chen';

-- 두 테이블에 똑같은 컬럼이 있다면 using (공통칼럼명)으로 공통 컬럼을 지정할 수 있다.
-- using에 나온 컬럼을 select절에 쓸때는 e.칼럼명 이런식으로 할 필요 없이 그냥 칼럼명만 적으면 된다.
select e.first_name||' '||e.last_name as 사원명, d.department_name as 부서명
from employees e inner join departments d
using (department_id)
where lower(e.first_name) = 'john' and lower(e.last_name) = 'chen';

-- natural : 컬럼명이 똑같은거끼리 알아서 조인해줌
-- 이름만 같고 타입이 다르다면 에러가 발생
select e.first_name||' '||e.last_name as 사원명, d.department_name as 부서명
from employees e natural join departments d
where lower(e.first_name) = 'john' and lower(e.last_name) = 'chen';

-- 각 사원 이름 ,부서번호, 지역명 같이 출력 (ansi 활용)
-- ansi로 3개 이상을 할때 조인이 끝난뒤 다시 inner join 테이블명 on 조건을 추가
select e.first_name||' '||e.last_name as 사원명, department_name as 부서명, l.CITY as 도시명
from employees e inner join departments d using (department_id) 
  inner join locations l using (location_id);

-- 세 테이블 모두 공통되는 칼럼을  출력하는 코드
-- select e.first_name||' '||e.last_name as 사원명, department_id, l.CITY
-- from employees e natural join departments d natural join locations l;

select *
from departments;

-- table 복사 명령
create table dept01
as
select *
from departments;

select *
from dept01;

create table dept02
as
select *
from departments;

select *
from dept02;

delete from dept02
where department_id > 100;

drop table dept01;
drop table dept02;
---------------------------------------------------------------
-- 조건식에 따라 테이블을 만들기
create table dept01
as
select *
from departments
where mod(department_id/10 , 2) = 1;

create table dept02
as
select *
from departments
where mod(department_id/10 , 2) = 0;

select * from dept01;
select * from dept02;

-- 검색조건에 만족하지 않아도 가져오겠다. (left/right/full) 에 해당하는 레코드를 전부
-- 같은게 없지만 검색이 된다. 앞쪽에있는것들, 뒷쪽거는 전부 null
select *
from dept01 left outer join dept02
on dept01.DEPARTMENT_ID = dept02.DEPARTMENT_ID;

-- 같은게 없지만 뒷쪽에 있는 것이 전부 출력. 앞쪽거는 전부 null
select *
from dept01 right outer join dept02
on dept01.DEPARTMENT_ID = dept02.DEPARTMENT_ID;
-- 같은 기능을 하는 코드 ( 반대로 생각하면 된다. )
select *
from dept01, dept02
where dept01.DEPARTMENT_ID = dept02.DEPARTMENT_ID(+);

select *
from dept01 full outer join dept02
on dept01.DEPARTMENT_ID = dept02.DEPARTMENT_ID;

-------------------------------------------------------------------------------

-- 서브쿼리는 비교연산자 우측에
-- it에 있는 사원을 검색해보기
select *
from employees
where department_id = (
  select department_id 
  from departments
  where department_name = 'IT'
);

select e.first_name||' '||e.last_name as 사원명, e.department_id as 부서번호
from employees e
where department_id = (
  select department_id
  from employees 
  where lower(first_name) = 'john' and lower(last_name) = 'chen'
);

select e.department_id as 부서번호
from employees e
where lower(e.first_name) = 'john' and lower(e.last_name) = 'chen';

-- 존첸 급여 이상을 받는 사람들
select e.first_name||' '||e.last_name as 사원명, e.salary as 급여
from employees e
where e.salary >= (
  select salary
  from employees 
  where lower(first_name) = 'john' and lower(last_name) = 'chen'
) and e.first_name||' '||e.last_name != 'John Chen'
order by 급여;

-- 존첸과 같은 직급인 사람들
select *
from employees
where job_id = (
  select job_id
  from employees
  where first_name = 'John' and last_name = 'Chen'
);

-- 존첸과 같은 부서번호인 사람들
select e.first_name||' '||e.last_name as 사원명, e.department_id as 부서ID
from employees e
where e.department_id = (
  select DEPARTMENT_ID
  from employees 
  where lower(first_name) = 'john' and lower(last_name) = 'chen'
) and e.first_name||' '||e.last_name != 'John Chen';

select e.first_name||' '||e.last_name as 사원명, e.salary as 급여
from employees e
where e.salary > (
  select avg(salary)
  from EMPLOYEES
)
order by 급여;

select e.first_name||' '||e.last_name as 사원명, e.salary as 급여, e.department_id
from employees e
where e.department_id in ( 
  select DISTINCT department_id
  from employees
  where salary>=3000
)
order by department_id;

-- 각 그룹에서 최대 급여 사원 출력
select employee_id, first_name||' '||last_name as 사원명, salary as 급여, department_id as 부서번호
from employees
-- 여러개의 열을 동시에 비교할 수 있다.
where (department_id, salary) in (
  select department_id, max(salary)
  from employees
  group by department_id
);

-- 직급(JOB)이 MANAGER인 사람의 속한 부서의 부서 번호와 부서명과 지역을 출력하시오.
-- 그사람이 속한 job_id에 해당하는 department_id를 가져와 이에 해당하는 location을 알아낸다
select department_id as 부서번호, department_name as 부서명, city as 지역
from departments inner join locations using (location_id)
where department_id in (
  select distinct department_id
  from employees
  where job_id in (
    select job_id
    from jobs
    where lower(job_title) like '%manager%'
  )
);

select salary
from employees
where department_id = 60;

-- 서브쿼리문에 있는 값들보다 큰걸 원할때
select first_name, salary
from employees
where salary > all(
  select salary
  from employees
  where department_id = 60
);
-- 위 코드는 아래와 같다
select first_name, salary
from employees
where salary > (
  select max(salary)
  from employees
  where department_id = 60
);


-- 서브쿼리문에 있는 값들 중 제일 작은거보다 큰걸 원할때
select first_name, salary
from employees
where salary > any(
  select salary
  from employees
  where department_id = 60
);
-- 위 코드는 아래와 같다
select first_name, salary
from employees
where salary > (
  select min(salary)
  from employees
  where department_id = 60
);