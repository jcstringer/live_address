require 'httparty'

require_relative "./live_address/exceptions"
require_relative "./live_address/version"
require_relative "./live_address/configuration"
require_relative "./live_address/address"
require_relative "./live_address/url_builder"
require_relative "./live_address/response_parser"

module LiveAddress

  class << self
    attr_accessor :configuration

    # Pattern inspired by http://robots.thoughtbot.com/mygem-configure-block/
    def configure
      self.configuration = Configuration.new
      yield(configuration)
    end

    def auth_id
      LiveAddress.configuration.auth_id
    end

    def auth_token
      LiveAddress.configuration.auth_token
    end

    def api_endpoint
      LiveAddress.configuration.api_endpoint
    end

    def verify(options={})
      if self.configuration.auth_id.nil? || self.configuration.auth_token.nil?
        raise LiveAddress::InvalidConfigError
      end
      raise LiveAddress::InvalidArgumentError if options.empty?
      address = Address.new(options)
      url = UrlBuilder.new(address).url
      response = HTTParty.get(url)
      ResponseParser.parse(response)
    end

  end
end
