--������� 1. ��������� ������������ ��� ���������� ������
create tablespace TS_ZEI
datafile 'TS_ZEI.dbf'
size 7M
autoextend on next 5M
maxsize 20M
extent management local;

drop tablespace TS_ZEI;

--������� 2. ��������� ������������ ��� ��������� ������
create temporary tablespace TS_ZEI_TEMP
tempfile 'TS_ZEI_TEMP.dbf'
size 5M
autoextend on next 3M
maxsize 30M
extent management local;

--������� 3. �������� ������ ���� ��������� �����������, ������ ���� ������ � ������� select-������� � �������.
select TABLESPACE_NAME from SYS.DBA_TABLESPACES;

select FILE_NAME, TABLESPACE_NAME FROM DBA_DATA_FILES;
select FILE_NAME, TABLESPACE_NAME FROM DBA_TEMP_FILES;

--������� 4.  �������� ���� � ������ RL_XXXCORE. ��������� �� ��������� ��������� ����������:
--���������� �� ���������� � ��������;
--���������� ��������� � ������� �������, �������������, ��������� � �������

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&������� ���????
alter session set "_ORACLE_SCRIPT"=true;
create role RL_ZEICORE;
grant create session, 
      create table, 
      create view, 
      create procedure
      to RL_ZEICORE;
    
drop role RL_ZEICORE;
      
--������� 5. ������� � ������� select-������� ���� � �������. 
--������� � ������� select-������� ��� ��������� ����������, ����������� ����.
select * from dba_roles where role like 'RL%';
select * from dba_sys_privs where grantee='RL_ZEICORE';

--������� 6. �������� ������� ������������ � ������ PF_XXXCORE, ������� �����, ����������� ������� �� ������.
create profile PF_ZEICORE limit
    password_life_time 180 --���������� ���� ����� ������
    sessions_per_user 5 --���������� ������ ��� ������������
    failed_login_attempts 15 --���������� ������� �����
    password_lock_time 1 --���������� ���� ������������ ����� ������
    password_reuse_time 7 --����� ������� ���� ����� ��������� ������
    password_grace_time default --���������� ���� �������������� � ����� ������
    connect_time 90 --����� ����������, �����
    idle_time 25 --���������� ����� �������
    
drop profile PF_ZEICORE;
    
--������� 7. �������� ������ ���� �������� ��. �������� �������� ���� ���������� ������� PF_XXXCORE.
--�������� �������� ���� ���������� ������� DEFAULT.
select distinct profile from dba_profiles;
select * from dba_profiles where profile like 'PF_ZEICORE';
select * from dba_profiles where profile like 'DEFAULT';

--������� 8. �������� ������������ � ������ XXXCORE �� ���������� �����������:
--  -��������� ������������ �� ���������: TS_XXX;
--  -��������� ������������ ��� ��������� ������: TS_XXX_TEMP;
--  -������� ������������ PF_XXXCORE;
--  -������� ������ ��������������;
--  -���� �������� ������ �����. 
create user ZEICORE IDENTIFIED BY 12345
default tablespace TS_ZEI quota unlimited on TS_ZEI
temporary tablespace TS_ZEI_TEMP
profile PF_ZEICORE
account unlock
password expire

--������� 9. ����������� � �������� Oracle � ������� sqlplus � ������� ����� ������ ��� ������������ XXXCORE.  
grant RL_ZEICORE to ZEICORE

--sqlplus "connect as sysdba"
--masterkey
--alter user ZEICORE identified by 1234;


--������� 10. �������� ���������� � ������� SQL Developer ��� ������������ XXXCORE. �������� ����� ������� � ����� �������������.


--������� 11. �������� ��������� ������������ � ������ XXX_QDATA (10m). ��� �������� ���������� ��� � ��������� offline. 
--����� ���������� ��������� ������������ � ��������� online. 
--�������� ������������ XXX ����� 2m � ������������ XXX_QDATA. 
--�� ����� ������������ XXX �������� ������� � ������������ XXX_T1. � ������� �������� 3 ������.
create tablespace ZEI_QDATA
datafile 'ZEI_QDATA.dbf'
size 10M
offline

alter tablespace ZEI_QDATA online;

alter user ZEICORE quota 2M on ZEI_QDATA;




