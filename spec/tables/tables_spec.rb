#encoding: utf-8
require 'spec_helper'

#@example
#  Example:
#  * object_1 (attr_1, attr_2, attr_3)
#  * object_2 (attr_1, attr_2, attr_3)
#  
#  ----------------------------------------------------
#  | attr_1          | attr_2          |attr_3          |
#  |----------------------------------------------------|
#  | value_object_1  | value_object_1  | value_object_1 |
#  | value_object_2  | value_object_2  | value_object_2 |
#  ----------------------------------------------------

describe Tables do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end

  describe "#horizontal_table" do
    before :all do
      persons = [
        {
          name: 'Max Mustermann',
          street: 'Musterstraße 1'
        },
        {
          name: 'Herbert Hurtig',
          street: 'Schnelle Straße 200'
        },
        {
          name: 'Peter Pause',
          street: 'Gemütlicher Weg 2'
        },
      ]

      @data = []
      persons.each do |p|
        @data << FactoryGirl.build(:person, name: p[:name], street: p[:street])
      end

      @options =  {
        table: {
          return_as_string: true #only for testing
        }
      }
    end

    context "without any option" do

      it "displays a table with a border" do
        options = {}.rmerge @options

        output = horizontal_table @data, options
        output.should == <<EOF.unindent
        ┏━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━┓
        ┃ Max Mustermann ┃ Musterstraße 1      ┃ 
        ┣━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━┫
        ┃ Herbert Hurtig ┃ Schnelle Straße 200 ┃ 
        ┣━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━┫
        ┃ Peter Pause    ┃ Gemütlicher Weg 2   ┃ 
        ┗━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━┛
EOF
      end #it
    end #context

    context "when border option is false" do
      it "displays a table without a border" do

        options = {
          table: {
            border: false
          },
        }.rmerge @options

        output = horizontal_table @data, options
        output.should == <<EOF.unindent
        Max Mustermann Musterstraße 1      
        Herbert Hurtig Schnelle Straße 200 
        Peter Pause    Gemütlicher Weg 2   
EOF
      end #it
    end #context

    context "when header option is :camelize" do
      it "displays a table with a header based on the camelized names of the attributes" do

        options = {
          header: {
            format: :camelize,
            show: true
          },
        }.rmerge @options

        output = horizontal_table @data, options
        output.should == <<EOF.unindent
        ┏━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━┓
        ┃ \e[1mName\e[0m ┃ \e[1mStreet   \e[0m ┃ 
        ┣━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━┫
        ┃ Max Mustermann ┃ Musterstraße 1      ┃ 
        ┣━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━┫
        ┃ Herbert Hurtig ┃ Schnelle Straße 200 ┃ 
        ┣━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━┫
        ┃ Peter Pause    ┃ Gemütlicher Weg 2   ┃ 
        ┗━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━┛
EOF
      end #it
    end #context

    context "when attributes option is [ :name ]" do
      it "displays a table with only one column (name)" do

        options = {
          table: {
            attributes: [ :name ]
          },
        }.rmerge @options

        output = horizontal_table @data, options
        output.should == <<EOF.unindent
        ┏━━━━━━━━━━━━━━━━┓
        ┃ Max Mustermann ┃ 
        ┣━━━━━━━━━━━━━━━━┫
        ┃ Herbert Hurtig ┃ 
        ┣━━━━━━━━━━━━━━━━┫
        ┃ Peter Pause    ┃ 
        ┗━━━━━━━━━━━━━━━━┛
EOF
      end #it
    end #context
  end #describe
end
