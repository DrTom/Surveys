class AddRundownToVirtualdesktop < ActiveRecord::Migration
  def self.up
    add_column :virtualdesktops, :rundown, :datetime
  end

  def self.down
    remove_column :virtualdesktops, :rundown
  end
end
