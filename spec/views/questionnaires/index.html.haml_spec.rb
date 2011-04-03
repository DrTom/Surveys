require "spec_helper"

describe "questionnaires/index.html.haml",:type => :request do

  context "a questionnaire with an open survey" do

    before do
      questionnaire = Factory(:valid_questionnaire)
      assign(:loggedin_user, questionnaire.user)
      assign(:user_questionnaires,[questionnaire])
      render
    end

    it "shows a show link" do
      rendered.should contain("Show")
    end

    it "shows a edit link" do
      rendered.should contain("Edit")
    end

    it "shows a destroy link" do
      rendered.should contain("Destroy")
    end

  end

  context "a questionnaire with a closed survey" do

    before do
      questionnaire = Factory(:valid_questionnaire)
      assign(:loggedin_user, questionnaire.user)
      assign(:user_questionnaires,[questionnaire])
      questionnaire.survey.close!
      render
    end

    it "shows a show link" do
      rendered.should contain("Show")
    end

    it "doesn't show a edit link" do
      rendered.should_not contain("Edit")
    end

    it "doesn't shows a destroy link" do
      rendered.should_not contain("Destroy")
    end

  end

end

