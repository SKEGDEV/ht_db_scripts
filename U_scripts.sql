
delimiter $$
create procedure sp_update_teacher_session(
  in document_number varchar(100),
  in public_password varchar(300),
  in session_token varchar(300),
  in type_session int
)
begin
  set @t_id := ''; 
  select @t_id := teacher_id from teacher
  where teacher_documentNumber = document_number;

  if type_session = 1 then
    insert into session_user values(
      default,
      @t_id,
      1,
      public_password,
      session_token
    );
  elseif type_session = 2 then 
    update session_user set
    session_isActive = 1,
    session_publicPassword = public_password,
    session_token = session_token
    where session_teacherId = @t_id;
  else
    update session_user set
    session_isActive = 0,
    session_publicPassword = '',
    session_token = ''
    where session_teacherId = @t_id;
  end if;

  select concat(teacher_firstName, ' ', teacher_lastName) as name
  from teacher where teacher_id = @t_id;

end$$
