class Person
  attr_accessor :name, :street
end

FactoryGirl.define do
  factory :person do
    name 'Manfred Huber'
    street  'Sesamestreet 1'
  end
end
