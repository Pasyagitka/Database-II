--������� 10. �������� ���������� � ������� SQL Developer ��� ������������ XXXCORE. �������� ����� ������� � ����� �������������.
create table ZEI_t(
    x number(3), 
    s varchar2(50)
);

insert into ZEI_t (x, s) values (10, 'one');
insert into ZEI_t (x, s) values (2, 'two');
insert into ZEI_t (x, s) values (3, '3');
commit;

create view ZEI_table_view as
select * from ZEI_t;

drop view ZEI_table_view

select * from ZEI_table_view;

--������� 11.
--�� ����� ������������ XXX �������� ������� � ������������ XXX_T1. � ������� �������� 3 ������.
create table ZEI_t1(
    x number(3), 
    s varchar2(50)
) tablespace ZEI_QDATA;

drop table ZEI_t1

insert into ZEI_t1 (x, s) values (10, 'one');
insert into ZEI_t1 (x, s) values (2, 'two');
insert into ZEI_t1 (x, s) values (3, '3');
commit;

select * from ZEI_t1
