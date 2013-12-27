require 'minitest/autorun'
require 'minitest/pride'
require "mocha/setup"
require 'webmock/minitest'
require 'vcr'
require File.expand_path('../../lib/smarty_streets.rb', __FILE__)

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end