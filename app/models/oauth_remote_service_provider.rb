class OauthRemoteServiceProvider < ActiveRecord::Base
  has_many :oauth_remote_access_tokens
  belongs_to: user
  validates_pressence_of :name
  validates_uniquenes_of :name
  validates_pressence_of :consumer_key
  validates_pressence_of :consumer_secret
  validates_format_of :authorize_url, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :message => "is not a valid url"
end