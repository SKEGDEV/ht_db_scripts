
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
