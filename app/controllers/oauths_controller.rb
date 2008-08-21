class OauthRemoteAccessTokenController < ApplicationController
  before_filter :require_login
  
  # GET /new (post to prevent a spider from raising hell)
  # GET /new.xml
  # Request access token and redirect to provider site for authentication
  def new
    unless @provider = OauthRemoteProvider.find(params[:provider_id])
      format.html { redirect_to(error_url) }
      format.xml  { head :ok }
    end
    begin
      @consumer = OAuth::Consumer.new(@provider.consumer_key, @provider.consumer_secret,{:site=>@provider.authorize_url})
      session[:oauth_provider_id] = params[:provider_id]
      # if the user makes multiple requests and fails, will overwrite old token.  If logs out token will expire with them
      session[:oauth_request_token] = @consumer.get_request_token               # backgroundrb to prevent mongrel freeze during request?
      format.html { redirect_to(session[:oauth_request_token].authorize_url) }  # redirect to providers site for user authentication
      format.xml  { head :ok }
    rescue Net::HTTPServerException => e              # consumer not setup properlly, key or secret are faulty
      logger.info(e)
      redirect_to(error_url)
    rescue Errno::ETIMEDOUT => e                      # network failure with provider, possibly due to bad url
      logger.info(e)
      redirect_to(error_url)
    end
  end
  
  # This action will function as the "callback url" you must specify when setting up a remote OAuth service
  # GET /create (UNLIKE traditional REST, in this case the create action is GET, due to OAuth implementation callback url must be get)
  # GET/create.xml
  # Redirect to provider site for authentication
  def create
    begin
      User.current.oauth_remote_access_tokens.new(:token_object  => session[:oauth_request_token].get_access_token,
                                                  :provider_id   => session[:oauth_provider_id],
                                                  :user_id       => User.current.id)
    rescue Net::HTTPServerException => e    # raised if authorization declined by user
      session[:oauth_request_token] = session[:oauth_provider_id] = nil
      format.html { redirect_to(declined_url) }
      format.xml  { head :ok }
    end
  end
  
  # DELETE /oauth_remote_access_tokens/1
  # DELETE /oauth_remote_access_tokens/1.xml
  def destroy
    User.current.oauth_remote_access_tokens.find(:provider_id).destroy
  end

  private
  

end
