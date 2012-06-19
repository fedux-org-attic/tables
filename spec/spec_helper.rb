# encoding: utf-8
$LOAD_PATH << File.expand_path('../lib/tmrb' , File.dirname(__FILE__))

require 'tables'

include Tables

RSpec.configure do |c|
    c.treat_symbols_as_metadata_keys_with_true_values = true
end
