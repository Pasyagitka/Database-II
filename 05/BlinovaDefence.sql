--Сервер: контрольные, параметров, паролей, журналов----------------------------

--Параметров
--C:\Oracle_Home\database\SPFILEORCL.ora          --ORACLE_HOME\database
select name, description from v$parameter;        --содержимое
create pfile = 'ZEI_PFILE.ORA' from spfile;       --содержимое как файл
alter system set open_cursors=301 scope = spfile; --изменить

--Паролей
--"C:\Oracle_Home\database\PWDorcl.ora"           --ORACLE_HOME\database
select * from v$pwfile_users;                     --who have been granted the SYSDBA, SYSOPER, or SYSASM system privileges.
grant sysoper to zeicore;                         --изменить
--orapwd FILE=orapworcl ENTRIES=30                --creates a password file named orapworcl that allows up to 30 privileged users with different passwords.

--Контрольные
--ORACLE_DATABASE\ORADATA\ORCL                     
show parameter control;                           --параметры
select * from v$controlfile;                      --местоположение
select * from v$controlfile_record_section;       --информация о содержимом
                                                  --изменить исползуемые файлы
--sql plus "connect as sysdba"
--shutdown immediate;
--startup nomount;
--скопировать один из управляющих файлов
--HOST COPY C:\ORACLE_DATABASE\ORADATA\ORCL\CONTROL01.CTL C:\ORACLE_DATABASE\ORADATA\ORCL\CONTROL03.CTL
--изменить параметр CONTROL_FILES в файле параметров;
select * from v$parameter where name like('control_files');
alter system set control_files= 'C:\ORACLE_DATABASE\ORADATA\ORCL\CONTROL01.CTL',
                                'C:\ORACLE_DATABASE\ORADATA\ORCL\CONTROL02.CTL',
                                'C:\ORACLE_DATABASE\ORADATA\ORCL\CONTROL03.CTL'
                    scope=SPFILE;
--mount/shutdown
--startup open;
                                                  --изменить сам файл
alter database backup controlfile to trace;
select value from v$diag_info where name='Diag Trace'; --location - log
STARTUP NOMOUNT
CREATE CONTROLFILE REUSE DATABASE "ORCL" NORESETLOGS  NOARCHIVELOG
    MAXLOGFILES 20 --было 16
    MAXLOGMEMBERS 3
    MAXDATAFILES 1024
    MAXINSTANCES 8
    MAXLOGHISTORY 292
LOGFILE
  GROUP 1 'C:\ORACLE_DATABASE\ORADATA\ORCL\REDO01.LOG'  SIZE 200M BLOCKSIZE 512,
  GROUP 2 'C:\ORACLE_DATABASE\ORADATA\ORCL\REDO02.LOG'  SIZE 200M BLOCKSIZE 512,
  GROUP 3 'C:\ORACLE_DATABASE\ORADATA\ORCL\REDO03.LOG'  SIZE 200M BLOCKSIZE 512
-- STANDBY LOGFILE
DATAFILE
  'C:\ORACLE_DATABASE\ORADATA\ORCL\SYSTEM01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\SYSAUX01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\UNDOTBS01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\PDBSEED\SYSTEM01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\PDBSEED\SYSAUX01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\USERS01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\PDBSEED\UNDOTBS01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\ORCLPDB\SYSTEM01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\ORCLPDB\SYSAUX01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\ORCLPDB\UNDOTBS01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\ORCLPDB\USERS01.DBF',
  'C:\ORACLE_HOME\DATABASE\TS_ZEI.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\ZEI_PDB\SYSTEM01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\ZEI_PDB\SYSAUX01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\ZEI_PDB\UNDOTBS01.DBF',
  'C:\ORACLE_DATABASE\ORADATA\ORCL\ZEI_PDB\USERS01.DBF',
  'C:\ORACLE_HOME\DATABASE\TS_ZEI4.DBF',
  'C:\ORACLE_HOME\DATABASE\ZEI_QDATA05.DBF'
CHARACTER SET AL32UTF8
;
show parameter MAXLOGFILES;

--Журнал
--C:\Oracle_Database\diag\rdbms\orcl\orcl\alert log.xml


--БД: Контрольные, Данные, Журнал, Архив ---------------------------------------

--Данные
select * from v$datafile;
select FILE_NAME, TABLESPACE_NAME FROM DBA_DATA_FILES;
select FILE_NAME, TABLESPACE_NAME FROM DBA_TEMP_FILES;
select * from dba_segments;
select * from user_segments;
--drop tablespace ZEI_QDATA including contents and datafiles;

--Журналов 
select * from v$log;            --группы
select * from v$logfile;        --C:\ORACLE_DATABASE\ORADATA\ORCL\REDO03.LOG
alter system switch logfile;    
alter database add logfile member 'C:\Oracle_Database\oradata\ORCL\REDO042.LOG'  to group 4;    --изменить: добавить файл, удалить
                                --содержимое изменяется когда в них идет запись

--Архив
select NAME, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from V$INSTANCE;
select * from v$archived_log    --местоположение C:\ORACLE_HOME\RDBMS\ARC0000000018_1082506068.0001
--shutdown immediate;
--startup mount;
--alter database noarchivelog; (archivelog) --alter system switch logfile;
--alter database open;



---
select * from user_segments;
select * from user_tablespaces;
