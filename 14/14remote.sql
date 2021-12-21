create table Table14_(id number primary key, field nvarchar2(30));

create or replace procedure proc14(pcode subject.pulpit%type)
is
    cursor curs_4 is select * from subject where pulpit = pcode;
    m_subject subject%rowtype;
begin
    open curs_4;
    loop
        fetch curs_4 into m_subject;
        exit when curs_4%notfound;
	--GET_LINES
        dbms_output.put_line(m_subject.pulpit || ' ' || m_subject.subject_name);
    end loop;
    close curs_4;
end;

create or replace function func14(pcode teacher.pulpit%type) return number
is
    teachersCount number;
begin
    select count(*) into teachersCount from teacher where pulpit = pcode;
    return teachersCount;
end;