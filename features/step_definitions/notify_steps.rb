
Then /^I should see the Send an eMail link$/ do
  page.should have_selector(".email .mailto a")
end

Then /^I should see a list of to be notified users$/ do
  page.should have_css(".list ol")
end

