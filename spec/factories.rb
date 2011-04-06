Factory.define :open_survey, :class => :survey do |f|
  f.sequence :name do |n|
    "Survey-#{n}"
  end
  f.opened_at DateTime.now
end

Factory.define :master, :class => Masterimage do |f|
  f.sequence :name do |n|
    "MasterImage-#{n}"
  end
end

Factory.define :client, :class => User do |f|
  f.sequence :uid do |n|
    "Client-#{n}"
  end
  f.is_client true
end

Factory.define :vd, :class => Virtualdesktop do |f|
  f.sequence :name do |n| 
    "vd-#{n}" 
  end
  f.association :user, :factory => :client
  f.association :masterimage, :factory => :master
end

def randb
  rand(2)==0 ? true : false
end

Factory.sequence :rb do |n|
  n
end

# Requirements get a bit in the way here. Consider to reuse
# a previous survey if many Questionnaires are created:
#
# q1 = Factory(:valid_questionnaire)
# q2 = Factory(:valid_questionnaire, :open_survey => q1.survey)
#
Factory.define :valid_questionnaire, :class => Questionnaire do |f|
  f.association :user, :factory => :client
  f.association :survey, :factory => :open_survey
  f.virtualdesktop  {|a| Factory(:vd,:user =>a.user)}

  f.loggedin_user {|a| a.user}

  f.perf_compile {rand(6)+1}
  f.perf_app  {rand(6)+1}

  f.sys_stability {rand(6)+1}

  f.rdp_perf  {rand(6)+1}
  f.rdp_stability  {rand(6)+1}

  f.conf_num_cpu  {randb}
  f.conf_size_ram  {randb}
  f.conf_size_diskc  {randb}
  f.conf_size_diskd  {randb}

  f.toolset_general  {randb}
  f.toolset_completeness  {randb}

  f.usage  {rand(11)*10}
  f.fallback {randb}

  f.verdict  {randb}

  f.comment  {Faker::Lorem.sentences(3).join(" ")}

end
