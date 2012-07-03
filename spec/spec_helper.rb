# encoding: utf-8
$LOAD_PATH << File.expand_path('../lib/tmrb' , File.dirname(__FILE__))

require 'tables'
require 'tables/testing_helper'
require 'pry'

require 'factory_girl'
require_relative 'factories'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.include Tables
  c.include Tables::TestingHelper
end
