

delimiter $$
create procedure sp_get_teacher_session(
  in dcoument_number varchar(100)
)
begin
  select teacher_sessionPassword from teacher
  where teacher_documentNumber = document_number
  limit 1;
end$$
