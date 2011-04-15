

Then /^I should see the survey summary for "([^"]*)"$/ do |survey|
  page.should have_css(".summary .summary_survey table tr td.survey")
end

Then /^I should see the masterimage summary for "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the Individual Reports/ do
  page.should have_content("Individual Reports")
  page.should have_css(".individual table")
  page.should have_css(".individual table tr td.user")
end

Then /^I should see the Comments$/ do
  page.should have_content("Comments")
  page.should have_content("Client-11 for vd-11")
  page.should have_content("Client-12 for vd-12")
end


