module LiveAddress
  class Address

    attr_accessor :street, :street2, :secondary, :city, :state, :zipcode, :lastline, :addressee,
                  :urbanization, :callback, :candidates

    def initialize(options)
      set_attributes(options)
    end

    private

    def set_attributes(options)
      options.each do |key,value|
        raise LiveAddress::InvalidArgumentError unless respond_to?(key)
        self.send("#{key}=", value)
      end
    end

  end
end