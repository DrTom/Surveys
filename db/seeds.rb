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


master1 = Factory(:master,:name=>"Master1")
master2 = Factory(:master,:name=>"Master2")

(1..2).each do |i| 
  s = Factory(:open_survey,:name=>"Survey-#{i}")
    m = master1
    (1..2).each do |j|
      client = Factory(:client,:uid=>"Client-#{i}#{j}#{m.name}")
      vd = Factory(:vd,:name=>"vd-#{i}#{j}#{m.name}",:user=>client,:masterimage=>m)
      Factory(:valid_questionnaire,:survey => s,:user => client,:virtualdesktop=>vd) 
    end
    m = master2
    (3..5).each do |j|
      client = Factory(:client,:uid=>"Client-#{i}#{j}#{m.name}")
      vd = Factory(:vd,:name=>"vd-#{i}#{j}#{m.name}",:user=>client,:masterimage=>m)
      Factory(:valid_questionnaire,:survey => s,:user => client,:virtualdesktop=>vd) 
    end
  s.close!
  s.save
end

