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

      it "errors when invalid options are passed" do
        proc {
          subject.new(:foo => "bar")
        }.must_raise(NoMethodError)
      end
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
          options.merge!(:street => "1234 not real street")
          subject.new(options).verify.must_equal []
        end
      end

      describe "valid addresss" do
        before do
          VCR.insert_cassette 'address', :record => :new_episodes
        end

        it "returns an array of results" do
          subject.new(options).verify.must_be_instance_of(Array)
        end
      end
    end
  end

end