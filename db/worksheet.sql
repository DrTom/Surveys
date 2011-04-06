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


-- Analytics 

select * from questionnaires;

select questionnaires.id, avg(perf_compile) as perf_compile from questionnaires;


SELECT 
  survey_id as id,
  survey_id, 
  count(*) as count,
  round(avg(perf_compile),1) as perf_compile,
  round(avg(perf_app),1) as perf_app,
  round(avg(sys_stability),1) as sys_stability,
  round(avg(rdp_perf),1) as rdp_perf,
  round(avg(rdp_stability),1) as rdp_stability,
  round((sum(conf_size_ram::boolean::integer)::integer::float / count(*) * 100)::numeric,0)as conf_size_ram,
  round((sum(conf_size_diskc::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as conf_size_diskc,
  round((sum(conf_size_diskd::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as conf_size_diskd,
  round((sum(toolset_general::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as toolset_general,
  round((sum(toolset_completeness::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as toolset_completeness,
  round(avg(usage),0) as usage,
  round((sum(fallback::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as fallback,
  round((sum(verdict::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as verdict
FROM questionnaires GROUP BY survey_id ORDER BY survey_id;



