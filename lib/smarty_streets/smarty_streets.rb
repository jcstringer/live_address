require 'uri'
require 'pry'

module SmartyStreets

  class SmartyStreets

    attr_accessor :city, :state, :street, :street2, :zipcode

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
      # @city    = options[:city]
      # @state   = options[:state]
      # @street  = options[:street]
      # @street2 = options[:street2]
      # @zipcode = options[:zipcode]
    end

    def verify
      response = Response.new(build_url)
      puts reponse.inspect

      return { :error => "Could not locate address." } unless parsed_response.first
      response = parsed_response #parsed_response.first.deep_symbolize_keys
      first_response = response.first
      set_attrs(first_response)
      puts self.inspect
    end

    private

    def set_attrs(hash)
      hash.each do |key,value|
        symbolized_key = key.to_sym
        self.class.send(:attr_accessor, symbolized_key) unless self.respond_to?(symbolized_key)
        if value.is_a?(Hash)
          self.send("#{symbolized_key}=", set_attrs(value))
        else
          self.send("#{symbolized_key}=", value)
        end
      end
    end

    def parsed_response
      @parsed_response ||= JSON.parse(HTTParty.get(build_url).body)
    end

    def build_url
      params = {
        :street => street,
        :city =>city,
        :state => state,
        :zipcode => zipcode,
        :"auth-id" => self.class.auth_id,
        :"auth-token" => self.class.auth_token
      }
      "#{self.class.api_endpoint}?#{URI.encode_www_form(params)}"
    end

    # def format_address
    #   {
    #     :street => street_address,
    #     :city => response[:components][:city_name],
    #     :state => abbreviated_state,
    #     :zip => response[:components][:zipcode]
    #   }
    # end

    # def street_address
    #   [response[:delivery_line_1], response[:delivery_line_2]].reject { |val| val.blank? }.join(" ")
    # end

    # def abbreviated_state
    #   State.full_name(response[:components][:state_abbreviation])
    # end



  end

end
