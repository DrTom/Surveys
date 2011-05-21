class SurveysController < ApplicationController

  def authorize
    unless @loggedin_user and (@loggedin_user.is_manager or @loggedin_user.is_admin)
      redirect_to main_url, :notice => "you not allowed to use this page"
    end
  end


  def open
    @survey = Survey.find(params[:id])
    if @survey.openable?
      @survey.opened_at = DateTime.now 
      begin
        @survey.save
        flash[:notice] = "Survey #{@survey.name} is now open for questionnaires to be submitted."
      rescue Exception => e
        flash[:notice] = e.message
      end
      redirect_to surveys_url
    else
      redirect_to(surveys_url,:notice => "Already opened or closed surveys can not be opened again.")
    end
  end

  def close 
    @survey = Survey.find(params[:id])
    if @survey.closeable?
      begin
        @survey.close! 
      rescue Exception => e
        flash[:notice] = e.message
      end
      redirect_to surveys_url
    end
  end

  # GET /surveys
  # GET /surveys.xml
  def index
    @surveys = Survey.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @surveys }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.xml
  def show
    @survey = Survey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  # GET /surveys/new
  # GET /surveys/new.xml
  def new
    @survey = Survey.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  # GET /surveys/1/edit
  def edit
    @survey = Survey.find(params[:id])
  end

  # POST /surveys
  # POST /surveys.xml
  def create
    @survey = Survey.new(params[:survey])

    respond_to do |format|
      if @survey.save
        format.html { redirect_to(@survey, :notice => 'Survey was successfully created.') }
        format.xml  { render :xml => @survey, :status => :created, :location => @survey }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.xml
  def update
    @survey = Survey.find(params[:id])

    respond_to do |format|
      if @survey.update_attributes(params[:survey])
        format.html { redirect_to(@survey, :notice => 'Survey was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.xml
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy

    respond_to do |format|
      format.html { redirect_to(surveys_url) }
      format.xml  { head :ok }
    end
  end
end
