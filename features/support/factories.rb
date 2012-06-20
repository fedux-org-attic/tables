#encoding: utf-8
require 'factory_girl'
require_relative 'models/person'

FactoryGirl.define do
  factory :person do
    name 'Manfred Huber'
    street  'Sesamestreet 1'
  end
end

require 'tables/helper/factory_girl-step_definitions-build'
