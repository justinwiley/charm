require File.dirname(__FILE__) + '/../spec_helper'

describe OauthRemoteAccessTokensController do
  before(:each) do
    @request_token = mock("Request Token")
    @request_token.stub!(:authorize_url).and_return('http://www.foobar.com/request_url')
    @consumer = mock("Consumer")
    @consumer.stub!(:get_request_token).and_return(@request_token)

    @provider = OauthRemoteServiceProvider.new(:user_id => 1, 
                                               :name => 'foobar', 
                                               :site_url => 'http://www.foobar.com')
    OauthRemoteServiceProvider.stub!(:find).and_return(@provider)
  end
  describe "#new" do
    it "should get a request token and redirect to provider authorize url" do
      OAuth::Consumer.should_receive(:new).and_return(@consumer)
      get "new", {:oauth_remote_service_provider_id => 1}
      response.should redirect_to('http://www.foobar.com/request_url')
    end
    it "should redirect to error url if not given a provider or bad id (ActiveRecord::RecordNotFound)" do
      @provider = nil
      controller.should_receive(:redirect_to_error).once
      get "new", {:oauth_remote_service_provider_id => 999}
    end
    it "should redirect to error url if network timeout (Net::HTTPServerException)" do
      @consumer = mock("Consumer")
      @consumer.stub!(:get_request_token).and_raise(Net::HTTPServerException)
      controller.should_receive(:redirect_to_error).once
      get "new", {:oauth_remote_service_provider_id => 999}
    end
    it "should redirect to error url if bad address (Errno::ETIMEDOUT)" do
      @consumer = mock("Consumer")
      @consumer.stub!(:get_request_token).and_raise(Net::HTTPServerException)
      controller.should_receive(:redirect_to_error).once
      get "new", {:oauth_remote_service_provider_id => 999}
    end
    
  end 


  
end