require 'spec_helper'

describe Survey do

  it "should be closeable when open" do
    s = Survey.new(:opened_at => DateTime.now)
    s.status.should equal :open
    end

  it "should go from :open to :closed after close! is called" do
    s = Survey.new(:opened_at => DateTime.now)
    s.close!
    s.status.should == :closed
  end

  it "should go from :new to :open after open! is called" do
    s = Survey.new()
    s.open?.should be_false
    s.open!
    s.status.should == :open
    s.open?.should be_true
  end

  it "response with status :new when neither opened_at nor closed_at is set" do
    s1 = Survey.create
    s1.status.should equal :new
  end

  it "allows only one open survey in the db" do
    s1 = Factory(:open_survey)
    s1.status.should equal :open
    lambda {Factory(:open_survey)}.should raise_error
  end

end
