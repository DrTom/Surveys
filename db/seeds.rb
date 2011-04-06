# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
#

srand(0)

[ 
  {:uid => "admin", :is_client => false, :is_admin => true},
  {:uid => "manager",:is_client => false, :is_manager => true},
  {:uid => "omni", :is_admin => true, :is_client => true, :is_manager => true},
].each do |args|
  User.find_or_create_by_uid(args)
end

client = User.find_or_create_by_uid({:uid => "client", :is_client=> true})
master = Masterimage.find_or_create_by_name({:name => "TestMaster"})
Virtualdesktop.find_or_create_by_name({:name=>"TestDesk",:user => client,:masterimage => master})


(1..2).each do
  s = Factory(:open_survey)
  (1..2).each do 
    Factory(:valid_questionnaire,:survey => s) 
  end
  s.close!
  s.save
end

