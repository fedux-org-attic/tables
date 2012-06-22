# encoding: utf-8

#main module
module Tables
  #template report
  class HorizontalTable < BaseTable

    attr_reader :output

    # create report
    #
    # @param [Array] output the objects to be used to generate the table report
    # @param [Hash] options options for the table to be created
    #
    def initialize(items, options={})
      super items, options
    end

    def build
      suppress_output if @return_as_string == true

      table @table_options do
        #data rows
        @items.each do |item|
          row @data_row_options do
            @attributes.each do |attr|
              if item.respond_to?(attr)
                column item.public_send(attr).delete_newline , @column_options
              else
                raise UnknownDataAttribute, "Unknown attribute (#{attr}) supplied."
              end #if respond
            end # attributes
          end #row
        end # each data object
      end #table

      @output = capture_output if @return_as_string == true
    end
  end
end
