class CitiesController < ApplicationController
  layout "application"

  # GET /cities
  # GET /cities.xml
  def index
    @cities = City.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cities }
    end
  end
  # GET /cities/admin
  # GET /cities/admin.xml
  def admin
    @cities = City.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cities }
    end
  end
  # GET /cities/1
  # GET /cities/1.xml
  def show
    if params[:id] != nil
      @city = City.find(:first,:conditions => ["name = ?", params[:id]])
      else
      @city = City.find(:first,:conditions => ["name = Stockholm"] )
    end
    if @city == nil
      @city = City.find(1)
    end
    #create the map
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,:map_type => true)
    @map.record_init @map.set_map_type(GMapType::G_SATELLITE_MAP)

    #load the articles
    # create marker for the source location 
     @map.icon_global_init( GIcon.new(:image =>"http://www.google.com/mapfiles/ms/icons/red-pushpin.png", 
      :shadow => "http://www.google.com/mapfiles/shadow50.png", 
      :icon_size => GSize.new(32,32), 
      :shadow_size => GSize.new(37,32), 
      :icon_anchor => GPoint.new(9,32), 
      :info_window_anchor => GPoint.new(9,2), 
      :info_shadow_anchor => GPoint.new(18,25)), "icon_source") 
      icon_source = Variable.new("icon_source")      
      source = GMarker.new([@city.lat, @city.lng], 
               :title => 'City', 
               :info_window => @city.name, 
               :icon => icon_source)      
      @map.overlay_init(source) 
      
      # create markers one for each location found 
      @articles = @city.articles.find(:all)
      @articles.each do |article|
        marker = GMarker.new([article.lat, article.lng], :title => article.name, :info_window => '<h2>'+article.name+'</h2>'+article.content) 
        @map.overlay_init(marker) 
      end   
    
    #center the map in the city coordinates
    @map.center_zoom_init([@city.lat,@city.lng],13)
    if params[:id] == "world"
      @map.center_zoom_init([0,0],2)
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @city }
    end

  end

  # GET /cities/new
  # GET /cities/new.xml
  def new
    @city = City.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @city }
    end
  end

  # GET /cities/1/edit
  def edit
    @city = City.find(params[:id])
  end

  # POST /cities
  # POST /cities.xml
  def create
    @city = City.new(params[:city])

    respond_to do |format|
      if @city.save
        flash[:notice] = 'City was successfully created.'
        format.html { redirect_to(@city) }
        format.xml  { render :xml => @city, :status => :created, :location => @city }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @city.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cities/1
  # PUT /cities/1.xml
  def update
    @city = City.find(params[:id])

    respond_to do |format|
      if @city.update_attributes(params[:city])
        flash[:notice] = 'City was successfully updated.'
        format.html { redirect_to(@city) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @city.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.xml
  def destroy
    @city = City.find(params[:id])
    @city.destroy

    respond_to do |format|
      format.html { redirect_to(cities_url) }
      format.xml  { head :ok }
    end
  end
end
