--2. �� ����� XXX �  ������������ XXX_T1�������� ������� �� ���� ��������, ���� �� ������� ����� �������� ��������� ������. � ������� �������� 3 ������.
create table ZEI_T1(
    x integer primary key, 
    s varchar2(50)
) tablespace  ZEI_QDATA;

insert into ZEI_T1 (x, s) values (10, 'one');
insert into ZEI_T1 (x, s) values (2, 'two');
insert into ZEI_T1 (x, s) values (3, '3');
commit;

select * from ZEI_T1;


--4.������� (DROP) ������� XXX_T1. �������� ������ ��������� ���������� ������������  XXX_QDATA. ���������� ������� ������� XXX_T1. 
--��������� SELECT-������ � ������������� USER_RECYCLEBIN, �������� ���������.
drop table ZEI_T1;
--select v file
select * from USER_RECYCLEBIN;

--5.������������ (FLASHBACK) ��������� �������. 
FLASHBACK TABLE ZEI_T1 to before drop;

--6.��������� PL/SQL-������, ����������� ������� XXX_T1 ������� (10000 �����).
declare i integer :=0;
begin
while i<1000 LOOP
insert into ZEI_T1 (x, s) values (i, 'loop');
i := i+1;
end loop;
end;

commit;




