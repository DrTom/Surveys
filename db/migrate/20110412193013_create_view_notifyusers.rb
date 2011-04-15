class CreateViewNotifyusers < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE VIEW notifyusers AS
        select users.id, users.uid, users.id as user_id from users WHERE id NOT IN 
          -- SUBQUERY all users which have submitted to the currently open survey
          (select DISTINCT user_id from questionnaires JOIN opensurveys ON questionnaires.survey_id = opensurveys.id ORDER BY user_id) 
         AND id IN
          -- SUBQUERY all users which have a virtual desktop
          (select DISTINCT users.id as user_id from users JOIN virtualdesktops ON users.id = virtualdesktops.user_id ORDER BY user_id) ;
    SQL
  end

  def self.down
    DROP VIEW notifyusers;
  end
end
