require File.expand_path('../../../lib/immutable_validator', __FILE__)

class Questionnaire < ActiveRecord::Base

  attr_accessor :loggedin_user

  belongs_to :survey
  belongs_to :user
  belongs_to :virtualdesktop

  validates :survey_id, :immutable => true
  validates :user_id, :immutable => true
  validates :virtualdesktop_id, :immutable => true

  validates_uniqueness_of :user_id, :scope => :survey_id, :message => "you can only submit once for each survey." 
 
  validates_presence_of :user, :survey, :virtualdesktop

  validates_presence_of :perf_app,:perf_compile,:sys_stability,:rdp_stability,:rdp_stability,:usage

  validates_inclusion_of :perf_app,:perf_compile,:sys_stability,:rdp_stability,:rdp_stability, :in =>[1,2,3,4,5,6], :message => "accepts only values from 1,2,..,6"

  validates_inclusion_of :usage, :in => [0,10,20,30,40,50,60,70,80,90,100]

  validates_inclusion_of :conf_num_cpu, :conf_size_ram, :conf_size_diskc, :conf_size_diskc, :in => [true, false], :message => "must be set"

  validates_inclusion_of :toolset_general, :toolset_completeness, :verdict, :fallback, :in => [true, false], :message => "must be set"


  validate :comment_not_empty_if_verdict_negative
  validate :openess_of_survey
  validate :submitter_is_loggedin_user
  validate :desktop_belongs_to_user

  private 

  def comment_not_empty_if_verdict_negative
    errors.add(:comment,"must be supplied if verdict is negative") unless verdict or (comment and comment.length > 0)
  end

  def openess_of_survey
    errors.add(:survey,"must be open, however it is not") unless survey and survey.open?
  end

  def submitter_is_loggedin_user
    errors.add(:user," must be the logged-in user #{user}, #{loggedin_user}") unless user and loggedin_user and user.uid == loggedin_user.uid
  end

  def desktop_belongs_to_user
    errors.add(:virtualdesktop," must belong to the user.") unless user.virtualdesktops.include?(virtualdesktop)
  end


end
