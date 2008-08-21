#
# OauthRemoteAccessTokensController 
#  General workflow for a user to gain remote authorization to a OAuth protected service
#  1. User visits /new with a remote provider id.  Remote provider is contacted via gem/http request, receives request token and stores it session with provider id
#  2. User redirected to remote service to provide authentication, and approve access request
#  3. User redirected from remote site to call back url /create.  /create retrieves request token in session, via http request exchanges it for acces token
#  4. Access token stored in database, user redirected to /index
class OauthRemoteAccessTokensController < ApplicationController
  # GET /oauth_remote_access_tokens
  # GET /oauth_remote_access_tokens.xml
  def index
    @oauth_remote_access_tokens = User.current.oauth_remote_access_tokens.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oauth_remote_access_tokens }
    end
  end

  # GET /oauth_remote_access_tokens/1
  # GET /oauth_remote_access_tokens/1.xml
  def show
    @oauth_remote_access_token = OauthRemoteAccessToken.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @oauth_remote_access_token }
    end
  end

  # GET /new
  # GET /new.xml
  # Request access token and redirect to provider site for authentication
  # TODO: farmout @consumer.get_request_token to backgroundrb process to prevent mongrel lock
  def new
    begin
      provider = OauthRemoteServiceProvider.find(params[:oauth_remote_service_provider_id])
      consumer = OAuth::Consumer.new(provider.consumer_key, 
                                     provider.consumer_secret,
                                     {:site => provider.site_url})
      # contact the remote service, for request token, returns request token object
      request_token = consumer.get_request_token
      # this means one pending oauth request peruser, might want to replace with db table
      session[:pending_oauth_access_request] = {:provider_id   => params[:oauth_remote_service_provider_id], 
                                                :request_token => request_token }
      # redirect to providers site for user authentication
      respond_to do |format|
        format.html { redirect_to(request_token.authorize_url) }
        format.xml  { redirect_to(request_token.authorize_url) }
      end
    rescue ActiveRecord::RecordNotFound               # raised if cannot find remote provider
      redirect_to_error
    rescue Net::HTTPServerException => e              # consumer not setup properlly, key or secret are faulty
      redirect_to_error
    rescue Errno::ETIMEDOUT => e                      # network failure with provider, possibly due to bad url
      redirect_to_error
    end
  end

  # This action will function as the "callback url" you must specify when setting up a remote OAuth service
  # GET /create (UNLIKE traditional REST, in this case the create action is GET, due to OAuth implementation callback url must be get)
  # GET/create.xml
  # Redirect to provider site for authentication
  def create
    return head(:method_not_allowed) unless request.get?
    begin
      token = session[:pending_oauth_access_request][:request_token].get_access_token
      provider_id = session[:pending_oauth_access_request][:provider_id]
      respond_to do |format|
        if User.current.oauth_remote_access_tokens.create(:token_object  => token,
                                                          :provider_id   => session[:oauth_provider_id],
                                                          :user_id       => User.current.id)
          clear_request_session_info
          flash[:notice] = "You have sucessfully authorized us to use this service."
          format.html { redirect_to(@oauth_remote_access_token) }
          format.xml  { render :xml => @oauth_remote_access_token, :status => :created, :location => @oauth_remote_access_token }
        else
          flash[:notice] = "There was a problem creating this token."
          format.html { render :action => "index" }
          format.xml  { render :xml => @oauth_remote_access_token.errors, :status => :unprocessable_entity }
        end
      end
    rescue NoMethodError                              # raised if session does not contain oauth_access_request key
      redirect_to_error
    rescue Net::HTTPServerException => e              # raised  by get token if authorization declined by user
      redirect_to_error
    rescue Errno::ETIMEDOUT => e                      # network failure with provider, possibly due to bad url
      redirect_to_error
    end
  end
  
  # DELETE /oauth_remote_access_tokens/1
  # DELETE /oauth_remote_access_tokens/1.xml
  def destroy
    @oauth_remote_access_token = OauthRemoteAccessToken.find(params[:id])
    @oauth_remote_access_token.destroy

    respond_to do |format|
      format.html { redirect_to(oauth_remote_access_tokens_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def redirect_to_error  # replace with your appropriate error handling
    clear_request_session_info
    respond_to do |format|
      format.html { redirect_to(error_url) }
      format.xml  { head(:bad_request) }
    end
  end
  
  def clear_request_session_info
    session[:pending_oauth_access_request] = nil
  end
end
