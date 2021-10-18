--1.�������� ������ ���� ������ ��������� ����������� (������������  � ���������).
select FILE_NAME, TABLESPACE_NAME FROM DBA_DATA_FILES;
select FILE_NAME, TABLESPACE_NAME FROM DBA_TEMP_FILES;

show parameter control;

--2.�������� ��������� ������������ � ������ XXX_QDATA (10m). ��� �������� ���������� ��� � ��������� offline. ����� ���������� ��������� ������������ � ��������� online. �������� ������������ XXX ����� 2m � ������������ XXX_QDATA. 
--(05_ZEI) �� ����� XXX �  ������������ XXX_T1�������� ������� �� ���� ��������, ���� �� ������� ����� �������� ��������� ������. � ������� �������� 3 ������.
drop tablespace ZEI_QDATA including contents;
create tablespace ZEI_QDATA
datafile 'ZEI_QDATA05.dbf'
size 10M
offline;

alter tablespace ZEI_QDATA online;

alter session set "_ORACLE_SCRIPT" = true;
create user ZEI identified by 123;
grant create session, create table, drop any table to ZEI;
alter user ZEI quota 2M on ZEI_QDATA;


--3.�������� ������ ��������� ���������� ������������  XXX_QDATA. ���������� ������� ������� XXX_T1. ���������� ��������� ��������.
select * from dba_segments where tablespace_name like 'ZEI_QDATA';

--4. 05_ZEI.sql
select * from dba_segments where tablespace_name like 'ZEI_QDATA';

--5. 05_ZEI.sql
--6. 05_ZEI.sql

--7.���������� ������� � �������� ������� XXX_T1 ���������, �� ������ � ������ � ������. �������� �������� ���� ���������. 
--������� ��������� ������������ XXX_QDATA � ��� ����.
select * from dba_segments where tablespace_name like 'ZEI_QDATA';

--8.������� ��������� ������������ XXX_QDATA � ��� ����. 
drop tablespace ZEI_QDATA including contents and datafiles;


--9.�������� �������� ���� ����� �������� �������. ���������� ������� ������ �������� �������.
select * from v$log;

--10.�������� �������� ������ ���� �������� ������� ��������.
select * from v$logfile;

--11.EX. � ������� ������������ �������� ������� �������� ������ ���� ������������. �������� ��������� ����� � ������ ������ ������� ������������ (��� ����������� ��� ���������� ��������� �������).
select * from v$log;
alter system switch logfile;
--7:48 AM
--SCN: 3172423 441

--12.EX. �������� �������������� ������ �������� ������� � ����� ������� �������. ��������� � ������� ������ � ������, � ����� � ����������������� ������ (�������������). ���������� ������������������ SCN. 
alter database add logfile group 4 'C:\Oracle_Database\oradata\ORCL\REDO04.LOG' size 50m blocksize 512;
alter database add logfile member 'C:\Oracle_Database\oradata\ORCL\REDO041.LOG'  to group 4;
alter database add logfile member 'C:\Oracle_Database\oradata\ORCL\REDO042.LOG'  to group 4;
select * from v$log;
alter system switch logfile;
--SCN: 3173518

--13.EX. ������� ��������� ������ �������� �������. ������� ��������� ���� ����� �������� �� �������.
alter database drop logfile member 'C:\Oracle_Database\oradata\ORCL\REDO042.LOG';
alter database drop logfile member 'C:\Oracle_Database\oradata\ORCL\REDO041.LOG';
alter database drop logfile group 4; 

select * from v$log;


--14.����������, ����������� ��� ��� ������������� �������� ������� (������������� ������ ���� ���������, ����� ���������, ���� ������ ������� �������� ������� � ��������).
select NAME, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from V$INSTANCE;

--15.���������� ����� ���������� ������.  
select * from v$archived_log

--16.EX.  �������� �������������. 
--sql plus "connect as sysdba"
--shutdown immediate;
--startup mount;
--alter database archivelog;
--alter database open;
select NAME, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from V$INSTANCE;

--17.EX. ������������� �������� �������� ����. ���������� ��� �����. ���������� ��� �������������� � ��������� � ��� �������. ���������� ������������������ SCN � ������� � �������� �������. 
alter system switch logfile;
select * from v$archived_log; --3173543


--18.EX. ��������� �������������. ���������, ��� ������������� ���������. 
--shutdown immediate;
--startup mount;
--alter database noarchivelog;
--alter database open;
select NAME, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from V$INSTANCE;


--19.�������� ������ ����������� ������.
select * from v$controlfile;


--20.�������� � ���������� ���������� ������������ �����. �������� ��������� ��� ��������� � �����.
show parameter control;
select * from v$controlfile_record_section;


--21.���������� �������������� ����� ���������� ��������. ��������� � ������� ����� �����. 
--C:\Oracle_Home\database\SPFILEORCL.ora
--select * from v$parameter; ����������

--22.����������� PFILE � ������ XXX_PFILE.ORA. ���������� ��� ����������. �������� ��������� ��� ��������� � �����.
--create pfile = 'ZEI_PFILE.ORA' from spfile; sysdba


--23.���������� �������������� ����� ������� ��������. ��������� � ������� ����� �����. 
--"C:\Oracle_Home\database\PWDorcl.ora"

--24.�������� �������� ����������� ��� ������ ��������� � �����������. 
select * from v$diag_info;

--25.EX. ������� � ���������� ���������� ��������� ������ �������� (LOG.XML), ������� � ��� ������� ������������ �������� ������� �� ���������.
--C:\Oracle_Database\diag\rdbms\orcl\orcl\alert

-- Current log# 3 seq# 12 mem# 0: C:\ORACLE_DATABASE\ORADATA\ORCL\REDO03.LOG
