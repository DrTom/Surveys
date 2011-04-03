class CreateVirtualdesktops < ActiveRecord::Migration
  def self.up
    create_table :virtualdesktops do |t|
      t.string :name
      t.references :user
      t.references :masterimage

      t.timestamps
    end
    add_index(:virtualdesktops, :name, {:unique=> true})
  end

  def self.down
    drop_table :virtualdesktops
  end
end
