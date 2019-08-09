create table emp07(
  empno number(4)
    constraint emp07_empno_pk primary key,
  ename varchar2(10)
    constraint emp07_emname_nn not null,
  sal number(7, 2)
    constraint emp07_sal_ck check (sal between 500 and 5000),
  gender varchar2(1)
    constraint emp07_gender_ck check (gender in('M', 'F'))
);

insert into emp07 values (1000, 'A', 501, 'M');
insert into emp07 values (1001, 'B', 5001, 'M');
insert into emp07 values (1001, 'B', 5000, 'M');

select * from emp07;


CREATE TABLE DEPT01 (
  DEPTNO NUMBER(2) PRIMARY KEY,
  DNAME VARCHAR2(14),
  LOC VARCHAR2(13) DEFAULT 'SEOUL'
);
SELECT * FROM DEPT01;

INSERT INTO DEPT01
  (DEPTNO, DNAME)
    VALUES (10, 'ACCOUNTING');
    
    
    
-- 마지막에 몰아서 제약조건을 일괄적으로 기술할 수 있다.
-- 열 수준에서 pk는 하나밖에 못함 2개의 열로 pk를 만들때는 table제약조건으로 해야.
-- not null 은 열을 정의할때 써줘야한다.
CREATE TABLE EMP02 (
  -- 먼저 열을 정의
  EMPNO NUMBER(4),
  ENAME VARCHAR2(10) NOT NULL,
  JOB VARCHAR2(9),
  DEPTNO NUMBER(4),
    -- 제약조건 일괄적으로 정의
    PRIMARY KEY(EMPNO),
    UNIQUE(JOB),
    FOREIGN KEY(DEPTNO) REFERENCES DEPARTMENTS(DEPARTMENT_ID)
);
SELECT * FROM EMP02;

-------------------------------------------------------------------
SELECT * FROM JOBS;
SELECT * FROM LOCATIONS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

-- 부서명, 이름, JOB이름, 근무지가 위치한 도시를 출력
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS "이름",
        D.DEPARTMENT_NAME AS "부서명",
        J.JOB_TITLE AS "직책",
        L.CITY AS "근무지"
  FROM EMPLOYEES E INNER JOIN JOBS J USING(JOB_ID)
      INNER JOIN DEPARTMENTS D USING(DEPARTMENT_ID)
      INNER JOIN LOCATIONS L USING(LOCATION_ID);
      
-- 위 정보를 갖는 뷰를 생성
-- 복잡한 쿼리를 뷰로 설정한다.
-- 실행된 쿼리문의 정보를 보여주는 역할.
-- 뷰를 잘 만들어놓으면 훨씬 코드들이 간단해질 수 잇다.
CREATE VIEW EMP_INFO
AS
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS "이름",
        D.DEPARTMENT_NAME AS "부서명",
        J.JOB_TITLE AS "직책",
        L.CITY AS "근무지"
  FROM EMPLOYEES E INNER JOIN JOBS J USING(JOB_ID)
      INNER JOIN DEPARTMENTS D USING(DEPARTMENT_ID)
      INNER JOIN LOCATIONS L USING(LOCATION_ID);

SELECT * FROM EMP_INFO
WHERE 근무지 = 'Seattle';



DROP TABLE USERS;
DROP TABLE MESSAGES;
-- 회원 정보를 저장할 수 있는 테이블을 작성하세요
-- 아이디, 패스워드, 이름, 나이, 연락처
-- (아이디의 값은 다른 레코드와 구분되는 값입니다.)
create table users (
  user_id varchar2(20) CONSTRAINT USERS_ID_PK primary key,
  user_pw varchar2(20) CONSTRAINT USERS_PW_NN NOT NULL,
  user_name varchar2(20) CONSTRAINT USERS_NAME_NN NOT NULL,
  user_age number(3),
  user_tel varchar2(20)
);
insert into users (user_id, user_pw, user_name) values ('aaa', '111', 'A1');
insert into users (user_id, user_pw, user_name) values ('bbb', '222', 'B1');
insert into users (user_id, user_pw, user_name) values ('ccc', '333', 'C1');
insert into users (user_id, user_pw, user_name) values ('ddd', '444', 'D1');
insert into users (user_id, user_pw, user_name) values ('eee', '555', 'E1');
select * from users;

