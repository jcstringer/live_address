# LiveAddress

Ruby gem to perform US address validation by way of a Ruby interface to the [SmartyStreets LiveAddress API](http://smartystreets.com/). Gives you a Ruby DSL to interact with the API and first class Ruby objects from the response. If you need to validate addresses, skip the unmaintained scrap yard of USPS related gems out there and use a more modern solution such as this one. SmartyStreets currently provides 250 free lookups per month. Beyond that they have reasonable pricing.

This gem is certainly not the only attempt to wrap this API, although I believe it is the newest one. Check out [smarty_streets](https://github.com/russ/smarty_streets) (a basic wrapper for street address verification) and [smartystreets](https://github.com/centzy/smartystreets) (supports street and ZIP code APIs, batch requests, and all documented fields) which were both around before I created this gem.

Where this gem differs from its predecessors is that it attempts to futureproof changes to what the SmartyStreets LiveAddress API returns by dynamically creating the Ruby response objects. This means that if the SmartyStreets decides to add or remove attributes to/from what their API returns, this gem should still "just work".

## Current Version

[![Gem Version](https://badge.fury.io/rb/live_address.png)](http://badge.fury.io/rb/live_address)

## Requirements

This gem was created and tested with Ruby 1.9.3. It may well work with earlier versions of Ruby but I make no guarantees.

## Installation

Add this line to your application's Gemfile:

    gem 'live_address'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install live_address

## Usage

1. First things first. You will need to sign up for an account with Smarty Streets. Once you have signed up and logged in you should be able to generate an API key which will give you the Auth ID and Auth Token that you'll need to start using this gem.
2. Configure your Rails app to use your credentials with the gem. The suggested approach would be to put this in an initializer. Also be sure to use the raw version of the Auth token and not the encoded one.

```
LiveAddress.configure do |config|
  config.auth_id    = "YOUR AUTH ID"
  config.auth_token = "YOUR AUTH TOKEN"
end
```

3. Use the verify method to request address verification of an address that you submit. The SmartyStreets web site contains document for valid [input fields](http://smartystreets.com/kb/liveaddress-api/rest-endpoint) and [response fields](http://smartystreets.com/kb/liveaddress-api/field-definitions). Note that you can limit the number of results using the optional candidates field. The results are returned as an array of formatted ResponseParser objects, and a lookup with no results simply returns an empty array.

```
=> address = {
            :city    => "bend",
            :state   => "oregon",
            :zipcode => "97701",
            :street  => "550 NW Franklin Avenue",
            :street2 => "Suite 200"
          }

=> LiveAddress.verify(address)

# [#<LiveAddress::ResponseParser:0x007ffd6c972fe0
  @analysis=
   #<Analysis:0x007ffd6c970830
    @active="Y",
    @dpv_cmra="N",
    @dpv_footnotes="AABB",
    @dpv_match_code="Y",
    @dpv_vacant="N",
    @footnotes="N#">,
  @candidate_index=0,
  @components=
   #<Components:0x007ffd6c9728d8
    @city_name="Bend",
    @delivery_point="50",
    @delivery_point_check_digit="0",
    @plus4_code="2892",
    @primary_number="550",
    @secondary_designator="Ste",
    @secondary_number="200",
    @state_abbreviation="OR",
    @street_name="Franklin",
    @street_predirection="NW",
    @street_suffix="Ave",
    @zipcode="97701">,
  @delivery_line_1="550 NW Franklin Ave Ste 200",
  @delivery_point_barcode="977012892500",
  @input_index=0,
  @last_line="Bend OR 97701-2892",
  @metadata=
   #<Metadata:0x007ffd6c971a28
    @carrier_route="C004",
    @congressional_district="02",
    @county_fips="41017",
    @county_name="Deschutes",
    @dst=true,
    @elot_sequence="0241",
    @elot_sort="A",
    @latitude=44.05722,
    @longitude=-121.31347,
    @precision="Zip9",
    @rdi="Commercial",
    @record_type="H",
    @time_zone="Pacific",
    @utc_offset=-8.0,
    @zip_type="Standard">>]
```

## Specs

Specs are written using mini-test. Run them like this.

```
rake
```

## TODO

* Add support for zip code API
* Add support for POST requests which would in turn allow for multiple addresses in one submission (batch requests)

## Authors

Chris Stringer / [@jcstringer](https://github.com/jcstringer)

## Bugs

File an [issue](https://github.com/jcstringer/live_address/issues)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

If you find bugs, have feature requests or questions, please file an issue.

## License

Copyright (c) 2013 Chris Stringer

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.