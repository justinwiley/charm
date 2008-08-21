# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem   # include restful authentication methods in all controllers

  helper :all # include all helpers, all the time TODO performance optimization
  
  # prevent spiders from spoiling the party and ensure RESTful calling of appripriate actions
  verify :method => :post, :only => [:destroy, :update], :redirect_to => { :action => :list }
  verify :method => :get, :only => [:index, :show, :new], :redirect_to => { :action => :list }
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e036d8409078fbd3d8c9e3f2824d8242'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
