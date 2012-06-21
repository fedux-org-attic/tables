require 'factory_girl'

class Person
  attr_accessor :name, :street
end

FactoryGirl.define do
  factory :person do
    name 'Manfred Huber'
    street  'Sesamestreet 1'
    skip_create
  end
end

require 'tables/helper/step_definitions'
