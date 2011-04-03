require 'spec_helper'

describe Questionnaire do

  it "should be valid given all correct parmeters" do
    q = Factory(:valid_questionnaire)
    q.should be_valid
  end

  it "perf_ sys_ rdp_ should accept values from 1 to 6" do
    q = Factory(:valid_questionnaire)
    (1..6).each do |n|
      q.perf_app = n
      q.should be_valid
    end
  end

  it "perf_ sys_ rdp_ should not accept other values" do
    q = Factory(:valid_questionnaire)
    [nil,0,7].each do |n|
      q.perf_app = n
      q.should_not be_valid
    end
  end

  it "usage field should accept 0..100" do
    q = Factory(:valid_questionnaire)
    (0..100).to_a.find_all{|i| i%10==0}.each do |n|
      q.usage = n
      q.should be_valid
    end
  end


  it "usage field should not accept any other value " do
    q = Factory(:valid_questionnaire)
    [nil,-1,1,101].each do |n|
      q.usage = n
      q.should_not be_valid
    end
  end

  it "should be valid if verdict is false and comment is set " do
    q = Factory(:valid_questionnaire)
    q.verdict = false
    q.comment = "bla"
    q.should be_valid
  end

  it "should not be valid if verdict is false and comment not set" do
    q = Factory(:valid_questionnaire)
    q.verdict = false
    q.comment = nil
    q.should_not be_valid
    q.comment = ""
    q.should_not be_valid
  end

  it "should not be valid if survey is closed" do
    q = Factory(:valid_questionnaire)
    q.survey.close!
    q.should_not be_valid
  end

  it "should not be valid if logged-in user is not submitting user" do
    q = Factory(:valid_questionnaire)
    q.loggedin_user = User.new
    q.should be_invalid
  end

  it "should not be valid if virtualdesktop doesn't belong to the user" do
    q = Factory(:valid_questionnaire)
    q.virtualdesktop = Virtualdesktop.new
    q.should be_invalid
  end


  it "should not be valid after changing the user" do
    q = Factory(:valid_questionnaire)
    other_user = Factory(:client)
    q.should be_valid
    q.user = other_user
    q.loggedin_user = other_user
    q.should be_invalid
  end

  it "should not be valid to change the Virtualdesktop" do
    q = Factory(:valid_questionnaire)
    other_desktop = Factory(:vd,:user => q.user)
    q.should be_valid
    q.virtualdesktop= other_desktop
    q.should be_invalid
  end

  it "should not be valid after changing the survey" do
    q = Factory(:valid_questionnaire)
    q.should be_valid
    q.survey.close!
    q.survey = Factory(:open_survey)
    q.should be_invalid
  end


end
