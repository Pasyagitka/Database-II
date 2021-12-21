--1.Подключитесь к серверу ORA12D. Создайте DBLINK по схеме USER1-USER2 для подключения к вашей базе данных (ваша БД находится на сервере ORA12W). 
GRANT CREATE DATABASE LINK TO zei; --system to pdb
select * from User_sys_privs;
select * from ALL_DB_LINKS

drop database link anotherdb;

CREATE  DATABASE LINK anotherdb
CONNECT TO system
IDENTIFIED BY tiger
USING '(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = WIN-BE8AHJ6LH6T)(PORT = 1521)))
        (CONNECT_DATA = (SERVICE_NAME = orcl)))';
   

--2. Продемонстрируйте выполнение операторов SELECT, INSERT, UPDATE, DELETE, вызов процедур и функций с объектами удаленного сервера.
SELECT id, field FROM table14@anotherdb;
select * from faculty@anotherdb;
select * from pulpit@anotherdb;
select * from teacher@anotherdb;

declare
    s nvarchar2(30) := 'String number ';
begin
    for x in 21..23
    loop
        insert into table14@anotherdb(id, field) values(x, concat(s, to_char(x)));
    end loop;
    commit;    
end;

update table14@anotherdb set field = 'String number 88' where id = 8;
delete from table14@anotherdb where id = 4; 

declare
	x varchar2(1000);
	status int;
begin
	dbms_output.enable@anotherdb;
	proc14@anotherdb('ISIT');
 	loop
		dbms_output.get_line@anotherdb( x,status);
	exit when status != 0;
 	dbms_output.put_line(x);
 end loop;
	dbms_output.disable@anotherdb;
end;
begin
  dbms_output.put_line('Количество преподавателей на кафедре ИСИТ: ' || func14@anotherdb('ISIT'));
end;



--3.Создайте DBLINK по схеме USER - GLOBAL.
GRANT CREATE PUBLIC DATABASE LINK, DROP PUBLIC DATABASE LINK TO zei

drop public database link PUBLIC_ANOTHERDB 

create public database link PUBLIC_ANOTHERDB 
connect to system
identified by tiger
using '(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = WIN-BE8AHJ6LH6T)(PORT = 1521)))
        (CONNECT_DATA = (SERVICE_NAME = orcl)))';

--4.Продемонстрируйте выполнение операторов SELECT, INSERT, UPDATE, DELETE, вызов процедур и функций с объектами удаленного сервера
select * from table14@public_anotherdb;

declare
    s nvarchar2(30) := 'String number ';
begin
    for x in 11..20
    loop
        insert into table14@public_anotherdb(id, field) values(x, concat(s, to_char(x)));
    end loop;
    commit;    
end;

select * from table14@public_anotherdb;
update table14@public_anotherdb set field = 'String number 222' where id = 12;
delete from table14@public_anotherdb where id = 16; 


declare
	x varchar2(1000);
	status int;
begin
	dbms_output.enable@public_anotherdb;
	proc14@public_anotherdb('ISIT');
 	loop
		dbms_output.get_line@public_anotherdb( x,status);
	exit when status != 0;
 	dbms_output.put_line(x);
 end loop;
	dbms_output.disable@public_anotherdb;
end;
begin
  dbms_output.put_line('Количество преподавателей на кафедре ИСИТ: ' || func14@anotherdb('ISIT'));
end;



declare
    s nvarchar2(30) := 'String number ';
begin
    for x in 1..10
    loop
        insert into table14@public_anotherdb(id, field) values(x, concat(s, to_char(x)));
    end loop;
    commit;    
end;

SELECT name FROM table14@public_anotherdb;
update Table14 set field = 'String number 88' where id = 8;
delete from Table14 where id = 4; 



ALTER SESSION CLOSE DATABASE LINK anotherdb;
ALTER SESSION CLOSE DATABASE LINK public_anotherdb;
