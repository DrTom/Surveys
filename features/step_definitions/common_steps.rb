
Given /the standard set of users admin, manager, and client$/ do
  User.find_or_create_by_uid(:uid=> "admin",:is_admin=> true)
  User.find_or_create_by_uid(:uid=> "manager",:is_manager=> true)
  User.find_or_create_by_uid(:uid=> "client",:is_client=> true)
end

Given /^a virtualdesktop "([^"]*)" assigned to the client "([^"]*)" and to the masterimage "([^"]*)"$/ do |desk_name, client_uid, master_name|
  client = User.find_or_create_by_uid(:uid => client_uid)
  master = Masterimage.find_or_create_by_name(:name => master_name)
  desk = Virtualdesktop.find_or_create_by_name(:name => desk_name, :user => client, :masterimage => master)
end

Given /^a masterimage "([^"]*)"$/ do |master_name|
  master = Masterimage.find_or_create_by_name(:name => master_name)
end


Given /^a submitted questionnaire for the user "([^"]*)", the survey "([^"]*)" and the virtualdesktop "([^"]*)"$/ do |user_name,survey_name, desk_name|
  client = User.find_or_create_by_uid(:uid => user_name)
  survey = Survey.find_or_create_by_name(:name => survey_name)
  desk = Virtualdesktop.find_or_create_by_name(:name => desk_name)
  Factory(:valid_questionnaire, :user => client, :survey => survey, :virtualdesktop => desk)
end

Given /^the survey "([^"]*)" is being closed$/ do |survey_name|
  Survey.find_by_name(survey_name).close!
end


Given /^I login as "([^"]*)"$/ do |uid|
  visit login_path
  fill_in "uid", :with => uid
  click_button "login"
  page.should have_content("logged in as #{uid}")
end


Then /^I should see a link "([^"]*)"$/ do |link|
  page.should have_link(link)
end

Then /^I should not see a link "([^"]*)"$/ do |link|
  page.should_not have_link(link)
end

Given /^a open survey "([^"]*)"$/ do |survey|
  Factory(:open_survey,:name => survey)
end

Then /^I should see the invitation to a submit to a survey$/ do
  page.should have_content("The survey \"TestSurvey\" is currently open for submissions.")
  page.should have_link("questionnaires")
end

Then /^I fill out the questionnaire form$/ do

  [ 'questionnaire_perf_compile',
    'questionnaire_perf_app',
    'questionnaire_sys_stability',
    'questionnaire_rdp_perf',
    'questionnaire_rdp_stability',
  ].each do |id|
    select '6', :from => id
  end


  [ 'questionnaire_conf_num_cpu_true',
    'questionnaire_conf_size_ram_false',
    'questionnaire_conf_size_diskc_true',
    'questionnaire_conf_size_diskd_false',
    'questionnaire_toolset_general_true',
    'questionnaire_toolset_completeness_false',
  ].each do |id|
    choose id
  end

  select '70', :from => 'questionnaire_usage'

  choose 'questionnaire_fallback_false'

  choose 'questionnaire_verdict_false'

  fill_in 'questionnaire_comment', :with => "I'd rather work with my mac."
end

And /^I submit  the questionnaire form$/ do
  click_button 'questionnaire_submit'
end


When /^I acknowledge the prompt$/ do
  page.driver.browser.switch_to.alert.accept
end

Then /^I should only see exactly one questionnaire$/ do
  page.all('a', :text => 'Show').size.should == 1
end


Given /^a set of submitted questionnaires$/ do
  (1..2).each do |i| 
    s = Factory(:open_survey,:name=>"Survey-#{i}")
    (1..2).each do |j|
      client = Factory(:client,:uid=>"Client-#{i}#{j}")
      vd = Factory(:vd,:name=>"vd-#{i}#{j}",:user=>client)
      Factory(:valid_questionnaire,:survey => s,:user => client,:virtualdesktop=>vd) 
    end
    s.close!
    s.save
  end
end


Given /^a set of users with desktops$/ do
  s = Factory(:open_survey)
  Factory(:vd) #  constructs user with it
  Factory(:vd) #  constructs user with it
end

