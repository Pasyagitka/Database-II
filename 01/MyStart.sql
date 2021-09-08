create table ZEI_t(
    x number(3), 
    s varchar2(50)
);

insert into ZEI_t (x, s) values (10, 'one');
insert into ZEI_t (x, s) values (2, 'two');
insert into ZEI_t (x, s) values (3, '3');

commit;

select * from ZEI_t;

update ZEI_t set s='>2' where x > 2;
commit;

select * from ZEI_t where s='>2';
select sum(x) from ZEI_t where s='>2';

delete from ZEI_t where s != '>2';
commit;

alter table ZEI_t add constraint zei1 primary key(x);
create table ZEI_t1(
    x1 number(3), 
    s1 varchar2(50),
    constraint fk_zei foreign key(x1) references ZEI_t(x)
);
select * from ZEI_t;
select * from ZEI_t1;

insert into ZEI_t1 (x1, s1) values (3, 'one00');
insert into ZEI_t1 (x1, s1) values (10, 'two00');
insert into ZEI_t1 (x1, s1) values (3, '00');

select * from ZEI_t inner join ZEI_t1 on x=x1 ;
select * from ZEI_t right outer join ZEI_t1 on x=x1;
select * from ZEI_t left outer join ZEI_t1 on x=x1;

drop table ZEI_t;
drop table ZEI_t1;
