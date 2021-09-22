--6.Подключитесь к XXX_PDB c помощью SQL Developer создайте инфраструктурные объекты (табличные пространства, роль, профиль безопасности, пользователя с именем U1_XXX_PDB).
create tablespace TS_ZEI
datafile 'TS_ZEI4.dbf'
size 7M
autoextend on next 5M
maxsize 20M
extent management local;

alter session set "_ORACLE_SCRIPT" = true;
create role RL_ZEICORE;
grant create session,
      create table,  drop any table,
      create view,   drop any view,
      create procedure, drop any procedure 
      to RL_ZEICORE;
    
create profile PF_ZEI_PDB limit
    password_life_time 180 --количество дней жизни пароля
    sessions_per_user 5 --количество сессий для пользователя
    failed_login_attempts 15 --количество попыток входа
    password_lock_time 1 --количество дней блокирования после ошибок
    password_reuse_time 7 --через сколько дней можно повторить пароль
    password_grace_time default --количество дней предупреждений о смене пароля
    connect_time 90 --время соединения, минут
    idle_time 25 --количество минут простоя
    container = current;
    
SELECT * FROM DBA_PROFILES;
     
create user U1_ZEI_PDB IDENTIFIED BY 12345
default tablespace TS_ZEI quota unlimited on TS_ZEI
profile PF_ZEICORE
account unlock
password expire;


--7.Подключитесь к пользователю U1_XXX_PDB, с помощью SQL Developer, создайте таблицу XXX_table, добавьте в нее строки, выполните SELECT-запрос к таблице.
grant RL_ZEICORE to U1_ZEI_PDB;
grant create session to U1_ZEI_PDB;
grant create table, drop any table to U1_ZEI_PDB;

alter user U1_ZEI_PDB identified by 1234;


--8.С помощью представлений словаря базы данных определите, все табличные пространства, все  файлы (перманентные и временные), 
--все роли (и выданные им привилегии), профили безопасности, всех пользователей  базы данных XXX_PDB и  назначенные им роли.
select * from USER_TABLESPACES;

select FILE_NAME, TABLESPACE_NAME FROM DBA_DATA_FILES;
select FILE_NAME, TABLESPACE_NAME FROM DBA_TEMP_FILES;

--роли
select distinct role from dba_roles;
select role, privilege from ROLE_SYS_PRIVS  order by role -- роли и назначенные им привилегии.

--профили безопасности
select distinct profile from dba_profiles 

--пользователи
select distinct username from DBA_USERS; --все пользователи бд
select * from all_users;
select * from user_sys_privs --текущему пользователю
select grantee, privilege from dba_sys_privs; --привилегии пользователей


--9.Подключитесь к CDB-базе данных, создайте общего пользователя с именем C##XXX, назначьте ему привилегию, позволяющую подключиться к базе данных XXX_PDB. 
--Создайте 2 подключения пользователя C##XXX в SQL Developer к CDB-базе данных и  XXX_PDB – базе данных. Проверьте их работоспособность.  
--Привилегии для PDB
grant create session to C##ZEI; --привилегия на создание сессии к PDB
grant create table to  C##ZEI; --для проверки работы подключения

--10. 
grant create session to C##YYY;

--11.
SELECT username, SERVICE_NAME FROM v$session WHERE username IS NOT NULL ORDER BY username;


