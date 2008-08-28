class OauthRemoteServiceProvider < ActiveRecord::Base
  has_many :oauth_remote_access_tokens
  belongs_to :user
  validates_presence_of :name, :consumer_key, :consumer_secret, :site_url
  validates_uniqueness_of :name
  validates_format_of :site_url, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :message => "is not a valid url"
end
