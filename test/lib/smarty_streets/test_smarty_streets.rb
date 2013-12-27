require_relative '../../test_helper'

describe SmartyStreets do

  subject { SmartyStreets }

  before do
    subject.configure do |config|
      # These credentials are no longer valid, they were deleted after the VCR cassettes were recorded
      config.auth_id    = "00b81f59-bf87-42a6-ac65-5ea8556cac81"
      config.auth_token = "mhv7Wy1BLAptSU4eSucbxZYiz2DtdBioQe+q+OaFGViRRxx3OFlR5Cc1wShTaS5Yx3cLFF88MsGfKpc2A099yg=="
    end
  end

  describe "config" do

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

  describe "verify" do

    it "errors when invalid options are passed" do
      proc {
        subject.verify(:foo => "bar")
      }.must_raise(NoMethodError)
    end

    describe "requests" do
      let(:options) {
        {
          :city    => "Bend",
          :state   => "OR",
          :zipcode => "97701",
          :street  => "550 NW Franklin Avenue",
          :street2 => "Suite 200"
        }
      }

      after do
        VCR.eject_cassette
      end

      describe "invalid address" do
        before do
          VCR.insert_cassette 'invalid_address', :record => :new_episodes
        end

        it "returns an empty array when the address has no results" do
          options.merge!(:street => "1234 not real street", :zipcode => "9999999")
          subject.verify(options).must_equal []
        end
      end

      describe "valid addresss" do
        let (:result) { subject.verify(options) }

        before do
          VCR.insert_cassette 'address', :record => :new_episodes
        end

        it "returns an array of results" do
          result.must_be_instance_of(Array)
        end

        it "returns objects with a city" do
          result.first.components.city_name.must_equal("#{options[:city]}")
        end
      end
    end
  end

end