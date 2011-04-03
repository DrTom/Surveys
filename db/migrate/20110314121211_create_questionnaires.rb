class CreateQuestionnaires < ActiveRecord::Migration
  def self.up
    create_table :questionnaires do |t|

      t.references :user
      t.references :survey
      t.references :virtualdesktop

      t.integer :perf_compile
      t.integer :perf_app

      t.integer :sys_stability

      t.integer :rdp_perf
      t.integer :rdp_stability
      
      t.boolean :conf_num_cpu
      t.boolean :conf_size_ram
      t.boolean :conf_size_diskc
      t.boolean :conf_size_diskd

      t.boolean :toolset_general
      t.boolean :toolset_completeness

      t.integer :usage
      t.boolean :fallback

      t.boolean :verdict

      t.text  :comment


      t.timestamps
    end
  end

  def self.down
    drop_table :questionnaires
  end
end
