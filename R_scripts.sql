

delimiter $$
create procedure sp_get_teacher_session(
  in document_number varchar(100)
)
begin
  select teacher_sessionPassword from teacher
  where teacher_documentNumber = document_number
  limit 1;
end$$

delimiter $$
create procedure sp_get_all_classroom(
  in document_number varchar(100)
)
begin

  select c_r.classroom_id, c_r.classroom_name as name, 
  c_t.classroom_type as c_type, s.status,
  c_l.list_name as list 
  from classroom_list as c_l
  inner join classroom as c_r on c_r.classroom_id = c_l.Clist_classroomId
  inner join classroom_type as c_t on c_t.type_id = c_r.classroom_typeId
  inner join status as s on s.status_id = c_r.classroom_statusId
  inner join teacher as t on t.teacher_id = c_r.classroom_teacherId
  where t.teacher_documentNumber = document_number;

end$$

delimiter $$
create procedure sp_get_catalogs(
  in catalog int
)
begin
  if catalog = 1 then
    select region_id, region_name, region_phoneCode, region_isoCode
    from region;
  elseif catalog = 2 then
    select document_id, document_type from document;
  elseif catalog = 3 then
    select type_id, classroom_type from classroom_type;
  elseif catalog = 4 then
    select Atype_id, Atype_name from activity_type;
  else 
    select ASType_id, ASType_name from activity_subType;
  end if;
end$$

delimiter $$
create procedure sp_get_teacher_token(
  in document_number varchar(100)
)
begin
  select s_u.session_isActive as isActive, 
  s_u.session_publicPassword as password,
  s_u.session_token as token
  from session_user as s_u
  inner join teacher as t on t.teacher_id = s_u.session_teacherId
  where t.teacher_documentNumber = document_number;
end$$
