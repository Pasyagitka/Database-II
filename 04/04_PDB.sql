--6.������������ � XXX_PDB c ������� SQL Developer �������� ���������������� ������� (��������� ������������, ����, ������� ������������, ������������ � ������ U1_XXX_PDB).
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
    password_life_time 180 --���������� ���� ����� ������
    sessions_per_user 5 --���������� ������ ��� ������������
    failed_login_attempts 15 --���������� ������� �����
    password_lock_time 1 --���������� ���� ������������ ����� ������
    password_reuse_time 7 --����� ������� ���� ����� ��������� ������
    password_grace_time default --���������� ���� �������������� � ����� ������
    connect_time 90 --����� ����������, �����
    idle_time 25 --���������� ����� �������
    container = current;
    
SELECT * FROM DBA_PROFILES;
     
create user U1_ZEI_PDB IDENTIFIED BY 12345
default tablespace TS_ZEI quota unlimited on TS_ZEI
profile PF_ZEICORE
account unlock
password expire;


--7.������������ � ������������ U1_XXX_PDB, � ������� SQL Developer, �������� ������� XXX_table, �������� � ��� ������, ��������� SELECT-������ � �������.
grant RL_ZEICORE to U1_ZEI_PDB;
grant create session to U1_ZEI_PDB;
grant create table, drop any table to U1_ZEI_PDB;

alter user U1_ZEI_PDB identified by 1234;


--8.� ������� ������������� ������� ���� ������ ����������, ��� ��������� ������������, ���  ����� (������������ � ���������), 
--��� ���� (� �������� �� ����������), ������� ������������, ���� �������������  ���� ������ XXX_PDB �  ����������� �� ����.
select * from USER_TABLESPACES;

select FILE_NAME, TABLESPACE_NAME FROM DBA_DATA_FILES;
select FILE_NAME, TABLESPACE_NAME FROM DBA_TEMP_FILES;

--����
select distinct role from dba_roles;
select role, privilege from ROLE_SYS_PRIVS  order by role -- ���� � ����������� �� ����������.

--������� ������������
select distinct profile from dba_profiles 

--������������
select distinct username from DBA_USERS; --��� ������������ ��
select * from all_users;
select * from user_sys_privs --�������� ������������
select grantee, privilege from dba_sys_privs; --���������� �������������


--9.������������ � CDB-���� ������, �������� ������ ������������ � ������ C##XXX, ��������� ��� ����������, ����������� ������������ � ���� ������ XXX_PDB. 
--�������� 2 ����������� ������������ C##XXX � SQL Developer � CDB-���� ������ �  XXX_PDB � ���� ������. ��������� �� �����������������.  
--���������� ��� PDB
grant create session to C##ZEI; --���������� �� �������� ������ � PDB
grant create table to  C##ZEI; --��� �������� ������ �����������

--10. 
grant create session to C##YYY;

--11.
SELECT username, SERVICE_NAME FROM v$session WHERE username IS NOT NULL ORDER BY username;


