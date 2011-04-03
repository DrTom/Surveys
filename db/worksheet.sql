CREATE ROLE rails LOGIN CREATEDB;
CREATE DATABASE vdwsurveys_dev OWNER rails;
CREATE DATABASE vdwsurveys_test OWNER rails;
CREATE DATABASE vdwsurveys_prod OWNER rails;

select * from masterimages;
delete from masterimages;

select * from questionnaires;
delete  from questionnaires;

select * from schema_migrations      

select * from surveys;                
select * from surveys where closed_at is null AND opened_at is not null ORDER BY opened_at DESC LIMIT 1;
CREATE INDEX opened_at_idx ON surveys (opened_at);
DROP INDEX opened_at_idx; 


CREATE VIEW opensurveys AS select *, id as survey_id  from surveys where closed_at is null AND opened_at is not null ORDER BY opened_at DESC LIMIT 1;
DROP VIEW opensurveys;

select * from opensurveys; 

delete from surveys;

select * from users; 
select * from users ORDER BY created_at DESC ;
delete from users;

select * from virtualdesktops;
delete from virtualdesktops;


delete from masterimages; delete from questionnaires; delete from surveys; delete from users; delete from virtualdesktops;


