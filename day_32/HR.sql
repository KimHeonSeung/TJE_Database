-- commit : ���� ��ɾ���� ���۷� ����Ѱ� ���� �����ͺ��̽� ����
-- rollback : ���� ���� ���۸� ����.

create table dept02
as
select * from departments;

delete from dept01;
select * from dept01;
update dept01
set manager_id = 1;
commit;
rollback;
select * from tabs;

drop table dept03;
drop table dept02;
drop table sam02;
drop table sam01;
drop table emp01;

delete from dept02
where department_id = 40;

create table dept03
as
select * from departments;
rollback;

select * from dept02
where department_id = 40;

create table dept
as
select *
from departments;

select *
from dept;
-- Ʈ����� ����
delete from dept
where department_id = 30;

savepoint s1;

delete from dept
where department_id = 20;

savepoint s2;

delete from dept
where department_id = 10;

rollback ;
rollback to s2;
rollback to s1;
-- ���̺�ǤƮ �Ҷ����� ���ۿ� �̸��� ����
-- ����s1, ����s2, ...


-- �⺻Ű �������� : ���� ������ �ߺ� X
-- �ܷ�Ű �������� : �����ϰ��ִ� ���̺��� �⺻Ű���� ������ �����.

desc departments;
-- not null : �ݵ�� ���� ���;��Ѵٴ� �� (�μ��̸��� ��ȣ�� �� �־��)
-- �Ŵ�����ȣ, ������ȣ�� ���̿��� �������.

insert into departments (Manager_id, location_id)
values (121, 1700);

select * from departments;

insert into departments
values (10, 'Class-304', 121, 1700);

-- ������ ��ųʸ��� �������� Ȯ��
desc user_constraints;

select owner, constraint_name, constraint_type, table_name
from user_constraints;

create table emp (
  empno number(4) not null,
  empname varchar2(20) not null,
  deptno number(2)
);

select * from emp;

insert into emp
values (1, 'E_1', 11);

insert into emp (empname, deptno)
values ('E_2', 2);


