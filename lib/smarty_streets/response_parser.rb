module SmartyStreets

  class ResponseParser

    SUBCLASSES = %w{components metadata analysis}

    def initialize(response)
      create_subclasses
      define_attrs_for_subclasses
      @components = Components.new(response["components"])
      @metadata   = Metadata.new(response["metadata"])
      @analysis   = Analysis.new(response["analysis"])
      set_attrs(response.reject{ |key, val| SUBCLASSES.include?(key) })
    end

    private

    def create_subclasses
      SUBCLASSES.each do |subclass|
        klass = Object.const_set subclass.capitalize, Class.new(self.class)
        klass.send(:define_method, :initialize) { |args| set_attrs(args) }
      end
    end

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

end