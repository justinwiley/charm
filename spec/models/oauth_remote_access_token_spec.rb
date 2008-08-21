require File.dirname(__FILE__) + '/../spec_helper'

describe OauthRemoteAccessToken do
  before(:each) do
    @orat = OauthRemoteAccessToken.new    # OauthRemoteAccessToken or spacequest.wikia.com/wiki/Orat
    @orat.token_object = OAuth::AccessToken.new("","","")
    @orat.oauth_remote_service_provider_id = 1
    @orat.user_id = 1
  end

  it "a properlly set OauthRemoteAccessToken instance should be valid" do
    @orat.should be_valid
  end
  it "expire should call destroy" do
    @orat.expire
  end
  it "should fail to serialize a non-OAuth::AccessToken" do
    @orat.token_object = String.new
    lambda {@orat.save}.should raise_error(ActiveRecord::SerializationTypeMismatch)
  end
  it "should delete exisiting access token on save, if validations pass" do
    @orat.should_receive(:delete_existing_access_token_if_exists)
    @orat.save
  end
end
