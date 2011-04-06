class CreateReportbysurveys < ActiveRecord::Migration
  def self.up
    # survey_id is indexed in the previous migration
    #
    # TODO make the following DRY with a stored procedure
    # also: we will need this again for the reports by survey and by masterimage
    execute <<-SQL
      CREATE VIEW reportbysurveys AS
        SELECT 
          survey_id as id,
          survey_id, 
          count(*) as count,
          round(avg(perf_compile),1) as perf_compile,
          round(avg(perf_app),1) as perf_app,
          round(avg(sys_stability),1) as sys_stability,
          round(avg(rdp_perf),1) as rdp_perf,
          round(avg(rdp_stability),1) as rdp_stability,
          round((sum(conf_num_cpu::boolean::integer)::integer::float / count(*) * 100)::numeric,0)as conf_num_cpu,
          round((sum(conf_size_ram::boolean::integer)::integer::float / count(*) * 100)::numeric,0)as conf_size_ram,
          round((sum(conf_size_diskc::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as conf_size_diskc,
          round((sum(conf_size_diskd::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as conf_size_diskd,
          round((sum(toolset_general::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as toolset_general,
          round((sum(toolset_completeness::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as toolset_completeness,
          round(avg(usage),0) as usage,
          round((sum(fallback::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as fallback,
          round((sum(verdict::boolean::integer)::integer::float / count(*) * 100)::numeric,0) as verdict
        FROM questionnaires GROUP BY survey_id ORDER BY survey_id;
    SQL
  end

  def self.down
    execute <<-SQL
      DROP VIEW reportbysurveys;
    SQL
  end
end
