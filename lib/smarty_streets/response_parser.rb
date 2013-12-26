module SmartyStreets

  class ResponseParser

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
      klass = Object.const_set attribute.capitalize, Class.new(self.class)
      klass.send(:define_method, :initialize) { |args| set_attrs(args) }
      instance_variable_set("@#{attribute}", klass.new(hash))
    end

  end

end