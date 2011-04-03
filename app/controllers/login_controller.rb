class LoginController < ApplicationController
  skip_before_filter :authenticate, :authorize

  def new
    if request.env['REMOTE_USER']
      uid = request.env['REMOTE_USER']
      session[:uid] = uid
      redirect_to questionnaire_url, :notice => "set user by http-auth"
    end
  end

  def create
    session[:uid] = params[:uid]
    redirect_to main_url, :action => :index, :notice =>"logged in as #{session[:uid]}"

#    if user = User.find_by_uid(params[:uid])
#      #session[:user_uid] = user && user.uid
#      session[:uid] = user.uid
#      redirect_to main_url, :notice => "login succeeded"
#    else
#      redirect_to login_url, :notice => "login failed"
#    end

  end

end
