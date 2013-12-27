module SmartyStreets

  class InvalidConfigError < StandardError; end
  class InvalidArgumentError < StandardError; end
  class BadInputError < StandardError; end
  class AuthorizationError < StandardError; end
  class PaymentRequiredError < StandardError; end
  class InternalServerError < StandardError; end

end