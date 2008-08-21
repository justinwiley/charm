class ErrorController < ActionController::Base
  # get error_url
  def error
    render :text => "We're so sorry!"  # show error partial
  end
end