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
    
    
    
-- �������� ���Ƽ� ���������� �ϰ������� ����� �� �ִ�.
-- �� ���ؿ��� pk�� �ϳ��ۿ� ���� 2���� ���� pk�� ���鶧�� table������������ �ؾ�.
-- not null �� ���� �����Ҷ� ������Ѵ�.
CREATE TABLE EMP02 (
  -- ���� ���� ����
  EMPNO NUMBER(4),
  ENAME VARCHAR2(10) NOT NULL,
  JOB VARCHAR2(9),
  DEPTNO NUMBER(4),
    -- �������� �ϰ������� ����
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

-- �μ���, �̸�, JOB�̸�, �ٹ����� ��ġ�� ���ø� ���
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS "�̸�",
        D.DEPARTMENT_NAME AS "�μ���",
        J.JOB_TITLE AS "��å",
        L.CITY AS "�ٹ���"
  FROM EMPLOYEES E INNER JOIN JOBS J USING(JOB_ID)
      INNER JOIN DEPARTMENTS D USING(DEPARTMENT_ID)
      INNER JOIN LOCATIONS L USING(LOCATION_ID);
      
-- �� ������ ���� �並 ����
-- ������ ������ ��� �����Ѵ�.
-- ����� �������� ������ �����ִ� ����.
-- �並 �� ���������� �ξ� �ڵ���� �������� �� �մ�.
CREATE VIEW EMP_INFO
AS
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS "�̸�",
        D.DEPARTMENT_NAME AS "�μ���",
        J.JOB_TITLE AS "��å",
        L.CITY AS "�ٹ���"
  FROM EMPLOYEES E INNER JOIN JOBS J USING(JOB_ID)
      INNER JOIN DEPARTMENTS D USING(DEPARTMENT_ID)
      INNER JOIN LOCATIONS L USING(LOCATION_ID);

SELECT * FROM EMP_INFO
WHERE �ٹ��� = 'Seattle';



DROP TABLE USERS;
DROP TABLE MESSAGES;
-- ȸ�� ������ ������ �� �ִ� ���̺��� �ۼ��ϼ���
-- ���̵�, �н�����, �̸�, ����, ����ó
-- (���̵��� ���� �ٸ� ���ڵ�� ���еǴ� ���Դϴ�.)
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

-- ȸ���鰣�� ���� �޼��� ������ �����ϴ� ���̺��� �����ϼ���.
create table messages (
  message_id number(5) CONSTRAINT messages_ID_PK primary key,
  sender_id varchar2(20) CONSTRAINT messages_sender_id_FK REFERENCES users(user_id),
  receiver_id varchar2(20) CONSTRAINT messages_receiver_id_FK REFERENCES users(user_id),
  contents varchar2(500) CONSTRAINT messages_contents_NN not null,
  send_date DATE CONSTRAINT messages_send_date_NN not null,
  receive_date TIMESTAMP
);
drop table messages;
-- aaa �� ccc ���� �޼����� �������� insert ������ �ۼ��ϼ���.
insert into messages values (1, 'aaa', 'ccc', '����~!', SYSDATE, null);
-- aaa �� ddd ���� �޼����� �������� insert ������ �ۼ��ϼ���.
insert into messages values (2, 'aaa', 'ddd', '���� ���׿�~!', SYSDATE, null);
-- aaa �� eee ���� �޼����� �������� insert ������ �ۼ��ϼ���.
insert into messages values (3, 'aaa', 'eee', '���ɽĻ��???', SYSDATE, null);
-- bbb �� eee ���� �޼����� �������� insert ������ �ۼ��ϼ���.
insert into messages values (4, 'bbb', 'eee', '���� ������ ���?', SYSDATE, null);

select * from MESSAGES;

update messages
set RECEIVE_DATE = sysdate
where MESSAGE_ID = 3;

CREATE VIEW MSGV
AS
SELECT S.USER_NAME AS "���� ���", R.USER_NAME AS "�޴� ���" , M.CONTENTS AS "�޼��� ����"
FROM USERS S INNER JOIN MESSAGES M ON S.USER_ID = M.SENDER_ID
	INNER JOIN USERS R ON M.RECEIVER_ID = R.USER_ID;
  
SELECT * FROM MSGV;


-- ���� ���, �޴� ���, �޼��� ����, ���� ����, ���� ����
CREATE VIEW MESSAGES_INFO
AS
select m.MESSAGE_ID as "�޼�����ȣ", s.USER_name as "�������", 
  r.USER_name as "�޴»��", m.CONTENTS as "�޼�������", 
  m.SEND_DATE as "��������", 
  nvl(TO_CHAR(m.RECEIVE_DATE,'YYYY:MM:DD DAY PM HH:MI:SS'), 'Ȯ����������') as "��������"
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