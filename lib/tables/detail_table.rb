# encoding: utf-8

#main module
module Tables
  #template report
  class DetailTable < BaseTable

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
      suppress_output

      @items.each do |item|
        @attributes.each do |attr|
          table @table_options do
            if @header.count > 0
              row @header_row_options do 
                column @header.go_over, @column_options
              end #row
            end

            row @data_row_options do 
              if item.respond_to?(attr)
                column item.public_send(attr).delete_newline , @column_options
              else
                raise UnknownDataAttribute, "Unknown attribute (#{attr}) supplied."
              end #if respond
            end #row
          end #table
        end # attributes

        unless item.eql? @items.last
          #put whitespace between separate objects
          table :border => false do
            row do
              column "", @column_options
            end
          end
        end
      end #items

      @output = capture_output
    end
  end
end
