class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.string :name
      t.datetime :opened_at
      t.datetime :closed_at

      t.timestamps
    end

    add_index(:surveys, :name, {:unique=> true})
  end

  def self.down
    drop_table :surveys
  end
end
