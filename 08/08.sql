--1. Найдите на компьютере конфигурационные файлы SQLNET.ORA и TNSNAMES.ORA и ознакомьтесь с их содержимым.
--C:\Oracle_Home\network\admin

--2.Соединитесь при помощи sqlplus с Oracle как пользователь SYSTEM, получите перечень параметров экземпляра Oracle.
--sqlplus, system, password
--select name from v$parameter

--3.Соединитесь при помощи sqlplus с подключаемой базой данных как пользователь SYSTEM, 
--получите список табличных пространств, файлов табличных пространств, ролей и пользователей.
--basic: connect system/password@//localhost:1521/zei_pdb
--connect system/password@WIN-VIVA74K8RUI:1521/zei_pdb

select tablespace_name from dba_tablespaces;
select file_name from dba_data_files;
select role from dba_roles;
select username from dba_users;

--4.Ознакомьтесь с параметрами в HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE на вашем компьютере.


--5.Запустите утилиту Oracle Net Manager и подготовьте строку подключения с именем имя_вашего_пользователя_SID, где SID – идентификатор подключаемой базы данных. 


--6.Подключитесь с помощью sqlplus под собственным пользователем и с применением подготовленной строки подключения. 
--connect system@zei_pdb

--7.Выполните select к любой таблице, которой владеет ваш пользователь. 
create table ZEI_table(
    x number(3), 
    s varchar2(50)
);
select * from ZEI_table;

--8.Ознакомьтесь с командой HELP.Получите справку по команде TIMING. Подсчитайте, сколько времени длится select к любой таблице.
declare i integer :=0;
begin
while i<1000 LOOP
insert into ZEI_table (x, s) values (i, 'loop');
i := i+1;
end loop;
end;
commit;


--timing start t;
--select * from zei_table;
--timing stop;

--9.Ознакомьтесь с командой DESCRIBE.Получите описание столбцов любой таблицы.
describe zei_table;

--10.Получите перечень всех сегментов, владельцем которых является ваш пользователь.
select segment_name from user_segments;

--11.Создайте представление, в котором получите количество всех сегментов, количество экстентов, блоков памяти и размер в килобайтах, которые они занимают.
create view zei_view as 
select count(*) as "segments_count", 
    sum(extents) as "extents_count", 
    sum(blocks) as "blocks_count", 
    sum(bytes) as "size" from user_segments;
    
show con_name;
select * from zei_view;
    
  
    