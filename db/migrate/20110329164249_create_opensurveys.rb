class CreateOpensurveys < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE VIEW opensurveys AS select *, id as survey_id  from surveys where closed_at is null AND opened_at is not null ORDER BY opened_at DESC LIMIT 1;
      CREATE INDEX surveys_opened_at_idx ON surveys (opened_at);
      CREATE INDEX surveys_closed_at_idx ON surveys (closed_at);
    SQL
  end

  def self.down
    execute <<-SQL
      DROP VIEW opensurveys;
      DROP INDEX surveys_opened_at_idx; 
      DROP INDEX surveys_closed_at_idx; 
    SQL
  end
end
