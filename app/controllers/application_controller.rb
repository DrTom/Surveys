class ApplicationController < ActionController::Base
  before_filter :authenticate, :setuser , :authorize
  protect_from_forgery

  protected

  #  request.env['REMOTE_USER'] is always present in production
  #  the other stuff is for testing, this is clearly dangerous
  #
  #  after each production deployment: a login should be performed,
  #  => correct function w.h.p.
  
  def authenticate
    session[:uid] = request.env['REMOTE_USER'] if request.env['REMOTE_USER']
    redirect_to login_url, :notice => "you must log in" if not session[:uid]
  end

  def setuser
    @loggedin_user = User.find_or_create_by_uid(request.env['REMOTE_USER'])  if request.env['REMOTE_USER']
    @loggedin_user = User.find_by_uid(session[:uid]) if not @loggedin_user and session[:uid]
    @loggedin_user = User.find_or_create_by_uid(:uid => "guest", :is_client => false) if not @loggedin_user
   end

  def authorize
    redirect_to main_url, :notice => "You not allowed to use this page." unless @loggedin_user and @loggedin_user.is_admin
  end

end
