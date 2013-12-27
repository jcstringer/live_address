module SmartyStreets
  class Address

    attr_accessor :street, :street2, :secondary, :city, :state, :zipcode, :lastline, :addressee,
                  :urbanization, :callback, :candidates

    def initialize(options={})
      set_attributes(options)
    end

    private

    def set_attributes(options)
      # Allow this to error if the key is not a method to alert the end user the method
      # is invalid instead of silently swallowing it.
      options.each { |key,value| self.send("#{key}=", value) }
    end

  end
end