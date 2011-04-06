class ReportsController < ApplicationController

  def authorize
    unless @loggedin_user and @loggedin_user.is_manager
      redirect_to main_url, :notice => "you are not allowed to use this page"
    end
  end

  def index
    @reportbysurveys = Reportbysurvey.all
  end


  def show
    @reportbysurvey = Reportbysurvey.find_by_id(params[:id])
    @questionnaires = @reportbysurvey.survey.questionnaires
  end


end
