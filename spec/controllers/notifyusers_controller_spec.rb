require 'spec_helper'

describe NotifyusersController do

  context "the index" do

    before(:each) do 
      @manager = Factory(:client,:is_manager=> true)

      open_survey = Factory(:open_survey)

      @user_with_submission= Factory(:client)
      desk01 = Factory(:vd, :user => @user_with_submission)
      Factory(:valid_questionnaire, :user => @user_with_submission, :survey => open_survey)

      @user_without_submission= Factory(:client)
      desk02 = Factory(:vd, :user => @user_without_submission)

      @user_without_desk = Factory(:client)

    end

    it "should have the user_without_submission included"  do
      get :index, {}, {:uid => @manager.uid}
      assigns[:notifyusers].map{|u| u.user}.should include(@user_without_submission)
    end

    it "should not have the user_with_submission included"  do
      get :index, {}, {:uid => @manager.uid}
      assigns[:notifyusers].map{|u| u.user}.should_not include(@user_with)
    end


    it "should not have the user_without_desk included"  do
      get :index, {}, {:uid => @manager.uid}
      assigns[:notifyusers].map{|u| u.user}.should_not include(@user_without_desk)
    end

  end

end


