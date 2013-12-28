require_relative '../../test_helper'

describe LiveAddress do

  it "must be defined" do
    LiveAddress::VERSION.wont_be_nil
  end

end