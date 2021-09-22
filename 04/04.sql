--1.Получите список всех существующих PDB в рамках экземпляра ORA12W. Определите их текущее состояние.
select *  from sys.dba_pdbs;

--2.Выполните запрос к ORA12W, позволяющий получить перечень экземпляров.
select * from v$instance;

--3.Выполните запрос к ORA12W, позволяющий получить перечень установленных компонентов СУБД Oracle 12c и их версии и статус. 
select comp_name, version, status from dba_registry;

--4.Создайте собственный экземпляр PDB (необходимо подключиться к серверу с серверного компьютера и используйте Database Configuration Assistant) с именем XXX_PDB, где XXX – инициалы студента. 
--pluggable Database Name: ZEI_PDB
--Administrator username:  admin
--Administrator password:  563

--5.Получите список всех существующих PDB в рамках экземпляра ORA12W. Убедитесь, что созданная PDB-база данных существует.
select pdb_id, pdb_name, status from dba_pdbs;

--6.Подключитесь к XXX_PDB c помощью SQL Developer создайте инфраструктурные объекты (табличные пространства, роль, профиль безопасности, пользователя с именем U1_XXX_PDB).
--MOUNTED -> OPEN
--sqlplus "connect as sysdba"
--alter pluggable database ZEI_PDB open; (read write);
select name, open_mode from v$pdbs; --READ WRITE
--файл 04_PDB.sql - system

--7.Подключитесь к пользователю U1_XXX_PDB, с помощью SQL Developer, создайте таблицу XXX_table, добавьте в нее строки, выполните SELECT-запрос к таблице.
--файл 04_PDB.sql - выдача необходимых привилегий
--Файл U1_ZEI_PDB.sql - создание

--8.С помощью представлений словаря базы данных определите, все табличные пространства, все  файлы (перманентные и временные), все роли (и выданные им привилегии), профили безопасности, всех пользователей  базы данных XXX_PDB и  назначенные им роли.
--файл 04_PDB.sql

--9.Подключитесь к CDB-базе данных, создайте общего пользователя с именем C##XXX, назначьте ему привилегию, позволяющую подключится к базе данных XXX_PDB. 
--Создайте 2 подключения пользователя C##XXX в SQL Developer к CDB-базе данных и  XXX_PDB – базе данных. Проверьте их работоспособность.  
create user C##ZEI identified by 12345;
grant create session to C##ZEI; --привилегия на создание сессии к CDB

--выдача привилегии на PDB в файле 04_PDB.sql
grant create table to C##ZEI; --для проверки работы подключения
--подключения в файлах C##ZEI_PDB.sql и C##ZEI_CDB.sql

--10.Назначьте привилегию, разрешающему подключение к XXX_PDB общему пользователю C##YYY, созданному другим студентом. Убедитесь в работоспособности  этого пользователя в базе данных XXX_PDB. 
create user C##YYY identified by 12345;


--11.Подключитесь к пользователю U1_XXX_PDB со своего компьютера, а к пользователям C##XXX и C##YYY с другого (к XXX_PDB-базе данных). 
--На своем компьютере получите список всех текущих подключений к XXX_PDB (найдите в списке созданные вами подключения). 
--На своем компьютере получите список всех текущих подключений к СDB (найдите в списке созданные вами подключений).
--(и в 04.pdb)
select username, SERVICE_NAME from v$session where username is not null order by username;
select username, SERVICE_NAME from v$session where username is not null and service_name like 'SYS$USERS' order by username;


--12.Продемонстрируйте преподавателю, работоспособную PDB-базу данных и созданную инфраструктуру (результаты всех запросов). Покажите файлы PDB-базы данных (на серверном компьютере).
--C:\Oracle_Database\oradata\ORCL

--13.Удалите созданную базу данных XXX_DB. Убедитесь, что все файлы PDB-базы данных удалены. Удалите пользователя C##XXX. Удалите в SQL Developer все подключения к XXX_PDB.


--Здесь мы подключены к CDB.
--sqlplus "connect as sysdba"
--alter pluggable database ZEI_PDB close;

--drop pluggable database ZEI_PDB including datafiles; (также может быть опция keep datafiles(по умолч) - unplugged, including - mounted/unplugged)
--select name, open_mode from v$pdbs; 
--проверить файлы в C:\Oracle_Database\oradata\ORCL
--drop user C##ZEI;


