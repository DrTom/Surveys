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

-- Email Feature

-- ####### implementation with views and joins 

-- all users which have a virtual desktop
CREATE VIEW active_users AS 
  select DISTINCT users.id as user_id from users 
  JOIN virtualdesktops ON users.id = virtualdesktops.user_id ORDER BY user_id;
select * from active_users;

-- all users which have submitted to the currently open survey
CREATE VIEW users_with_current_submissions AS 
  select DISTINCT user_id from questionnaires 
  JOIN opensurveys 
    ON questionnaires.survey_id = opensurveys.id ORDER BY user_id;
select * from users_with_current_submissions;

-- status
CREATE VIEW current_submission_status AS 
  select active_users.user_id as id, active_users.user_id as user_id, (users_with_current_submissions.user_id is NOT NULL) as sumbitted from active_users 
  LEFT OUTER JOIN users_with_current_submissions 
    ON active_users.user_id = users_with_current_submissions.user_id;

select * from current_submission_status; 

DROP VIEW users_wosubm_and_desk;

CREATE VIEW users_wosubm_and_desk AS 
  select users.id, users.uid from users 
  JOIN current_submission_status 
    ON users.id = current_submission_status.id AND current_submission_status.sumbitted is false;

select * from users_wosubm_and_desk;

----- ########## with subqueries

CREATE VIEW notifyusers AS
  select users.id, users.uid, users.id as user_id from users WHERE id NOT IN 
    -- SUBQUERY all users which have submitted to the currently open survey
    (select DISTINCT user_id from questionnaires JOIN opensurveys ON questionnaires.survey_id = opensurveys.id ORDER BY user_id) 
   AND id IN
    -- SUBQUERY all users which have a virtual desktop
    (select DISTINCT users.id as user_id from users JOIN virtualdesktops ON users.id = virtualdesktops.user_id ORDER BY user_id) ;

select * from notifyusers;

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



