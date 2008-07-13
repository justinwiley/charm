class Location < ActiveRecord::Base
  require 'net/http'
  require 'hpricot'
  @yahoo_coord_url = URI.parse('http://search.yahooapis.com/ContentAnalysisService/V1/termExtraction')
  @hostip_geolocator_url = URI.parse("http://api.hostip.info/?ip=68.180.206.184&position=true")

  # hit up community geolocator to try and get address from IP
  def address_from_ip(ip)
    begin
      resp = Net::HTTP.get_response(@hostip_geolocator_url)
      doc = Hpricot(resp.body)
      coords = doc.search("//gml:coordinates").inner_html.split(',')
      countryname = doc.search("/gml:countryname").inner_html
      area = doc.search("//gml:name").inner_html.gsub(/hostip/,'').split(",")
      self.lat = coords[0]
      self.long = coords[1]
      self.city = area[0]
      self.state = area[1]
      self.country = countryname
    rescue NoMethodError, SocketError
      nil
    end
   end
  
  # hit up yahoo to get lat/long for address
  # To paraphrase the great Tupac, "I hit em' up!"
  def coord_for_address
    return nil unless address.kind_of?(String) || address.kind_of?(Array)
    address = address.join(",") if address.kind_of?(Array)
    post_args = {
      'appid' => YAHOO_API_KEY,
      'location' => URI.encode(address)
    }
    begin
      resp, data = Net::HTTP.post_form(@yahoo_coord_url, post_args)
      doc = Hpricot(resp.body)
      self.lat = doc.search("//latitude").inner_html rescue nil
      self.long = doc.search("//longitude").inner_html rescue nil
    rescue NoMethodError, SocketError
      nil
    end
  end
end