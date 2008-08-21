class OauthRemoteAccessToken < ActiveRecord::Base
  after_validation_on_create :delete_existing_access_token_if_exists
  belongs_to :user
  belongs_to :oauth_remote_service_provider
  serialize :token_object, OAuth::AccessToken   # serializes OAuth::AccessToken object
  
  alias :expire :destroy
  
  # there should only be one active access token per service provider per user
  def delete_existing_access_token_if_exists
    if existing_token = OauthRemoteAccessToken.find(:first, :conditions => ['oauth_remote_service_provider_id = ? AND user_id = ?',
                                                    self.oauth_remote_service_provider_id, 
                                                    self.user_id])
      existing_token.destroy
    end
    return true
  end
end
