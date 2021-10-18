--1. ������� �� ���������� ���������������� ����� SQLNET.ORA � TNSNAMES.ORA � ������������ � �� ����������.
--C:\Oracle_Home\network\admin

--2.����������� ��� ������ sqlplus � Oracle ��� ������������ SYSTEM, �������� �������� ���������� ���������� Oracle.
--sqlplus, system, password
--select name from v$parameter

--3.����������� ��� ������ sqlplus � ������������ ����� ������ ��� ������������ SYSTEM, 
--�������� ������ ��������� �����������, ������ ��������� �����������, ����� � �������������.
--basic: connect system/password@//localhost:1521/zei_pdb
--connect system/password@WIN-VIVA74K8RUI:1521/zei_pdb

select tablespace_name from dba_tablespaces;
select file_name from dba_data_files;
select role from dba_roles;
select username from dba_users;

--4.������������ � ����������� � HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE �� ����� ����������.


--5.��������� ������� Oracle Net Manager � ����������� ������ ����������� � ������ ���_������_������������_SID, ��� SID � ������������� ������������ ���� ������. 


--6.������������ � ������� sqlplus ��� ����������� ������������� � � ����������� �������������� ������ �����������. 
--connect system@zei_pdb

--7.��������� select � ����� �������, ������� ������� ��� ������������. 
create table ZEI_table(
    x number(3), 
    s varchar2(50)
);
select * from ZEI_table;

--8.������������ � �������� HELP.�������� ������� �� ������� TIMING. �����������, ������� ������� ������ select � ����� �������.
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

--9.������������ � �������� DESCRIBE.�������� �������� �������� ����� �������.
describe zei_table;

--10.�������� �������� ���� ���������, ���������� ������� �������� ��� ������������.
select segment_name from user_segments;

--11.�������� �������������, � ������� �������� ���������� ���� ���������, ���������� ���������, ������ ������ � ������ � ����������, ������� ��� ��������.
create view zei_view as 
select count(*) as "segments_count", 
    sum(extents) as "extents_count", 
    sum(blocks) as "blocks_count", 
    sum(bytes) as "size" from user_segments;
    
show con_name;
select * from zei_view;
    
  
    