class NoUser    # acts like nil, except instantiable.  Method missing returns false for everything so admin? and logged_in? work.
  def nil?; true; end;
  def false?; true; end;
  
  def method_missing(method, *args)
    method =~ /is_not/ ? true : false   # handles "is not logged in and is logged in
  end
end

class User < ActiveRecord::Base
  cattr_reader :current_user

  def is_not_logged_in?
    raise Exception.new("User logged_in? instead, negated methods will clash with NoUser pattern")
  end
  
  def admin?
    self.type.to_sym == :admin
  end
  
  def self.current=(user)
    raise ArgumentError.new("Must pass in user object") unless user.kind_of?(User)
    @@current_user = user
  end
  
  # if there is no current user, return a no user object that will respond negatively to all
  def self.current
    self.current_user == nil ? NoUser.new : self.current_user
  end
end
