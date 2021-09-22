--2. От имени XXX в  пространстве XXX_T1создайте таблицу из двух столбцов, один из которых будет являться первичным ключом. В таблицу добавьте 3 строки.
create table ZEI_T1(
    x integer primary key, 
    s varchar2(50)
) tablespace  ZEI_QDATA;

insert into ZEI_T1 (x, s) values (10, 'one');
insert into ZEI_T1 (x, s) values (2, 'two');
insert into ZEI_T1 (x, s) values (3, '3');
commit;

select * from ZEI_T1;


--4.Удалите (DROP) таблицу XXX_T1. Получите список сегментов табличного пространства  XXX_QDATA. Определите сегмент таблицы XXX_T1. 
--Выполните SELECT-запрос к представлению USER_RECYCLEBIN, поясните результат.
drop table ZEI_T1;
--select v file
select * from USER_RECYCLEBIN;

--5.Восстановите (FLASHBACK) удаленную таблицу. 
FLASHBACK TABLE ZEI_T1 to before drop;

--6.Выполните PL/SQL-скрипт, заполняющий таблицу XXX_T1 данными (10000 строк).
declare i integer :=0;
begin
while i<1000 LOOP
insert into ZEI_T1 (x, s) values (i, 'loop');
i := i+1;
end loop;
end;

commit;




