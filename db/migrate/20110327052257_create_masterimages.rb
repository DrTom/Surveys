class CreateMasterimages < ActiveRecord::Migration
  def self.up
    create_table :masterimages do |t|
      t.string :name

      t.timestamps
    end

    add_index(:masterimages, :name, {:unique=> true})
  end

  def self.down
    drop_table :masterimages
  end
end
