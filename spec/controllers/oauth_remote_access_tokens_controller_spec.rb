require File.dirname(__FILE__) + '/../spec_helper'
# todo, xml returns
describe OauthRemoteAccessTokensController do
  before(:each) do
    controller.stub!(:current_user).and_return(mock("User", :id => 1))
    @request_token = mock("Request Token")
    @request_token.stub!(:authorize_url).and_return('http://www.foobar.com/request_url')
    @access_token = OAuth::AccessToken.new("","","")
    @consumer = mock("Consumer")
    @provider = OauthRemoteServiceProvider.new(:user_id => 1, 
      :name => 'foobar', 
      :site_url => 'http://www.foobar.com')
    OauthRemoteServiceProvider.stub!(:find).and_return(@provider)
  end
  describe "#destroy" do
    it "given a valid id, should destroy the token" do
      token = mock('OauthRemoteAccessToken')
      token.should_receive(:destroy)
      OauthRemoteAccessToken.should_receive(:find).and_return(token)
      post "destroy", {:id => 1}
      response.should redirect_to('http://test.host/oauth_remote_access_tokens')
    end
  end
  describe "#new" do
    def do_new(options = {})
      get "new", {:oauth_remote_service_provider_id => 1}.merge(options)
    end
    it "should get a request token and redirect to provider authorize url" do
      @consumer.should_receive(:get_request_token).and_return(@request_token)
      OAuth::Consumer.should_receive(:new).and_return(@consumer)
      do_new
      session[:pending_oauth_access_request].should == {:request_token=>@request_token, :provider_id=>"1"}
      response.should redirect_to('http://www.foobar.com/request_url')
    end
    it "should redirect to error url if not given a provider or bad id (ActiveRecord::RecordNotFound)" do
      @provider = nil
      controller.should_receive(:redirect_to_error).once
      do_new
    end
    it "should redirect to error url if network timeout (Net::HTTPServerException)" do
      @consumer = mock("Consumer")
      @consumer.stub!(:get_request_token).and_raise(Net::HTTPServerException)
      controller.should_receive(:redirect_to_error).once
      do_new
    end
    it "should redirect to error url if bad address (Errno::ETIMEDOUT)" do
      @consumer = mock("Consumer")
      @consumer.stub!(:get_request_token).and_raise(Errno::ETIMEDOUT)
      controller.should_receive(:redirect_to_error).once
      do_new
    end
  end
  
  describe "#create" do 
    def do_create(options = {})
      get "create", {}.merge(options)
    end
    it "should redirect to index if not called via get" do
      post "create"
      response.should redirect_to('http://test.host/oauth_remote_access_tokens')
    end
    it "should redirect to error url if session contains wonky data (catch NoMethodError)" do
      @provider = nil
      controller.should_receive(:redirect_to_error).once
      do_create
    end
    it "should redirect to error url if network timeout (catch Net::HTTPServerException)" do
      @consumer = mock("Consumer")
      @consumer.stub!(:get_request_token).and_raise(Net::HTTPServerException)
      controller.should_receive(:redirect_to_error).once
      do_create
    end
    it "should redirect to error url if bad address (catch Errno::ETIMEDOUT)" do
      @consumer = mock("Consumer")
      @consumer.stub!(:get_request_token).and_raise(Errno::ETIMEDOUT)
      controller.should_receive(:redirect_to_error).once
      do_create
    end
    
    describe "given proper session info" do
      before(:each) do
        session[:pending_oauth_access_request] = {:request_token=>@request_token, :provider_id=>"1"}
      end
      it "should exchange a request token for an access token" do
        @request_token.should_receive(:get_access_token).and_return(@access_token)
        do_create
      end
      it "should create a new oauth remote access token entry in the database" do
        @request_token.should_receive(:get_access_token).and_return(@access_token)
        OauthRemoteAccessToken.should_receive(:create).and_return(true)
        do_create 
      end
      
      it "should clear the session request info for the user" do
        @request_token.should_receive(:get_access_token).and_return(@access_token)
        OauthRemoteAccessToken.should_receive(:create).and_return(true)
        controller.should_receive(:clear_request_session_info)
        do_create
      end
      
      it "should redirect to /list with flash congratulation if sucessful" do
        @request_token.should_receive(:get_access_token).and_return(@access_token)
        OauthRemoteAccessToken.should_receive(:create).and_return(true)
        controller.should_receive(:clear_request_session_info)
        do_create
        response.should redirect_to('http://test.host/oauth_remote_access_tokens')
        flash[:notice].should == "You have sucessfully authorized us to use this service."
      end
      
      it "should redirect to /list with sad flash message if unsucessful" do
        @request_token.should_receive(:get_access_token).and_return(@access_token)
        OauthRemoteAccessToken.should_receive(:create).and_return(false)
        controller.should_not_receive(:clear_request_session_info)
        do_create
        response.should redirect_to('http://test.host/oauth_remote_access_tokens')
        flash[:notice].should == "There was a problem creating this token." 
      end
    end
  end
end