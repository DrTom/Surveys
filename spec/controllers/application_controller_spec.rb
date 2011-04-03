require 'spec_helper'

describe ApplicationController do

  # this sets up routes so we can test ApplicationController 
  # as it was a real controller with a index action
  controller do
    def index
    end
  end


  context "authenticate before filter" do
    context "testing" do
      it "it should redirect to login session[:uid] is not set" do
        get :index
        response.should redirect_to("/login")
      end
      it "it should not redirect to login session[:uid] is set" do
        c1 = Factory(:client)
        get :index, {},{:uid => c1.uid}
        response.should_not redirect_to("/login")
      end
    end
  end


  context "setuser before filter" do
    it "should assign @loggedin_user correctly" do
      c1 = Factory(:client)
      c2 = Factory(:client)
      get :index, {},{:uid => c2.uid}
      assigns[:loggedin_user].should eq(c2)
    end
  end

  context "authorize before filter" do
    it "should redirect non admin users to main" do
      c1 = Factory(:client)
      get :index, {},{:uid => c1.uid}
      # response.should redirect_to(main_path)
      # strangely main_path doesn't exist in this context ???
      response.should redirect_to("/main")
    end
  end


end
