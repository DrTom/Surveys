class MasterimagesController < ApplicationController
  # GET /masterimages
  # GET /masterimages.xml
  def index
    @masterimages = Masterimage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @masterimages }
    end
  end

  # GET /masterimages/1
  # GET /masterimages/1.xml
  def show
    @masterimage = Masterimage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @masterimage }
    end
  end

  # GET /masterimages/new
  # GET /masterimages/new.xml
  def new
    @masterimage = Masterimage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @masterimage }
    end
  end

  # GET /masterimages/1/edit
  def edit
    @masterimage = Masterimage.find(params[:id])
  end

  # POST /masterimages
  # POST /masterimages.xml
  def create
    @masterimage = Masterimage.new(params[:masterimage])

    respond_to do |format|
      if @masterimage.save
        format.html { redirect_to(@masterimage, :notice => 'Masterimage was successfully created.') }
        format.xml  { render :xml => @masterimage, :status => :created, :location => @masterimage }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @masterimage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /masterimages/1
  # PUT /masterimages/1.xml
  def update
    @masterimage = Masterimage.find(params[:id])

    respond_to do |format|
      if @masterimage.update_attributes(params[:masterimage])
        format.html { redirect_to(@masterimage, :notice => 'Masterimage was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @masterimage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /masterimages/1
  # DELETE /masterimages/1.xml
  def destroy
    @masterimage = Masterimage.find(params[:id])
    @masterimage.destroy

    respond_to do |format|
      format.html { redirect_to(masterimages_url) }
      format.xml  { head :ok }
    end
  end
end
