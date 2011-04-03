class QuestionnairesController < ApplicationController

  def authorize
    unless @loggedin_user and (@loggedin_user.is_client or @loggedin_user.is_manager or @loggedin_user.is_admin)
      redirect_to main_url, :notice => "you not allowed to use this page"
    end
  end

  # GET /questionnaires
  # GET /questionnaires.xml
  def index
    @questionnaires = Questionnaire.all
    @user_questionnaires = Questionnaire.find_all_by_user_id(@loggedin_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questionnaires }
    end
  end

  # GET /questionnaires/1
  # GET /questionnaires/1.xml
  def show
    @questionnaire = Questionnaire.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @questionnaire }
    end
  end

  # GET /questionnaires/new
  # GET /questionnaires/new.xml
  def new
    @questionnaire = Questionnaire.new
    @questionnaire.loggedin_user= @loggedin_user

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @questionnaire }
    end
  end

  # GET /questionnaires/1/edit
  def edit
    @questionnaire = Questionnaire.find(params[:id])
  end

  # POST /questionnaires
  # POST /questionnaires.xml
  def create
    @questionnaire = Questionnaire.new(params[:questionnaire])
    @questionnaire.loggedin_user= @loggedin_user

    respond_to do |format|
      if @questionnaire.save
        format.html { redirect_to(@questionnaire, :notice => 'Questionnaire was successfully created.') }
        format.xml  { render :xml => @questionnaire, :status => :created, :location => @questionnaire }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @questionnaire.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questionnaires/1
  # PUT /questionnaires/1.xml
  def update
    @questionnaire = Questionnaire.find(params[:id])
    @questionnaire.loggedin_user= @loggedin_user

    respond_to do |format|
      if @questionnaire.update_attributes(params[:questionnaire])
        format.html { redirect_to(@questionnaire, :notice => 'Questionnaire was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @questionnaire.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questionnaires/1
  # DELETE /questionnaires/1.xml
  def destroy
    @questionnaire = Questionnaire.find(params[:id])
    @questionnaire.destroy

    respond_to do |format|
      format.html { redirect_to(questionnaires_url,:notice => 'Questionnaire was successfully destroyed.' ) }
      format.xml  { head :ok }
    end
  end
end
