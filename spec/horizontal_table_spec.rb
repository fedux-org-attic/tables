# encoding: utf-8
require 'spec_helper'

describe HorizontalTable do
  before(:all) do
    Person = Struct.new( :name, :address)

    @output = [
      Person.new('Manfred Huber', 'Sesamestreet 1'),
      Person.new('Herbert Heinzelmann', 'Musterstroat 1'),
    ]
  end

  it "outputs a table for an array of objects" do

      HorizontalTable.run(@output, attributes: [:name, :address]).should == <<-EOF
┏━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┓
┃ Manfred Huber       ┃ Sesamestreet 1 ┃ 
┣━━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━┫
┃ Herbert Heinzelmann ┃ Musterstroat 1 ┃ 
┗━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━┛
EOF

  end

  it "fails when an invalid attribute is given" do
      lambda{ HorizontalTable.run(@output, attributes: [:typo_name, :address]) }.should raise_error UnknownDataAttribute
  end

  it "could have a header row" do
      HorizontalTable.run(@output, attributes: [:name, :address], header: ["Name", "Address"]).should == <<-EOF
┏━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┓
┃ \e[1mName               \e[0m ┃ \e[1mAddress       \e[0m ┃ 
┣━━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━┫
┃ Manfred Huber       ┃ Sesamestreet 1 ┃ 
┣━━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━┫
┃ Herbert Heinzelmann ┃ Musterstroat 1 ┃ 
┗━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━┛
EOF
  end

  it "fails if the count of header column does not match the count of the attribute columns" do
      lambda{HorizontalTable.run(@output, attributes: [:name, :address], header: ["Name" ])}.should raise_error InvalidTableDefinition 
  end

#  describe '#calc_column_width' do
#
#    it 'calculates the column width based on a percentage' do
#      ENV['COLUMNS'] = '100'
#      calc_column_width('50%').should == 50
#
#      ENV['COLUMNS'] = '150'
#      calc_column_width('50%').should == 75
#    end
#
#    it 'calculates the column width based on absolute value' do
#      ENV['COLUMNS'] = '150'
#      calc_column_width('50').should == 50
#    end
#
#  end
#
#  describe '#calc_relative_column_width' do
#
#    it 'calculates the column width based on a percentage' do
#      ENV['COLUMNS'] = '100'
#      calc_relative_column_width(50).should == 50
#
#      ENV['COLUMNS'] = '150'
#      calc_relative_column_width(50).should == 75
#    end
#
#  end
#
#  describe '#delete_newline' do
#    it 'deletes newline in string' do
#      "text\ntext".delete_newline.should == 'texttext'
#    end
#  end
#
#  describe "prepares the column widths" do
#    it "overwrite global options with special ones" do
#      table_options = { width: 90 }
#
#      column_options = { width: 45 }
#      column_widths = %W[ 40 30 20 ]
#
#      prepare_column_widths( column_widths, table_options, column_options ).should == [ 40, 30, 20 ]
#    end
#
#    it "fills empty options with global ones" do
#      table_options = { width: 115 }
#
#      column_options = { width: 45 }
#      column_widths = %W[ 40 30 ]
#
#      prepare_column_widths( column_widths, table_options, column_options ).should == [ 40, 30, 45]
#    end
#
#    it "fails when table width is smaller than all column widths together" do
#      table_options = { width: 100 }
#
#      column_options = { width: 45 }
#      column_widths = %W[ 40 30 ]
#
#      lambda{prepare_column_widths( column_widths, table_options, column_options )}.should raise_error InvalidTableDefinition
#
#    end
#
#    it "converts string percent values in absolute ones" do
#      column_widths = %W[ 40% 30% 30%]
#      ENV['COLUMNS'] = '100'
#      prepare_column_widths( column_widths, table_options, column_options ).should == [ 40, 30, 30]
#    end
#
#  end

end
