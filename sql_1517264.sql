create table projects (
id int identity primary key, 
title nvarchar(100) not null, 
description text not null, 
created_date datetime not null)

create table user_project(
user_id int not null,
project_id int not null,
join_date Datetime)

create table users(
id int identity primary key,
email nvarchar(100) not null,
name nvarchar(150) not null,
password nvarchar(200) not null,
role int not null)

ALTER TABLE user_project
ADD FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE user_project
ADD FOREIGN KEY (project_id) REFERENCES projects(id);
