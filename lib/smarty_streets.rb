require 'json'
require 'httparty'

require_relative "./smarty_streets/version"
require_relative "./smarty_streets/configuration"
require_relative "./smarty_streets/address"
require_relative "./smarty_streets/url_builder"
require_relative "./smarty_streets/response_parser"

module SmartyStreets

  class << self
    attr_accessor :configuration

    # Pattern inspired by http://robots.thoughtbot.com/mygem-configure-block/
    def configure
      self.configuration = Configuration.new
      yield(configuration)
    end

    def auth_id
      SmartyStreets.configuration.auth_id
    end

    def auth_token
      SmartyStreets.configuration.auth_token
    end

    def api_endpoint
      SmartyStreets.configuration.api_endpoint
    end

    def verify(options)
      address = Address.new(options)
      url = UrlBuilder.new(address).url
      response = JSON.parse(HTTParty.get(url).body)
      return [] if response.empty?
      response.map {|r| ResponseParser.new(r) }
    end

  end
end
