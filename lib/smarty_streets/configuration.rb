module SmartyStreets
  class Configuration

    attr_accessor :api_endpoint, :auth_id, :auth_token

    def initialize
      @api_endpoint = 'https://api.smartystreets.com/street-address'
    end

  end

end