create table emp03 (
  empno number(4) unique,
  ename varchar2(10) not null,
  job varchar2(9),
  deptno number(2)
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

create table emp04 (
  empno number(4)constraint emp04_empno_uk unique,
  ename varchar2(10) constraint emp04_ename_nn not null,
  job varchar2(9),
  deptno number(2)
);
select table_name, constraint_name from user_constraints
where table_name = 'EMP04';

drop table emp;
create table emp (
  EMPNO NUMBER(4) CONSTRAINT EMP05_EMPNO_PK PRIMARY KEY ,
  ENAME VARCHAR2(10) CONSTRAINT EMP05_ENAME_NN NOT NULL, 
  JOB VARCHAR2(9),
  DEPTNO NUMBER(2)
);
-- unique + not null = primary key : �˻��� �� �⺻Ű �÷��� �ϸ� ������.
insert into emp values (1, 'AAA', 'MGR', 11);
insert into emp values (2, 'BBB', 'PRG', 22);
insert into emp values (3, 'CCC', 'KING', 33);

select * from emp;

CREATE TABLE EMP ( 
  EMPNO NUMBER(4) 
    CONSTRAINT EMP_NO_PK PRIMARY KEY ,
  ENAME VARCHAR2(10) 
    CONSTRAINT EMP_NAME_NN NOT NULL, 
  JOB VARCHAR2(9),
  DEPTNO NUMBER(2)
    -- �θ����̺��� dept�� deptnoĮ���� �����ϰڴٴ� �ǹ�
    CONSTRAINT EMP_DEPTNO_FK 
    REFERENCES departments(department_id)
); 
select * from emp;
insert into emp values (1, 'AAA', 'MGR', 10);
insert into emp values (2, 'BBB', 'PRG', 20);
insert into emp values (3, 'CCC', 'KING', 30);

-- ȸ�������� ������ �� �ִ� ���̺� �ۼ�
-- ���̵�, �н�����, �̸�, ����, ����ó
-- (���̵��� ���� �ٸ� ���ڵ�� ���еǴ� ���̴�.)
create table Info (
  ID varchar2(20) CONSTRAINT Info_ID_PK primary key,
  PASSWORD varchar2(20) constraint Info_PW_NN not null,
  NAME varchar2(20) constraint Info_NAME_NN not null,
  AGE number(4) constraint Info_AGE_NN not null,
  PHONE varchar2(30) constraint Info_PHONE_NN not null
);
select table_name, constraint_name from user_constraints;
select table_name, constraint_name from user_constraints
where lower(table_name) = 'info';


create table users (
  user_ID varchar2(20) CONSTRAINT USERS_ID_PK primary key,
  user_PW varchar2(20) constraint USERS_PW_NN not null,
  user_NAME varchar2(20) constraint USERS_NAME_NN not null,
  user_AGE number(3), 
  user_tel varchar2(20) 
);
DROP TABLE MESSAGES;
SELECT * FROM USERS;
INSERT INTO USERS VALUES ('AAA', '111', 'A1', NULL, NULL);
INSERT INTO USERS VALUES ('BBB', '222', 'B1', NULL, NULL);
INSERT INTO USERS VALUES ('CCC', '333', 'C1', NULL, NULL);
INSERT INTO USERS VALUES ('DDD', '444', 'D1', NULL, NULL);
INSERT INTO USERS VALUES ('EEE', '555', 'E1', NULL, NULL);
-- ȸ���� ���� ���� �޼����� �����ϴ� ���̺��� �����ϼ���.
CREATE TABLE MESSAGES (
  MESSAGE_ID NUMBER(5) CONSTRAINT MESSAGES_ID_PK PRIMARY KEY,
  SENDER_ID VARCHAR2(20)
    CONSTRAINT MESSAGES_SENDER_ID_FK
    REFERENCES USERS(USER_ID),
  
  RECEIVER_ID VARCHAR2(20)
    CONSTRAINT MESSAGES_RECEIVER_ID_FK
    REFERENCES USERS(USER_ID),
  
  CONTENTS VARCHAR2(500) 
    CONSTRAINT MESSAGES_CONTENTS_NN
    NOT NULL,
    
  SEND_DATE DATE 
    CONSTRAINT MESSAGES_SEND_DATE_NN 
    NOT NULL,
    
  RECEIVE_DATE TIMESTAMP -- TIMESTAMP �ؾ� �ð����� �ٳ���
);

-- AAA�� CCC���� �޼����� �������� INSERT ���� �ۼ�
-- AAA�� DDD���� �޼����� �������� INSERT ���� �ۼ�
-- AAA�� EEE���� �޼����� �������� INSERT ���� �ۼ�
-- BBB�� EEE���� �޼����� �������� INSERT ���� �ۼ�
INSERT INTO MESSAGES 
VALUES(1, 'AAA', 'CCC', 'HI, CCC ! I''M AAA', SYSDATE, NULL);
INSERT INTO MESSAGES 
VALUES(2, 'AAA', 'DDD', 'HI, DDD ! I''M AAA', SYSDATE, NULL);
INSERT INTO MESSAGES 
VALUES(3, 'AAA', 'EEE', 'HI, EEE ! I''M AAA', SYSDATE, NULL);
INSERT INTO MESSAGES 
VALUES(4, 'BBB', 'EEE', 'HI, EEE ! I''M BBB', SYSDATE, NULL);
SELECT * FROM MESSAGES;

-- AAA�� EEE���� ���� RECEIVE_DATE�� ���ݽð����� ����
UPDATE MESSAGES
SET RECEIVE_DATE = SYSDATE
WHERE MESSAGE_ID = 3;

-- �� ����ں� ������ �޼��� ����
SELECT USER_ID, COUNT(*) AS "Ȯ������ ���� �޼����� ����"
FROM USERS U INNER JOIN MESSAGES M ON U.USER_ID = M.RECEIVER_ID
WHERE M.RECEIVE_DATE IS NULL
GROUP BY U.USER_ID
ORDER BY U.USER_ID;
SELECT * FROM MESSAGES;
-- �Ǵ�
--SELECT RECEIVER_ID, COUNT(*)
--FROM MESSAGES
--WHERE RECEIVE_DATE IS NULL
--GROUP BY RECEIVER_ID
--ORDER BY RECEIVER_ID;
 
-- ������� �̸�, �޴»�� �̸�, �޼��� ����, ������¥, ������¥ ���̺�
-- MESSAGES M�� �������� ���ʿ� USERS S�� �־ ������ ����� ������ �ְ�
-- �����ʿ� USERS R�� �־ �޴� ����� ������ �ִ�.
SELECT M.MESSAGE_ID AS "�޼��� ��ȣ", S.USER_NAME AS "�������",
    R.USER_NAME AS "�޴»��", M.CONTENTS AS "�޼��� ����",
    M.SEND_DATE AS "���� ��¥",
    NVL(TO_CHAR(M.RECEIVE_DATE, 'YYYY:MM:DD DAY PM HH:MI:SS'), 'Ȯ������ ����') AS "���� ��¥"
FROM USERS S INNER JOIN MESSAGES M ON S.USER_ID = M.SENDER_ID
    INNER JOIN USERS R ON M.RECEIVER_ID = R.USER_ID;
    

-- �򰥷��� �غ��ڵ�
SELECT * FROM USERS S INNER JOIN MESSAGES M ON S.USER_ID = M.SENDER_ID;
CREATE TABLE JOINT
AS
SELECT * FROM USERS S INNER JOIN MESSAGES M ON S.USER_ID = M.SENDER_ID;
SELECT * FROM JOINT J INNER JOIN USERS R ON J.RECEIVER_ID = R.USER_ID;
    
    
    
-- A1�� ������ �޼����� ������ ����ϼ���
-- 1. ��ü ���� ���� = 3
SELECT COUNT(*) AS "��ü ���� ����"
FROM MESSAGES
WHERE SENDER_ID IN (
    SELECT USER_ID
    FROM USERS
    WHERE USER_NAME = 'A1'
);
-- 2. Ȯ���� ���� = 1
SELECT COUNT(*) AS "Ȯ���� ����"
FROM MESSAGES
WHERE MESSAGE_ID IN (
    SELECT MESSAGE_ID
    FROM MESSAGES
    WHERE SENDER_ID = (
      SELECT USER_ID
      FROM USERS
      WHERE USER_NAME = 'A1'
    ) AND RECEIVE_DATE IS NOT NULL
);

-- 3. Ȯ������ ���� ���� = 2
SELECT COUNT(*) AS "Ȯ������ ���� ����"
FROM MESSAGES
WHERE MESSAGE_ID IN (
    SELECT MESSAGE_ID
    FROM MESSAGES
    WHERE SENDER_ID = (
      SELECT USER_ID
      FROM USERS
      WHERE USER_NAME = 'A1'
    ) AND RECEIVE_DATE IS NULL
);


--SELECT USER_NAME1 AS "�������", USER_NAME2 AS "�޴»��", M.CONTENTS AS "�޼��� ����",
--        M.SEND_DATE AS "������¥", M.REICEIVE_DATE AS "������¥"
--FROM USERS U INNER JOIN MESSAGES M ON U.USER_ID = M.RECEIVER_ID
--WHERE USER_NAME1 IN (SELECT SENDER_ID FROM MESSAGES GROUP BY SENDER_ID)
--    AND USER_NAME2 = (SELECT RECEIVER_ID FROM MESSAGES WHERE SENDER_ID = USER_NAME1);
    

-- ���� �ۼ��Ѱ� ( MESSAGE_ID�� �⺻Ű�� ���� ������� )
--DROP TABLE MESSAGES_MY;
--CREATE TABLE MESSAGES_MY (
--    SEND_ID VARCHAR2(20) 
--      CONSTRAINT MESSAGES_SID_FK
--      REFERENCES USERS(USER_ID),
--    MSG VARCHAR2(4000)
--      CONSTRAINT MESSAGES_MSG_NN
--      NOT NULL,
--    RECEIVE_ID VARCHAR2(20)
--      CONSTRAINT MESSAGES_RID_FK
--      REFERENCES USERS(USER_ID)
--);
--DROP TABLE MESSAGES;
--
--SELECT * FROM MESSAGES;
--INSERT INTO MESSAGES VALUES (111, 'HI LEE', 222);
--INSERT INTO MESSAGES VALUES (222, 'HI KIM', 111);
--INSERT INTO MESSAGES VALUES (333, 'HELLO', 111);
--INSERT INTO MESSAGES VALUES (333, 'HELLO', 222);
--INSERT INTO MESSAGES VALUES (333, 'SIJGPSORIJSEIJSERIJESPRIGJ', 111);
