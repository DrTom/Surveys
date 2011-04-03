class AddIndexesToQuestionnaires < ActiveRecord::Migration
  def self.up
    add_index(:questionnaires, :user_id)
    add_index(:questionnaires, :survey_id)
  end

  def self.down
    remove_index(:questionnaires,:user_id)
    remove_index(:questionnaires,:survey_id)
  end
end
