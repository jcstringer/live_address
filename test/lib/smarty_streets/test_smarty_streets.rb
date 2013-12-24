require_relative '../../test_helper'

describe SmartyStreets::SmartyStreets do

  describe "class" do

    subject { SmartyStreets::SmartyStreets }

    it "has an auth id" do
      subject.must_respond_to(:auth_id)
    end

    it "has an auth token" do
      subject.must_respond_to(:auth_token)
    end

    it "has an api endpoint" do
      subject.must_respond_to(:api_endpoint)
    end
  end

  describe "instance" do
    subject { SmartyStreets::SmartyStreets.new }

    describe "attributes" do
      it "has a city" do
        subject.must_respond_to(:city)
      end
    end

    describe "requests" do
      it "verifies" do
        subject.city = "Bend"
        subject.state = "OR"
        subject.zipcode = "97701"
        subject.street = "2492 NW Monterey Pines Dr."
        puts subject.verify.inspect
      end
    end
  end


  # describe "splitting into lines" do

  #   it "must correctly split the file into lines" do
  #     subject.processed_source.must_be_instance_of(Array)
  #   end

  #   it "must correctly remove empty lines" do
  #     subject.processed_source.wont_include(nil)
  #   end

  # end

end