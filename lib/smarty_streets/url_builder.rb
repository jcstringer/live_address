require 'uri'

module SmartyStreets

  class UrlBuilder

    attr_accessor :instance, :url

    def initialize(instance)
      @instance = instance
      @url = build_url
    end

    private

    def build_url
      params = {
        :street => instance.street,
        :street2 => instance.street2,
        :secondary => instance.secondary,
        :city => instance.city,
        :state => instance.state,
        :zipcode => instance.zipcode,
        :lastline => instance.lastline,
        :addressee => instance.addressee,
        :urbanization => instance.urbanization,
        :callback => instance.callback,
        :candidates => instance.candidates,
        :"auth-id" => SmartyStreets::auth_id,
        :"auth-token" => SmartyStreets::auth_token
      }
      "#{SmartyStreets::api_endpoint}?#{URI.encode_www_form(params)}"
    end

  end

end