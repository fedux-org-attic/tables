# encoding: utf-8
require 'spec_helper'

describe DetailTable do
  before(:all) do
    Person = Struct.new( :name, :address)

    @output = [
      Person.new('Manfred Huber', 'Sesamestreet 1'),
      Person.new('Herbert Heinzelmann', 'Musterstroat 1'),
    ]
  end

  it "outputs a table for an array of objects" do

      DetailTable.run(@output, attributes: [:name, :address]).should == <<-EOF
┏━━━━━━━━━━━━━━━┓
┃ Manfred Huber ┃ 
┗━━━━━━━━━━━━━━━┛
┏━━━━━━━━━━━━━━━━┓
┃ Sesamestreet 1 ┃ 
┗━━━━━━━━━━━━━━━━┛
           
┏━━━━━━━━━━━━━━━━━━━━━┓
┃ Herbert Heinzelmann ┃ 
┗━━━━━━━━━━━━━━━━━━━━━┛
┏━━━━━━━━━━━━━━━━┓
┃ Musterstroat 1 ┃ 
┗━━━━━━━━━━━━━━━━┛
EOF

  end

  it "fails when an invalid attribute is given" do
      lambda{ DetailTable.run(@output, attributes: [:typo_name, :address]) }.should raise_error UnknownDataAttribute
  end

  it "could have a header row" do
      DetailTable.run(@output, attributes: [:name, :address], header: ["Name", "Address"]).should == <<-EOF
┏━━━━━━━━━━━━━━━┓
┃ \e[1mName         \e[0m ┃ 
┣━━━━━━━━━━━━━━━┫
┃ Manfred Huber ┃ 
┗━━━━━━━━━━━━━━━┛
┏━━━━━━━━━━━━━━━━┓
┃ \e[1mAddress       \e[0m ┃ 
┣━━━━━━━━━━━━━━━━┫
┃ Sesamestreet 1 ┃ 
┗━━━━━━━━━━━━━━━━┛
           
┏━━━━━━━━━━━━━━━━━━━━━┓
┃ \e[1mName               \e[0m ┃ 
┣━━━━━━━━━━━━━━━━━━━━━┫
┃ Herbert Heinzelmann ┃ 
┗━━━━━━━━━━━━━━━━━━━━━┛
┏━━━━━━━━━━━━━━━━┓
┃ \e[1mAddress       \e[0m ┃ 
┣━━━━━━━━━━━━━━━━┫
┃ Musterstroat 1 ┃ 
┗━━━━━━━━━━━━━━━━┛
EOF
  end

  it "fails if the count of header column does not match the count of the attribute columns" do
      lambda{DetailTable.run(@output, attributes: [:name, :address], header: ["Name" ])}.should raise_error InvalidTableDefinition 
  end

end
