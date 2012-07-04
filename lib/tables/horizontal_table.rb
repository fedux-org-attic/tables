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
      suppress_output if @table_options[:return_as_string] == true

      table build_options(:table, @table_options) do
        if @header_options[:show] == true
          row build_options(:header, @header_options) do 
            @headers.each do |h|
              column h, build_options(:column, @column_options )
            end
          end
        end

        #data rows
        @items.each do |item|
          row build_options(:data, @data_options) do
            @attributes.each do |attr|
              if item.respond_to?(attr)
                column item.public_send(attr).delete_newline , build_options(:column, @column_options)
              else
                raise UnknownDataAttribute, "Unknown attribute (#{attr}) supplied."
              end #if respond
            end # attributes
          end #row
        end # each data object
      end #table

      @output = capture_output if @table_options[:return_as_string] == true
    end
  end
end
