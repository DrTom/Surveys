class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.boolean :is_admin, :default => false
      t.boolean :is_client, :default => true
      t.boolean :is_manager, :default => false
      t.string :uid, :null => false

      t.timestamps
    end

    add_index(:users, :uid, {:unique=> true})
  end

  def self.down
    drop_table :users
  end
end
