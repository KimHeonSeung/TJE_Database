create database chat;

use chat;

create table member (
	id varchar(20) primary key,
    password varchar(20) not null,
    name varchar(20) not null,
    nick varchar(20) not null,
    regist_date timestamp
);

create table message (
	id int auto_increment ,
    sender varchar(20), -- 멤버의 id를 참조할것이므로 똑같은 형태로 선언
    receiver varchar(20),
    message varchar(500) not null,
    send_date timestamp not null,
    receive_date timestamp,
    primary key (id),
    foreign key (sender) references member(id),
    foreign key (receiver) references member(id)
);

create view message_view
as
select msg.id, sender, s.name as "sender_name", receiver, r.name as "receiver_name", message, send_date, receive_date
from member s inner join message msg 
	on s.id = msg.sender
    inner join member r
		on msg.receiver = r.id;

drop table member;
select * from member;
select * from message;
select * from message_view;

create table notice (
	id int auto_increment,
	message varchar(500),
    write_date timestamp,
    primary key (id)
);
select * from notice;
drop table notice;
select send_time, nmsg from notice order by send_time desc Limit 10;
