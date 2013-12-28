require_relative '../../test_helper'
require "ostruct"

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

    describe "exceptions" do

      it "auth_id is not present" do
        subject.configure { |config| config.auth_id = nil }
        proc {
          subject.verify(:foo => "bar")
        }.must_raise(SmartyStreets::InvalidConfigError)
      end

      it "auth_token is not present" do
        subject.configure { |config| config.auth_token = nil }
        proc {
          subject.verify(:foo => "bar")
        }.must_raise(SmartyStreets::InvalidConfigError)
      end

      it "invalid options are passed" do
        proc {
          subject.verify(:foo => "bar")
        }.must_raise(SmartyStreets::InvalidArgumentError)
      end

      it "no options are passed" do
        proc {
          subject.verify
        }.must_raise(SmartyStreets::InvalidArgumentError)
      end

      describe "response codes" do
        it "status 400" do
          HTTParty.stubs(:get).returns(OpenStruct.new(:code => 400))
          proc {
            subject.verify(:candidates => 1)
          }.must_raise(SmartyStreets::BadInputError)
        end

        it "status 401" do
          HTTParty.stubs(:get).returns(OpenStruct.new(:code => 401))
          proc {
            subject.verify(:candidates => 1)
          }.must_raise(SmartyStreets::AuthorizationError)
        end

        it "status 402" do
          HTTParty.stubs(:get).returns(OpenStruct.new(:code => 402))
          proc {
            subject.verify(:candidates => 1)
          }.must_raise(SmartyStreets::PaymentRequiredError)
        end

        it "status 500" do
          HTTParty.stubs(:get).returns(OpenStruct.new(:code => 500))
          proc {
            subject.verify(:candidates => 1)
          }.must_raise(SmartyStreets::InternalServerError)
        end
      end
    end

    describe "requests" do
      let(:options) {
        {
          :city    => "bend",
          :state   => "oregon",
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
        let (:results) { subject.verify(options) }

        before do
          VCR.insert_cassette 'address', :record => :new_episodes
        end

        it "returns an array of results" do
          results.must_be_instance_of(Array)
        end

        it "returns objects with a formatted address" do
          result = results.first
          result.delivery_line_1.must_equal("550 NW Franklin Ave Ste 200")
          result.last_line.must_equal("Bend OR 97701-2892")
        end

      end
    end
  end

end