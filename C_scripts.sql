
delimiter $$
create procedure sp_create_account(
  in first_name varchar(200),
  in last_name varchar(200),
  in birthday date,
  in password varchar(300),
  in document_number varchar(100),
  in email varchar(100),
  in phone_number varchar(30),
  in document_type int
)
begin
  insert into teacher values(
    default,
    first_name,
    last_name,
    birthday,
    password,
    document_number,
    email,
    phone_number,
    document_type,
    1
  );

  select @@identity as id;

end$$

delimiter $$
create procedure sp_create_classroom(
  in name varchar(100),
  in classroom_type int,
  in document_number varchar(100)
)
begin

  set @t_id := '';
  select @t_id = teacher_id from teacher
  where teacher_documentNumber = document_number limit 1;

  insert into classroom values(
    default,
    name,
    classroom_type,
    @t_id,
    1
  );

end$$

delimiter $$ 
create procedure sp_create_class_list(
  in name varchar(100),
  in document_number varchar(100)
)
begin

  set @t_id := '';
  select @t_id = teacher_id from teacher
  where teacher_documentNumber = document_number limit 1;

  insert into list values(
    default,
    name,
    curdate(),
    @t_id,
    1
  );

  select @@identity as id; 

end$$

delimiter $$
create procedure sp_create_student(
  in first_name varchar(200),
  in last_name varchar(200),
  in student_code varchar(50),
  in list_id int,
  in birthday date,
  in mother_number varchar(50),
  in father_number varchar(50),
  in phone_number varchar(50)
)
begin
  insert into student values(
    default,
    first_name,
    last_name,
    student_code,
    list_id,
    1,
    birthday,
    mother_number,
    father_number,
    phone_number
  );
end$$

delimiter $$
create prodedure sp_create_activity(
  in name varchar(100),

  
)
begin

end$$
