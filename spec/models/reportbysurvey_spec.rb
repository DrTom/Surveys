require 'spec_helper'

describe Reportbysurvey do

  it "should report the correct number" do

    q = Factory(:valid_questionnaire)
    Reportbysurvey.first.count.should eq(1)

    q = Factory(:valid_questionnaire,:survey => q.survey)
    Reportbysurvey.first.count.should eq(2)

  end

  it "should compute averages/means correctly " do
    q = Factory(:valid_questionnaire)
    q.perf_compile = 1
    q.save
    Reportbysurvey.first.perf_compile.should eq(1)
    q = Factory(:valid_questionnaire,:survey => q.survey)
    q.perf_compile = 2
    q.save
    Reportbysurvey.first.perf_compile.should eq(1.5)
  end

  it "should compute percentage of booleans correctly" do
    q = Factory(:valid_questionnaire)
    q.conf_size_ram = true
    q.save
    Reportbysurvey.first.conf_size_ram.should eq(100)
    q = Factory(:valid_questionnaire,:survey => q.survey)
    q.conf_size_ram = false
    q.save
    Reportbysurvey.first.conf_size_ram.should eq(50)
    q = Factory(:valid_questionnaire,:survey => q.survey)
    q.conf_size_ram = false
    q.save
    Reportbysurvey.first.conf_size_ram.should eq(33)
  end

end
