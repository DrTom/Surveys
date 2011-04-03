class VirtualdesktopsController < ApplicationController
  # GET /virtualdesktops
  # GET /virtualdesktops.xml
  def index
    @virtualdesktops = Virtualdesktop.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @virtualdesktops }
    end
  end

  # GET /virtualdesktops/1
  # GET /virtualdesktops/1.xml
  def show
    @virtualdesktop = Virtualdesktop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @virtualdesktop }
    end
  end

  # GET /virtualdesktops/new
  # GET /virtualdesktops/new.xml
  def new
    @virtualdesktop = Virtualdesktop.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @virtualdesktop }
    end
  end

  # GET /virtualdesktops/1/edit
  def edit
    @virtualdesktop = Virtualdesktop.find(params[:id])
  end

  # POST /virtualdesktops
  # POST /virtualdesktops.xml
  def create
    @virtualdesktop = Virtualdesktop.new(params[:virtualdesktop])

    respond_to do |format|
      if @virtualdesktop.save
        format.html { redirect_to(@virtualdesktop, :notice => 'Virtualdesktop was successfully created.') }
        format.xml  { render :xml => @virtualdesktop, :status => :created, :location => @virtualdesktop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @virtualdesktop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /virtualdesktops/1
  # PUT /virtualdesktops/1.xml
  def update
    @virtualdesktop = Virtualdesktop.find(params[:id])

    respond_to do |format|
      if @virtualdesktop.update_attributes(params[:virtualdesktop])
        format.html { redirect_to(@virtualdesktop, :notice => 'Virtualdesktop was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @virtualdesktop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /virtualdesktops/1
  # DELETE /virtualdesktops/1.xml
  def destroy
    @virtualdesktop = Virtualdesktop.find(params[:id])
    @virtualdesktop.destroy

    respond_to do |format|
      format.html { redirect_to(virtualdesktops_url) }
      format.xml  { head :ok }
    end
  end
end
