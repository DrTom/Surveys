require "spec_helper"

describe SurveysController do
  describe "routing" do

    # only test what is different from the standard rails resources

    it "recognizes and generates #open" do
      { :post => "/surveys/1/open" }.should route_to(:controller => "surveys", :action => "open", :id => "1")
    end

    it "recognizes and generates #open" do
      { :post => "/surveys/1/close" }.should route_to(:controller => "surveys", :action => "close", :id => "1")
    end

  end
end
