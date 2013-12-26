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

    subject { SmartyStreets::SmartyStreets }

    describe "attributes" do
      it "has a city" do
        subject.new.must_respond_to(:city)
      end
    end

    describe "requests" do
      # before do
      #   VCR.insert_cassette __name__

      #   # make HTTP request in before
      # end

      # after do
      #   # make HTTP request in after

      #   VCR.eject_cassette
      # end

      VCR.use_cassette('valid_address') do
        it "verifies" do
          options = {
            :city    => "Bend",
            :state   => "OR",
            :zipcode => "97701",
            :street  => "550 NW Franklin Avenue",
            :street2 => "Suite 200"
          }
          subject.new(options).verify.must_be_instance_of(Array)
        end
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