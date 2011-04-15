class NotifyusersController < ApplicationController

  def authorize
    unless @loggedin_user and @loggedin_user.is_manager
      redirect_to main_url, :notice => "you are not allowed to use this page"
    end
  end

  def index
    @opensurvey = Opensurvey.first 
    @notifyusers = Notifyuser.all
  end

end
