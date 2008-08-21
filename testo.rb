

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  #
  #   map.namespace :oauth do |oauth|
  #     # Directs /oauth/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     oauth.resources :agree2
  #     oauth.resources :fireeagle
  #   end

gem 'oauth'
require 'oauth/consumer'

# good
@consumer=OAuth::Consumer.new "KtIl8dllf3dlLPXRI5AyhQ", "wJ7QxUlEMKYOohMsiKKU4RW1QM8S5gnbr4ziBJfr8", {:site=>"https://agree2.com"}

# bad key
@consumer=OAuth::Consumer.new "KtIaaaaaaaaaaaaaaaayhQ", "wJ7QaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaBJfr8", {:site=>"https://agree2.com"}

# invalid url
@consumer=OAuth::Consumer.new "KtIl8dllf3dlLPXRI5AyhQ", "wJ7QxUlEMKYOohMsiKKU4RW1QM8S5gnbr4ziBJfr8", {:site=>"https://agree2a.com"}


# access failure

@request_token = @consumer.get_request_token

puts @request_token.authorize_url

# The user needs to authorize the url. In a rails application you would do:
#
# redirect_to @request_token.authorize_url

# This will fail unless the user has authorized the token
@access_token = OAuth::AccessToken.new(@consumer, 'jD5Dxtuo9hi1nj7aXq0iA')
#@access_token = OAuth::AccessToken.new(@consumer, ‘access token’, ‘access token secret’)

@access_token = @request_token.get_access_token

# Request all your users agreements
@response=@access_token.get "/agreements.xml"
