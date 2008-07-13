class Item < ActiveRecord::Base
  require 'maruku'
  def to_html
    if body.blank?
      self.update_attribute(:body, markdown(rawbody))
      self.body
    else
      self.body
    end
  end
  
  def markdown(text)
    text.blank? ? "" : Maruku.new(text).to_html
  end
end
