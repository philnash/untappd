require 'rubygems'
require 'httparty'
require 'hashie'

module Untappd
  include HTTParty
  base_uri 'http://api.untappd.com/v3'
  format :json
  @@apikey = nil
  
  def self.beer_checkins(beer_id, options={})
    options.merge!({
      :key => apikey,
      :bid => beer_id
    })
        
    response = get("/beer_checkins", :query => options)
    if response.code == 200
      Hashie::Mash.new(response).results
    else
      Hashie::Mash.new {}
    end
  end

  def self.apikey
    @@apikey
  end

  def self.apikey=(apikey)
    @@apikey = apikey
  end
  
  def self.configure
    yield self
  end
  
end