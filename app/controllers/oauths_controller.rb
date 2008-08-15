class OAuthsController < ApplicationController
  before_filter :require_login
  
  # POST /authorize (post to prevent a spider from raising hell)
  # POST /authorize.xml
  # Redirect to provider site for authentication
  def authorize
    begin
      @provider = OAuthProvider.find_by_name(:name => params[:provider])
      @consumer = OAuth::Consumer.new(@provider.consumer_key,
                                    @provider.consumer_secret, 
                                    {:site=>@provider.authorize_url}
      session[:oauth_request_tokens] ||= {}
      session[:oauth_request_tokens][:agree2] = @consumer.get_request_token               # backgroundrb to prevent mongrel freeze during request?
      format.html { redirect_to(session[:oauth_request_token].authorize_url) }  # redirect to providers site for user authentication
      format.xml  { head :ok }
    rescue Net::HTTPServerException => e              # consumer not setup properlly, key or secret are faulty
      logger.info(e)
      # redirect_to(error_url)
    rescue Errno::ETIMEDOUT => e                      # network failure with provider, possibly due to bad url
      logger.info(e)
      # redirect_to(error_url)
    end
  end
  
  # GET /callback
  # GET/callback.xml
  # Redirect to provider site for authentication
  def callback
    begin
      session[:oauth_access_tokens] ||= {}
      session[:oauth_access_tokens] = session[:oauth_request_token].get_access_token
    rescue Net::HTTPServerException => e    # raised if authorization declined by user
      session[:oauth_request_token] = nil
      format.html { redirect_to(declined_url) }
      format.xml  { head :ok }
    end
    #User.current.access_tokens.create(:provider_id => @provider.id,
    #                                :access_token => @access_token.
    #                                :access_token => params[:access_token],
     #                               :access_token_secret => params[:access_token_secret])

  end
  
  # GET /callback
  # GET/callback.xml
  
  def decline
    
  end
  
  def revoke
    User.current.access_tokens.find_all_by_provider_id(@provider.id).destroy
  end
  
  # GET /locations
  # GET /locations.xml
  def index
    @locations = Location.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.xml
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.xml
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        flash[:notice] = 'Location was successfully created.'
        format.html { redirect_to(@location) }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:notice] = 'Location was successfully updated.'
        format.html { redirect_to(@location) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end
end
