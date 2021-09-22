--1.�������� ������ ���� ������������ PDB � ������ ���������� ORA12W. ���������� �� ������� ���������.
select *  from sys.dba_pdbs;

--2.��������� ������ � ORA12W, ����������� �������� �������� �����������.
select * from v$instance;

--3.��������� ������ � ORA12W, ����������� �������� �������� ������������� ����������� ���� Oracle 12c � �� ������ � ������. 
select comp_name, version, status from dba_registry;

--4.�������� ����������� ��������� PDB (���������� ������������ � ������� � ���������� ���������� � ����������� Database Configuration Assistant) � ������ XXX_PDB, ��� XXX � �������� ��������. 
--pluggable Database Name: ZEI_PDB
--Administrator username:  admin
--Administrator password:  563

--5.�������� ������ ���� ������������ PDB � ������ ���������� ORA12W. ���������, ��� ��������� PDB-���� ������ ����������.
select pdb_id, pdb_name, status from dba_pdbs;

--6.������������ � XXX_PDB c ������� SQL Developer �������� ���������������� ������� (��������� ������������, ����, ������� ������������, ������������ � ������ U1_XXX_PDB).
--MOUNTED -> OPEN
--sqlplus "connect as sysdba"
--alter pluggable database ZEI_PDB open; (read write);
select name, open_mode from v$pdbs; --READ WRITE
--���� 04_PDB.sql - system

--7.������������ � ������������ U1_XXX_PDB, � ������� SQL Developer, �������� ������� XXX_table, �������� � ��� ������, ��������� SELECT-������ � �������.
--���� 04_PDB.sql - ������ ����������� ����������
--���� U1_ZEI_PDB.sql - ��������

--8.� ������� ������������� ������� ���� ������ ����������, ��� ��������� ������������, ���  ����� (������������ � ���������), ��� ���� (� �������� �� ����������), ������� ������������, ���� �������������  ���� ������ XXX_PDB �  ����������� �� ����.
--���� 04_PDB.sql

--9.������������ � CDB-���� ������, �������� ������ ������������ � ������ C##XXX, ��������� ��� ����������, ����������� ����������� � ���� ������ XXX_PDB. 
--�������� 2 ����������� ������������ C##XXX � SQL Developer � CDB-���� ������ �  XXX_PDB � ���� ������. ��������� �� �����������������.  
create user C##ZEI identified by 12345;
grant create session to C##ZEI; --���������� �� �������� ������ � CDB

--������ ���������� �� PDB � ����� 04_PDB.sql
grant create table to C##ZEI; --��� �������� ������ �����������
--����������� � ������ C##ZEI_PDB.sql � C##ZEI_CDB.sql

--10.��������� ����������, ������������ ����������� � XXX_PDB ������ ������������ C##YYY, ���������� ������ ���������. ��������� � �����������������  ����� ������������ � ���� ������ XXX_PDB. 
create user C##YYY identified by 12345;


--11.������������ � ������������ U1_XXX_PDB �� ������ ����������, � � ������������� C##XXX � C##YYY � ������� (� XXX_PDB-���� ������). 
--�� ����� ���������� �������� ������ ���� ������� ����������� � XXX_PDB (������� � ������ ��������� ���� �����������). 
--�� ����� ���������� �������� ������ ���� ������� ����������� � �DB (������� � ������ ��������� ���� �����������).
--(� � 04.pdb)
select username, SERVICE_NAME from v$session where username is not null order by username;
select username, SERVICE_NAME from v$session where username is not null and service_name like 'SYS$USERS' order by username;


--12.����������������� �������������, ��������������� PDB-���� ������ � ��������� �������������� (���������� ���� ��������). �������� ����� PDB-���� ������ (�� ��������� ����������).
--C:\Oracle_Database\oradata\ORCL

--13.������� ��������� ���� ������ XXX_DB. ���������, ��� ��� ����� PDB-���� ������ �������. ������� ������������ C##XXX. ������� � SQL Developer ��� ����������� � XXX_PDB.


--����� �� ���������� � CDB.
--sqlplus "connect as sysdba"
--alter pluggable database ZEI_PDB close;

--drop pluggable database ZEI_PDB including datafiles; (����� ����� ���� ����� keep datafiles(�� �����) - unplugged, including - mounted/unplugged)
--select name, open_mode from v$pdbs; 
--��������� ����� � C:\Oracle_Database\oradata\ORCL
--drop user C##ZEI;


