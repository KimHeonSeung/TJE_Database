-- concatenation : 열 합치기
select first_name || '''s phone number is ' || phone_number
from employees;

select *
from employees;

select first_name || ' ' || last_name
from employees;

-- distinct : 중복제거
select department_id
from employees;

select distinct nvl(department_id, 0) as "부서 번호(0은 사장)"
from employees;

-- where 칼럼 연산자 비교대상값 : 숫자 데이터 조회
-- 각 절이 따로따로 실행. 

select distinct nvl(department_id, 0) as "부서 번호(0은 사장)"
from employees
where department_id >= 50;

-- 한줄 한줄 보면서 조건절에 성립하는걸 가져온다
select *
from employees
where salary >= 5000;

-- where 칼럼 연산자 '문자정보'; : 문자 데이터 조회. ''랑 "" 지원하는 프로그램마다 다름.
-- 들어있는 값은 대소문자 구분을 해야한다.
select employee_id, first_name, salary
from employees
where first_name = 'Alexander';

select *
from employees
where first_name = 'Donald';

-- where 칼럼 연산자 'YYYY/MM/DD' : 날짜 데이터 조회. 저렇게 문자처럼 쓰면 정수값으로 반환하여 비교한다.
select *
from employees
where hire_date >= '2007/01/01';

-- 연봉이 100000불 이상인 사원의 정보 출력 중 부서번호 60(프로그래머) 출력
select *
from employees
where 12*(salary + salary*nvl(commission_pct,0)) >= 100000 and department_id = 60;

-- 급여가 5000불에서 7000불 사이인 사원의 정보를 출력
select *
from employees
where salary >= 5000 and salary <= 7000;

-- 부서번호가 10, 70, 110인 사원의 정보 출력
select *
from employees
where department_id = 10 or department_id = 70 or department_id = 110;

-- between and : 동일한 칼럼에 대해 and를 사용하고자 할 때
-- where 칼럼명 between 시작 and 끝;
select *
from employees
where salary between 5000 and 7000;

select *
from employees
where salary not between 5000 and 7000;

select *
from employees
where hire_date between '2001/01/01' and '2001/12/31';

-- in : 칼럼명 in (값, 값, ...)
select *
from employees
where department_id in (10, 70, 110);

-- job_id의 값이 it_prog 이거나 st_man 이거나 sa_man인 사원만 출력
-- 급여가 8000에서 10000 사이의 사원 출력
select *
from employees
where (job_id in ('ST_MAN', 'IT_PROG', 'SA_MAN')) 
and (salary + (salary*nvl(commission_pct,0)) between 8000 and 10000);

-- 실제 저장된 데이터는 대소문자를 구분해야함
select *
from employees
where (lower(job_id) in ('st_man', 'it_prog', 'sa_man')) 
and (salary + (salary*nvl(commission_pct,0)) between 8000 and 10000);

-- 칼럼 like 패턴 으로 일부의 정보로 정확히 모르는 정보를 출력할 수 있다.
-- %는 그위치에 뭐가오든
select *
from employees
where first_name like '%m';

-- first_name 에 w이 포함된 사원을 검색 (대소문자 구문 x)
select *
from employees
where lower(first_name) like '%w%';

-- _는 앞에 딱 한글자만 오도록
select *
from employees
where upper(first_name) like '_A%';

-- A가 포함된 이름을 제외시키고 싶을 때
select *
from employees
where upper(first_name) not like '%A%';

-- 널값은 =로 판단할 수 없다.
-- is null 과 is not null 로 사용
-- 대상컬럼 is null
-- 대상칼럼 is not null
select employee_id, nvl(commission_pct,0) as COMMISSION_PCT
from employees
where commission_pct is null or commission_pct >= 0.2;

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- 정렬 order by asc, desc
-- order by 칼럼명 asc(desc)
-- order by 칼럼명 하면 기본으로 asc로 해준다.
select *
from employees
where upper(first_name) not like '%A%'
order by first_name asc;

select *
from employees
order by salary desc;

select employee_id as "사원번호", first_name || ' ' || last_name as "사원명" , job_id as "직급", hire_date as "입사일"
from employees
order by 입사일 desc;

-- 부서번호를 기준으로 오름차순 정렬한 후
-- 동일한 부서번호를 갖는 경우 급여컬럼은 내림차순 정렬 
select *
from employees
order by department_id asc, salary desc;

select employee_id as "사원 번호", first_name || ' ' || last_name as "사원 이름", job_id as 직급, hire_date as 입사일, salary as 급여, department_id as "부서 번호"
from employees
order by "부서 번호" asc, 입사일 desc;

-- 합을 구하는 함수 sum
select sum(salary+salary*nvl(commission_pct, 0)) as "급여의 총합"
from employees;

select sum( (salary + salary*nvl(commission_pct, 0))*12 ) as "연봉의 합계"
from employees;

-- 평균값을 구할 땐 
select avg(salary)
from employees;

select avg(commission_pct)
from employees;

select sum(commission_pct)
from employees;
-- 개수는 107개, 총합은 7.8

-- sql에서 제공하는 avg함수는 null값을 제외한 개수를 합계로 나눈 값을 반환한다.
-- count 함수도 동일하다.
select count(commission_pct)
from employees;

-- 올바르게 평균을 구하기 위해 nvl을 이용한다.
select avg( nvl(commission_pct,0) )
from employees;

-- 쌍이 안맞음. 리턴되는 값이 다름
--select employee_id, max(salary)
--from employees;

-- 일정한 그룹단위로 묶어줌
-- 임플로이즈에 있는 모든 테이블들을 각각의 디파트먼트 아이디별로 작은 그룹을 생성
-- 맥스는 그룹갯수만큼나오게된다.
select DEPARTMENT_ID as "부서 번호", max(salary) as "급여의 최댓값"
from employees
group by DEPARTMENT_ID
order by "급여의 최댓값";

-- 조건식을 추가하는 경우. where절은 그룹함수를 사용할 수 없다. 순수한 레코드 데이터만 비교가능
select DEPARTMENT_ID as "부서 번호", max(salary) as "급여의 최댓값"
from employees
-- 90인 그룹을 제외하고 묶을때 명령
where DEPARTMENT_ID <> 90
group by DEPARTMENT_ID
-- group by에 조건식을 추가할 수 있는 명령은 having 이다. 집계함수, 그룹함수를 비교할때
having max(salary) >= 10000
order by "급여의 최댓값";

select count(commission_pct) as "80번 부서 소속 사원 중 커미션을 받는 사원의 수"
from employees
where department_id = 80;

-- 각 부서별 인원수를 출력하세요
select DEPARTMENT_ID, count(*)
from EMPLOYEES
group by DEPARTMENT_ID;

-- 각 부서별 월급이 7000 이상인 인원수를 출력하세요
select department_id as "부서 번호", count(*) as "인원수"
from employees
where salary + salary*nvl(COMMISSION_PCT,0) >= 7000
group by department_id
order by department_id;

-- 각 부서별 평균 급여를 출력
-- round(숫자, 자리수) 하면 소수점 자리수만큼 나옴
select department_id as "부서 번호" , round(avg( salary + salary*nvl(COMMISSION_PCT,0) ), 2) as "평균 급여"
from employees
group by department_id
order by "부서 번호";

-- 각 부서별 평균 급여를 출력
-- ( 각 부서별 인원이 7명 이상인 부서에 한해서 출력 )
select department_id as "부서 번호", round(avg( salary + salary*nvl(COMMISSION_PCT,0) ), 2) as "평균 급여"
from employees
group by department_id
having count(*) >= 7
order by department_id;

select department_id as "부서 번호", job_id as 직급, round(avg( salary + salary*nvl(COMMISSION_PCT,0) ), 2) as "평균 급여"
from employees
group by department_id, job_id
having count(*) >= 7
order by department_id;

select *
from tabs;

-- 여기에 있는 번호는
select employee_id, department_id
from employees;
-- 여기에 있는 테이블과 연관되어있다.
select *
from departments;

select *
from employees, departments;

-- 테이블의 이름에 점을찍어 값이 같은것을 가져온다. equi join
select *
from employees, departments
where employees.department_id = departments.department_id;

select *
from jobs;
-- employees 테이블과 jobs 테이블을 조인하여
-- 사원번호, job_id, 월 급여, min_salary, max_salary 출력
-- 어느 테이블의 그것을 쓸지 지정해줘야한다. select에서.
select employee_id, employees.job_id, job_title, salary + salary*nvl(commission_pct, 0) as "월 급여", min_salary, max_salary
from employees, jobs
where employees.job_id = jobs.job_id;

-- employees 테이블과 jobs 테이블을 조인하여
-- 사원번호, job_id, job_title, 월 급여, min_salary, max_salary 출력
-- (해당 직책의 허용된 급여 체계의 평균 이상의 급여를 수령하는 사원을 출력)
select employee_id, employees.job_id, job_title, salary + salary*nvl(commission_pct, 0) as "월 급여", (max_salary + min_salary)/2 as "평균 급여", min_salary, max_salary
from employees, jobs
where employees.job_id = jobs.job_id and salary + salary*nvl(commission_pct, 0) >= (max_salary + min_salary)/2;