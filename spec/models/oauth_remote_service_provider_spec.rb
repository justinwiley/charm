require File.dirname(__FILE__) + '/../spec_helper'

describe OauthRemoteServiceProvider do
  before(:each) do
    @orsp = OauthRemoteServiceProvider.new
    @orsp.user_id = 1
    @orsp.description = ""
    @orsp.name = "foobar"
    @orsp.authentice_url = "http://www.foobar.com"
    @orsp.consumer_key = "0001"
    @orsp.consumer_secret = "0001"
  end

    it "a properlly set OauthRemoteServiceProvider instance should be valid" do
    @orsp.should be_valid
  end
  it "should validate that names are unique" do
    
  end
  it "should validate format of authorize urls" do
    @orsp.authenticate_url = ""
    @orsp.should_not be_valid
    @orsp.authenticate_url = "asd"
    @orsp.should_not be_valid
    @orsp.authenticate_url = "http://"
    @orsp.should_not be_valid
    @orsp.authenticate_url = "www.yahoo"
    @orsp.should_not be_valid
    @orsp.authenticate_url = "http://www.yahoo"
    @orsp.should_not be_valid
    @orsp.authenticate_url = "http://www.yahoo.com"
    @orsp.should be_valid
  end
  it "should require an associated user" do
    @orsp.user_id = nil
    @orsp.should_not be_valid
  end
end
