require 'pry'
require 'json'
require 'httparty'

module SmartyStreets

  class SmartyStreets

    class << self
      attr_accessor :configuration
    end

    attr_accessor :street, :street2, :secondary, :city, :state, :zipcode, :lastline, :addressee,
                  :urbanization, :callback, :candidates

    # Pattern inspired by http://robots.thoughtbot.com/mygem-configure-block/
    def self.configure
      self.configuration = Configuration.new
      yield(configuration)
    end

    def self.auth_id
      SmartyStreets.configuration.auth_id
    end

    def self.auth_token
      SmartyStreets.configuration.auth_token
    end

    def self.api_endpoint
      SmartyStreets.configuration.api_endpoint
    end

    def initialize(options={})
      set_attributes(options)
    end

    def verify
      binding.pry
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
