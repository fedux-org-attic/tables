# encoding: utf-8

require 'tables/helper'

#main module
module Tables
  #template report
  class BaseTable

    include CommandLineReporter
    
    # create report
    #
    # @param [Array] output the objects to be used to generate the table report
    # @param [Hash] options options for the table to be created
    # @option options [Array] :attributes ([]) attributes which should be part of the table report 
    # @option options [Array] :header ([]) header for the attributes
    # @option options [Array] :table_options ({ border: true }) options for the table 
    # @option options [Array] :data_row_options ({}) options for the data rows
    # @option options [Array] :header_row_options ({ header: true } ) options for the header rows
    # @option options [Array] :column_options ([]) options for the columns 
    #
    # @see https://github.com/wbailey/command_line_reporter Documentation for table_options, row_options, column_options
    def initialize(items, options={})
      @options = {
        attributes: [],
        header: [],
        table_options: {
          border: true ,
          width: :auto,
        },
        data_row_options: {},
        header_row_options: {
          header: true
        },
        column_options: {},
      }.merge options

      @items = items
      @header = @options[:header]
      @attributes = @options[:attributes]
      @table_options = @options[:table_options]
      @header_row_options = @options[:header_row_options]
      @data_row_options = @options[:data_row_options]
      @column_options = @options[:column_options]

      @column_widths = prepare_column_widths(@table_options, @column_options, @options[:column_widths])

      is_table_definition_correct?(@header, @attributes ) unless @header.empty?
    end

    # Check table definition base on given header
    # and attributes
    #
    # @param [Array] header array of items describing the header
    # @param [Array] attributes array of items describing the data attributes
    def is_table_definition_correct?(header,attributes)
      unless header.count == attributes.count
        raise InvalidTableDefinition, "Sorry, count of header columns (#{header.count}) does not match the count of data columns (attributes.count)"
      end
    end
    
    # Calc absolute value based on base value and percentage 
    #
    # @param [Integer] base_value The base value which will be used to calculate the absolute value
    # @param [Integer] percentage The value to use in calculation
    # @return [Integer] base * percentage
    def absolute(base_value, percentage)
      ( base_value * ( percentage.to_f / 100.to_f ) ).truncate
    end #def

    # Prepare width for all columns of a table
    #
    # @param [Hash] table_options The options of the table (but only the width of the table is interesting)
    # @param [Hash] column_options The options for all columns
    # @param [Array] column_widths The userdefined widths for all columns
    def prepare_column_widths(table_options , column_options )

      column_default_width = column_options[:default_width] 
      column_specific_widths = column_options[:widths] 

      case table_options[:width]
      # nil?????
      when nil
        table_width = ENV['COLUMNS'].to_i
      when :auto
        table_width = ENV['COLUMNS'].to_i
        column_default_width = sprintf("%s%%" , 100 / @attributes.count )
      when /(\d+)%/
        table_width = absolute( ENV['COLUMNS'].to_i, $1.to_i )
      when /(\d+)/
        table_width = $1.to_i
      end

      #what about undefined values
      widths = preseed_array( column_default_width, column_specific_widths, @attributes.count )

      widths.collect do |w| 
        if width.to_s =~ /(\d+)%/
          column_width = absolute(ENV['COLUMNS'].to_i, w.to_i)
        else
          column_width = w.to_i
        end
      end
    end

    # preseeds an array base on a default and specific values
    #
    # @param [Arbitrary] default_value Abitrary value used to fill up empty indizes
    # @param [Array] specific_values Specific value to be used in array
    # @param [Integer] count Expected length of array
    # @return [Array] preseeded array
    def preseed_array(default_value, specific_values = [], count)
      specific_value.clean_up + [default_value] * count
    end

    # run report
    #
    # @param [Array] output the objects to be used to generate the table report
    # @param [Hash] options options for the table to be created
    # @option options [Array] :attributes ([ :all ]) attributes which should be part of the table report 
    def self.run(output, options={})
      report = new(output,options)
      report.build
      report.output
    end
  end
end
