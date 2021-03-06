require 'json'

module LiveAddress

  class ResponseParser

    def self.parse(response)
      raise BadInputError        if response.code == 400
      raise AuthorizationError   if response.code == 401
      raise PaymentRequiredError if response.code == 402
      raise InternalServerError  if response.code == 500

      parsed_response = JSON.parse(response.body)
      parsed_response.map {|r| ResponseParser.new(r) }
    end

    def initialize(response)
      set_attrs(response)
    end

    private

    def set_attrs(hash)
      # Dynamically create attrs on the object for each hash key
      # and create subclasses for nested hashes
      hash.each do |key,value|
        symbolized_key = key.to_sym
        define_attr(symbolized_key)
        if value.is_a?(Hash)
          populate_subclass(key, value)
        else
          self.send("#{symbolized_key}=", value)
        end
      end
    end

    def define_attr(attribute)
      self.class.send(:attr_accessor, attribute)
    end

    def populate_subclass(attribute, hash)
      klass_name = attribute.capitalize
      if Object.const_defined? klass_name
        klass = Object.const_get klass_name
      else
        klass = Object.const_set klass_name, Class.new(self.class)
      end
      klass.send(:define_method, :initialize) { |args| set_attrs(args) }
      instance_variable_set("@#{attribute}", klass.new(hash))
    end

  end

end