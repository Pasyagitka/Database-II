--7.������������ � ������������ U1_XXX_PDB, � ������� SQL Developer, �������� ������� XXX_table, �������� � ��� ������, ��������� SELECT-������ � �������.
create table ZEI_table(
    x number(3), 
    s varchar2(50)
);
drop table ZEI_table;

insert into ZEI_table (x, s) values (10, 'one');
insert into ZEI_table (x, s) values (2, 'two');
insert into ZEI_table (x, s) values (3, '3');
commit;

select * from ZEI_table;
