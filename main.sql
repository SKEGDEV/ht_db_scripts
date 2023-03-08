create database ht_db;

use ht_db;

/*
  tables:
    -teacher --> user table
     -status_teacher --> user status
     -region
     -document
     -session --> in this save session information as token, public password, etc
    -list --> list of students
    -student --> student information
     -status_student --> status student
    -classroom --> classroom informatios as name, type or any information of the classroom
     -classroom_type --> classroom type, this can be unit, semester, etc
     -classroom_student --> this is for save the information of student as qualification of unit or any classroom type
    -activity_class  --> this is for a activity class this can save the activity information as the name, qualification, total student, etc
     -activity_type --> this is the activity type this can be a homework, test, partial test, etc
    -activity_student --> this is the activity for stundent in this save the qualification and any observation of the student
*/

create table teacher(
  teacher_id int primary key auto_increment,
  teacher_firstName varchar(200) not null,
  teacher_lastName varchar(200) not null,
  teacher_birthday date not null,
  teacher_sessionPassword varchar(300) not null,
  teacher_documentNumber varchar(100) not null,
  teacher_email varchar(100) not null,
  teacher_phoneNumber varchar(30) not null,
  teacher_documentId int not null,
  teacher_statusId int not null
);

create table status(
  status_id int primary key auto_increment,
  status varchar(30) not null
);

insert into status values (default, 'Activo'), (default, 'Betado'), (default, 'Eliminado'), (default, 'Suspendido'); 

create table region(
  region_id int primary key auto_increment,
  region_name varchar(40) not null,
  region_phoneCode varchar(10) not null,
  region_isoCode varchar(10) not null
);

insert into region values (default, 'Guatemala', '502', 'GT');

create table document(
  document_id int primary key auto_increment,
  document_type varchar(50) not null,
  document_regionId int not null
);

insert into document values (default, 'DPI', 1), (default, 'NIT', 1), (default, 'PASAPORTE', 1);

create table session_user(
  session_id int primary key auto_increment,
  session_teacherId int not null,
  session_isActive boolean not null,
  session_publicPassword varchar(300) not null,
  session_token varchar(300) not null
);

create table list(
  list_id int primary key auto_increment,
  list_name varchar(100) not null,
  list_recordDate date not null,
  list_teacherId int not null,
  list_statusId int not null
);

create table student(
  student_id int primary key auto_increment,
  student_firstName varchar(200) not null,
  student_lastName varchar(200) not null,
  student_code varchar(50) not null,
  student_listId int not null,
  student_statusId int not null,
  student_birthday date,
  student_motherNumber varchar(50),
  student_fatherNumber varchar(50),
  student_phoneNumber varchar(50)
);

create table classroom(
  classroom_id int primary key auto_increment,
  classroom_name varchar(100) not null,
  classroom_typeId int not null,
  classroom_teacherId int not null,
  classroom_statusId int not null
);

create table classroom_list(
  Clist_id int primary key auto_increment,
  Clist_classroomId int not null,
  Clist_listId int not null
);

create table classroom_type(
  type_id int primary key auto_increment,
  classroom_type varchar(30) not null
);

insert into classroom_type values (default, 'unidad'), (default, 'semestre'), (default, 'trimestre'); 

create table classroom_student(
  Cstudent_id int primary key auto_increment,
  Cstudent_studentId int not null,
  Cstudent_ClistId int not null,
  Cstudent_unit_number int not null,
  Cstudent_qualification float not null
);

create table activity_class(
  activity_id int primary key auto_increment,
  activity_name varchar(100) not null,
  activity_date date not null,
  activity_qualification float not null,
  activity_ClistId int not null,
  activity_typeId int not null,
  activity_subTypeId int not null
);

create table activity_type(
  Atype_id int primary key auto_increment,
  Atype_name varchar(50) not null
);

insert into activity_type values (default, 'declarativo'), (default, 'procedimental'),
(default, 'actitudinal'), (default, 'otro');

create table activity_subType(
  ASType_id int primary key auto_increment,
  ASType_name varchar(50)
);

insert into activity_subType values (default, 'tarea'), (default, 'corto'),
(default, 'parcial'), (default, 'examen'), (default, 'otro');

create table activity_student(
  activity_id int primary key auto_increment,
  activity_studentId int not null,
  activity_classId int not null,
  activity_studentQualification float not null
);


/*teacher constraint*/
alter table teacher add constraint fk_teacher_status foreign key (teacher_statusId) references status(status_id);
alter table teacher add constraint fk_teacher_document foreign key (teacher_documentId) references document(document_id);
/*document contraint*/
alter table document add constraint fk_document_region foreign key (document_regionId) references region(region_id);
/*session constraint*/
alter table session_user add constraint fk_teacher_session foreign key (session_teacherId) references teacher(teacher_id); 
/*list constraint*/
alter table list add constraint fk_list_teacher foreign key (list_teacherId) references teacher(teacher_id);
alter table list add constraint fk_list_status foreign key (list_statusId) references status(status_id);
/*student constraint*/
alter table student add constraint fk_student_list foreign key (student_listId) references list(list_id);
alter table student add constraint fk_student_status foreign key (student_statusId) references status(status_id);
/*classroom constraint*/
alter table classroom add constraint fk_classroom_type foreign key (classroom_typeId) references classroom_type(type_id);
alter table classroom add constraint fk_classroom_status foreign key (classroom_statusId) references status(status_id);
alter table classroom add constraint fk_classroom_teacher foreign key (classroom_teacherId) references teacher(teacher_id);
/*classroom list constraint*/
alter table classroom_list add constraint fk_Clist_list foreign key (Clist_listId) references list(list_id);
alter table classroom_list add constraint fk_Clist_classroom foreign key (Clist_classroomId) references classroom(classroom_id);
/*classroom student constraint*/
alter table classroom_student add constraint fk_Cstudent_student foreign key (Cstudent_studentId) references student(student_id);
alter table classroom_student add constraint fk_Cstudent_classroom foreign key (Cstudent_ClistId) references classroom_list(Clist_id);
/*activity_class constraint*/
alter table activity_class add constraint fk_activity_classroom foreign key (activity_ClistId) references classroom_list(Clist_id);
alter table activity_class add constraint fk_activity_type foreign key (activity_typeId) references activity_type(Atype_id);
alter table activity_class add constraint fk_activity_subType foreign key (activity_subTypeId) references activity_subType(ASType_id);
/*activity_student constraint*/
alter table activity_student add constraint fk_Sactivity_student foreign key (activity_studentId) references student(student_id);
alter table activity_student add constraint fk_Sactivity_Cactivity foreign key (activity_classId) references activity_class(activity_id);

