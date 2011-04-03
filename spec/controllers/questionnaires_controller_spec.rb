require 'spec_helper'

describe QuestionnairesController do


  context "authorize before filter" do
    it "should allow clients to access the page" do
      c1 = Factory(:client)
      get :index, {}, {:uid => c1.uid}
      response.should render_template("questionnaires/index")
    end
  end

  it "should set @user_questionnaires with those of the logedin user" do
    s = Factory(:open_survey)
    c1 = Factory(:client)
    q1 = Factory(:valid_questionnaire,:survey =>s, :user =>c1)
    c2 = Factory(:client)
    q2 = Factory(:valid_questionnaire,:survey =>s, :user =>c2)
    get :index, {}, {:uid => c2.uid}
    assigns[:user_questionnaires].should include(q2)
    assigns[:user_questionnaires].should_not include(q1)
  end
end
