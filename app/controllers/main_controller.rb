class MainController < ApplicationController

  skip_before_filter :authenticate, :authorize

  def index
    @opensurvey = Opensurvey.first
  end

end
