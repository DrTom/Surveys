require 'spec_helper'

describe MainController do

  it "should set the @opensurvey var" do
    s = Factory(:open_survey)
    get :index
    # be aware: opensurvey is a different model from survey!
    assigns[:opensurvey].name.should eq(s.name)
  end

end


