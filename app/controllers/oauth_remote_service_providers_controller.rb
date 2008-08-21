class OauthRemoteServiceProvidersController < ApplicationController
  # GET /oauth_remote_service_providers
  # GET /oauth_remote_service_providers.xml
  def index
    @oauth_remote_service_providers = OauthRemoteServiceProvider.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oauth_remote_service_providers }
    end
  end

  # GET /oauth_remote_service_providers/1
  # GET /oauth_remote_service_providers/1.xml
  def show
    @oauth_remote_service_provider = OauthRemoteServiceProvider.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @oauth_remote_service_provider }
    end
  end

  # GET /oauth_remote_service_providers/new
  # GET /oauth_remote_service_providers/new.xml
  def new
    @oauth_remote_service_provider = OauthRemoteServiceProvider.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @oauth_remote_service_provider }
    end
  end

  # GET /oauth_remote_service_providers/1/edit
  def edit
    @oauth_remote_service_provider = OauthRemoteServiceProvider.find(params[:id])
  end

  # POST /oauth_remote_service_providers
  # POST /oauth_remote_service_providers.xml
  def create
    @oauth_remote_service_provider = OauthRemoteServiceProvider.new(params[:oauth_remote_service_provider])

    respond_to do |format|
      if @oauth_remote_service_provider.save
        flash[:notice] = 'OauthRemoteServiceProvider was successfully created.'
        format.html { redirect_to(@oauth_remote_service_provider) }
        format.xml  { render :xml => @oauth_remote_service_provider, :status => :created, :location => @oauth_remote_service_provider }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @oauth_remote_service_provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /oauth_remote_service_providers/1
  # PUT /oauth_remote_service_providers/1.xml
  def update
    @oauth_remote_service_provider = OauthRemoteServiceProvider.find(params[:id])

    respond_to do |format|
      if @oauth_remote_service_provider.update_attributes(params[:oauth_remote_service_provider])
        flash[:notice] = 'OauthRemoteServiceProvider was successfully updated.'
        format.html { redirect_to(@oauth_remote_service_provider) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @oauth_remote_service_provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /oauth_remote_service_providers/1
  # DELETE /oauth_remote_service_providers/1.xml
  def destroy
    @oauth_remote_service_provider = OauthRemoteServiceProvider.find(params[:id])
    @oauth_remote_service_provider.destroy

    respond_to do |format|
      format.html { redirect_to(oauth_remote_service_providers_url) }
      format.xml  { head :ok }
    end
  end
end
