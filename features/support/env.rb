#encoding: utf-8
$LOAD_PATH << File.expand_path( '../../lib' , File.dirname( __FILE__))

require 'pry'
require 'tables'
require 'tables/testing_helper'

include Tables
include Tables::TestingHelper