-- 회원들간의 쪽지 메세지 정보를 저장하는 테이블을 선언하세요.
create table messages (
  message_id number(5) CONSTRAINT messages_ID_PK primary key,
  sender_id varchar2(20) CONSTRAINT messages_sender_id_FK REFERENCES users(user_id),
  receiver_id varchar2(20) CONSTRAINT messages_receiver_id_FK REFERENCES users(user_id),
  contents varchar2(500) CONSTRAINT messages_contents_NN not null,
  send_date DATE CONSTRAINT messages_send_date_NN not null,
  receive_date TIMESTAMP
);
drop table messages;
-- aaa 가 ccc 에게 메세지를 보내도록 insert 구문을 작성하세요.
insert into messages values (1, 'aaa', 'ccc', '하이~!', SYSDATE, null);
-- aaa 가 ddd 에게 메세지를 보내도록 insert 구문을 작성하세요.
insert into messages values (2, 'aaa', 'ddd', '날이 덥네요~!', SYSDATE, null);
-- aaa 가 eee 에게 메세지를 보내도록 insert 구문을 작성하세요.
insert into messages values (3, 'aaa', 'eee', '점심식사는???', SYSDATE, null);
-- bbb 가 eee 에게 메세지를 보내도록 insert 구문을 작성하세요.
insert into messages values (4, 'bbb', 'eee', '쉬는 쉬간에 잠깐?', SYSDATE, null);

select * from MESSAGES;

update messages
set RECEIVE_DATE = sysdate
where MESSAGE_ID = 3;

CREATE VIEW MSGV
AS
SELECT S.USER_NAME AS "보낸 사람", R.USER_NAME AS "받는 사람" , M.CONTENTS AS "메세지 내용"
FROM USERS S INNER JOIN MESSAGES M ON S.USER_ID = M.SENDER_ID
	INNER JOIN USERS R ON M.RECEIVER_ID = R.USER_ID;
  
SELECT * FROM MSGV;


-- 보낸 사람, 받는 사람, 메세지 내용, 보낸 날자, 받은 날자
CREATE VIEW MESSAGES_INFO
AS
select m.MESSAGE_ID as "메세지번호", s.USER_name as "보낸사람", 
  r.USER_name as "받는사람", m.CONTENTS as "메세지내용", 
  m.SEND_DATE as "보낸날자", 
  nvl(TO_CHAR(m.RECEIVE_DATE,'YYYY:MM:DD DAY PM HH:MI:SS'), '확인하지않음') as "받은날자"
from users s inner join MESSAGES m on s.USER_ID = m.SENDER_ID
  inner join users r on m.RECEIVER_ID = r.USER_ID;

SELECT * FROM MESSAGES_INFO;

DESC MESSAGES_INFO;

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;

SELECT * FROM EMP_INFO;

create table emp_copy
as
select * from employees;

create table dept_copy
as
select * from departments;


create view emp_view_1
as
select first_name || ' ' || last_name as "ename", salary
from emp_copy;
drop view emp_view_1;

select * from emp_view_1;

update emp_view_1
set salary = salary + 100000;

select * from emp_copy;


create view emp_view_2
as
select first_name || ' ' || last_name as "ename", salary
from emp_copy
where salary > 100000;

update emp_view_2
set salary = salary - 100000;

select * from emp_view_2;



create view emp_view_3
as
select first_name || ' ' || last_name as "ename", salary
from emp_copy
where salary > 100000
with check option;

select * from emp_view_3;

update emp_view_3
set salary = 5000;


create view emp_dept_view
as
select first_name || ' ' || last_name as "ename", salary,
      department_name as "dname"
      from emp_copy inner join dept_copy using (department_id);
      
select * from emp_dept_view;