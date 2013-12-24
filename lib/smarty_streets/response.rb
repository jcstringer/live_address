require 'json'
require 'httparty'

module SmartyStreets

  class Response

    SUBCLASSES = %w{components metadata analysis}

    def initialize(url)
      response = JSON.parse(HTTParty.get(url).body).first
      @components = Components.new(response["components"])
      @metadata   = Metadata.new(response["metadata"])
      @analysis   = Analysis.new(response["analysis"])
      define_attrs_for_subclasses
      set_attrs(response.reject{ |key, val| SUBCLASSES.include?(key) })
    end

    private

    def define_attrs_for_subclasses
      SUBCLASSES.map { |attribute| define_attr(attribute.to_sym) }
    end

    def set_attrs(hash)
      hash.each do |key,value|
        symbolized_key = key.to_sym
        define_attr(symbolized_key)
        self.send("#{symbolized_key}=", value)
      end
    end

    def define_attr(attribute)
      self.class.send(:attr_accessor, attribute) unless self.respond_to?(attribute)
    end

  end

  class Components < SmartyStreets::Response

    def initialize(components)
      set_attrs(components)
    end

  end

  class Metadata < SmartyStreets::Response

    def initialize(metadata)
      set_attrs(metadata)
    end

  end

  class Analysis < SmartyStreets::Response

    def initialize(metadata)
      set_attrs(metadata)
    end

  end

end