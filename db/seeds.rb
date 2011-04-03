# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
#

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

s = Survey.find_or_create_by_name({:name =>"Test Survey"})
s.open!
s.save()


master_base1103 = Masterimage.find_or_create_by_name({:name => "Base 2011-03"})
u204013 = User.find_or_create_by_uid({:uid => "u204013"})
v10011= Virtualdesktop.find_or_create_by_name({:name => "v10011",:user => u204013,:masterimage => master_base1103})

master_rcs = Masterimage.find_or_create_by_name({:name => "RCS 2010-12"})

u206981 =  User.find_or_create_by_uid({:uid => "u206981"})
v10003 = Virtualdesktop.find_or_create_by_name({:name => "v10003",:user => u206981,:masterimage => master_rcs})

u206123 =  User.find_or_create_by_uid({:uid => "u206123"})
v10005 = Virtualdesktop.find_or_create_by_name({:name => "v10005",:user => u206123,:masterimage => master_rcs})

u201135=  User.find_or_create_by_uid({:uid => "u201135"})
v10006= Virtualdesktop.find_or_create_by_name({:name => "v10006",:user => u201135,:masterimage => master_rcs})

u200302=  User.find_or_create_by_uid({:uid => "u200302"})
v10007= Virtualdesktop.find_or_create_by_name({:name => "v10007",:user => u200302,:masterimage => master_rcs})

u201346 =  User.find_or_create_by_uid({:uid => "u201346"})
v10008 = Virtualdesktop.find_or_create_by_name({:name => "v10008",:user => u201346,:masterimage => master_rcs})

u149249=  User.find_or_create_by_uid({:uid => "u149249"})
v10009= Virtualdesktop.find_or_create_by_name({:name => "v10009",:user => u149249,:masterimage => master_rcs})


