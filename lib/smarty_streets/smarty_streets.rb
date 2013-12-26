require 'pry'
require 'json'
require 'httparty'

module SmartyStreets

  class SmartyStreets

    attr_accessor :street, :street2, :secondary, :city, :state, :zipcode, :lastline, :addressee,
                  :urbanization, :callback, :candidates

    AUTH_ID = "00b81f59-bf87-42a6-ac65-5ea8556cac81"
    AUTH_TOKEN = "mhv7Wy1BLAptSU4eSucbxZYiz2DtdBioQe+q+OaFGViRRxx3OFlR5Cc1wShTaS5Yx3cLFF88MsGfKpc2A099yg=="
    API_ENDPOINT = "https://api.smartystreets.com/street-address"

    def self.auth_id
      AUTH_ID
    end

    def self.auth_token
      AUTH_TOKEN
    end

    def self.api_endpoint
      API_ENDPOINT
    end

    def initialize(options={})
      set_attributes(options)
    end

    def verify
      url = UrlBuilder.new(self).url
      response = JSON.parse(HTTParty.get(url).body)
      return [] if response.empty?
      response.map {|r| ResponseParser.new(r) }
    end

    private

    def set_attributes(options)
      # Allow this to error if the key is not a method to alert the end user the method
      # is invalid instead of silently swallowing it.
      options.each { |key,value| self.send("#{key}=", value) }
    end

  end

end
