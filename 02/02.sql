--Задание 1. Табличное пространство для постоянных данных
create tablespace TS_ZEI
datafile 'TS_ZEI.dbf'
size 7M
autoextend on next 5M
maxsize 20M
extent management local;

drop tablespace TS_ZEI;

--Задание 2. Табличное пространство для временных данных
create temporary tablespace TS_ZEI_TEMP
tempfile 'TS_ZEI_TEMP.dbf'
size 5M
autoextend on next 3M
maxsize 30M
extent management local;

--Задание 3. Получите список всех табличных пространств, списки всех файлов с помощью select-запроса к словарю.
select TABLESPACE_NAME from SYS.DBA_TABLESPACES;

select FILE_NAME, TABLESPACE_NAME FROM DBA_DATA_FILES;
select FILE_NAME, TABLESPACE_NAME FROM DBA_TEMP_FILES;

--Задание 4.  Создайте роль с именем RL_XXXCORE. Назначьте ей следующие системные привилегии:
--разрешение на соединение с сервером;
--разрешение создавать и удалять таблицы, представления, процедуры и функции

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&удалять все????
alter session set "_ORACLE_SCRIPT"=true;
create role RL_ZEICORE;
grant create session, 
      create table, 
      create view, 
      create procedure
      to RL_ZEICORE;
    
drop role RL_ZEICORE;
      
--Задание 5. Найдите с помощью select-запроса роль в словаре. 
--Найдите с помощью select-запроса все системные привилегии, назначенные роли.
select * from dba_roles where role like 'RL%';
select * from dba_sys_privs where grantee='RL_ZEICORE';

--Задание 6. Создайте профиль безопасности с именем PF_XXXCORE, имеющий опции, аналогичные примеру из лекции.
create profile PF_ZEICORE limit
    password_life_time 180 --количество дней жизни пароля
    sessions_per_user 5 --количество сессий для пользователя
    failed_login_attempts 15 --количество попыток входа
    password_lock_time 1 --количество дней блокирования после ошибок
    password_reuse_time 7 --через сколько дней можно повторить пароль
    password_grace_time default --количество дней предупреждений о смене пароля
    connect_time 90 --время соединения, минут
    idle_time 25 --количество минут простоя
    
drop profile PF_ZEICORE;
    
--Задание 7. Получите список всех профилей БД. Получите значения всех параметров профиля PF_XXXCORE.
--Получите значения всех параметров профиля DEFAULT.
select distinct profile from dba_profiles;
select * from dba_profiles where profile like 'PF_ZEICORE';
select * from dba_profiles where profile like 'DEFAULT';

--Задание 8. Создайте пользователя с именем XXXCORE со следующими параметрами:
--  -табличное пространство по умолчанию: TS_XXX;
--  -табличное пространство для временных данных: TS_XXX_TEMP;
--  -профиль безопасности PF_XXXCORE;
--  -учетная запись разблокирована;
--  -срок действия пароля истек. 
create user ZEICORE IDENTIFIED BY 12345
default tablespace TS_ZEI quota unlimited on TS_ZEI
temporary tablespace TS_ZEI_TEMP
profile PF_ZEICORE
account unlock
password expire

--Задание 9. Соединитесь с сервером Oracle с помощью sqlplus и введите новый пароль для пользователя XXXCORE.  
grant RL_ZEICORE to ZEICORE

--sqlplus "connect as sysdba"
--masterkey
--alter user ZEICORE identified by 1234;


--Задание 10. Создайте соединение с помощью SQL Developer для пользователя XXXCORE. Создайте любую таблицу и любое представление.


--Задание 11. Создайте табличное пространство с именем XXX_QDATA (10m). При создании установите его в состояние offline. 
--Затем переведите табличное пространство в состояние online. 
--Выделите пользователю XXX квоту 2m в пространстве XXX_QDATA. 
--От имени пользователя XXX создайте таблицу в пространстве XXX_T1. В таблицу добавьте 3 строки.
create tablespace ZEI_QDATA
datafile 'ZEI_QDATA.dbf'
size 10M
offline

alter tablespace ZEI_QDATA online;

alter user ZEICORE quota 2M on ZEI_QDATA;




