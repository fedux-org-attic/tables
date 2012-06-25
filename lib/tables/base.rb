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
        table: {
          attributes: [],
          header: [],
          border: true ,
          width: :auto,
          column_widths: [],
        },
        data_row: {},
        header_row: {
          header: true
        },
        column: {},
        return_as_string: false,
      }.rmerge options

      @items = items
      avail_attr = determine_available_attributes(@items.first)
      @attributes = filter_attributes(avail_attr, @options[:table][:attributes])

      @options = filter_options(@options)

      @header = @options[:header]
#      @attributes = @options[:attributes]
      @table_options = @options[:table]
      @header_row_options = @options[:header_row]
      @data_row_options = @options[:data_row]
      @column_options = @options[:column]
      @return_as_string = @options[:return_as_string]

      #@column_widths = prepare_column_widths(@table_options, @column_options, @options[:column_widths])

      #is_table_definition_correct?(@header, @attributes ) unless @header.empty?
    end

    # Filters out options which cannot be
    # used with command_line_reporter
    #
    # @param [Array] set_options the options which have been set
    # @return [Array] modified option array (filtered)
    def filter_options(set_options)
      options_which_should_be_filtered = {
        #element #allowed options
        table:   [ :border, :width ],
      }

      options_which_should_be_filtered.keys.each do |element|
        set_options[element].keep_if do |option| 
          options_which_should_be_filtered[element].include?(option) 
        end
      end

      set_options
    end

    # Get all attributes for an object
    # based on (available instance vars & available attr_accessors)
    #
    # @param [Object] item Object which should be inspected
    # @return [Array] the methods found
    def determine_available_attributes(item) 
      instance_vars = item.instance_variables
      candidates = instance_vars.map{|variable| variable.to_s.gsub(/@/, '').to_sym}

      method_names = candidates.keep_if {|name| item.respond_to?(name) }
    end

    # Get all attributes based on filter
    #
    # @param [Array] available_attributes list of available attributes
    # @param [Array] wished_attributes list of attributes which should be displayed
    # @return [Array] filtered list of attributes
    def filter_attributes(available_attributes, wished_attributes)
      unless wished_attributes.empty?
        available_attributes.keep_if { |attr| wished_attributes.include? attr }
      end


      available_attributes
    end


#    # Check table definition base on given header
#    # and attributes
#    #
#    # @param [Array] header array of items describing the header
#    # @param [Array] attributes array of items describing the data attributes
#    def is_table_definition_correct?(header,attributes)
#      unless header.count == attributes.count
#        raise InvalidTableDefinition, "Sorry, count of header columns (#{header.count}) does not match the count of data columns (attributes.count)"
#      end
#    end
#    
#    # Calc absolute value based on base value and percentage 
#    #
#    # @param [Integer] base_value The base value which will be used to calculate the absolute value
#    # @param [Integer] percentage The value to use in calculation
#    # @return [Integer] base * percentage
#    def absolute(base_value, percentage)
#      ( base_value * ( percentage.to_f / 100.to_f ) ).truncate
#    end #def
#
#    # Prepare width for all columns of a table
#    #
#    # @param [Hash] table_options The options of the table (but only the width of the table is interesting)
#    # @param [Hash] column_options The options for all columns
#    # @param [Array] column_widths The userdefined widths for all columns
#    def prepare_column_widths(table_options , column_options )
#
#      column_default_width = column_options[:default_width] 
#      column_specific_widths = column_options[:widths] 
#
#      case table_options[:width]
#      # nil?????
#      when nil
#        table_width = ENV['COLUMNS'].to_i
#      when :auto
#        table_width = ENV['COLUMNS'].to_i
#        column_default_width = sprintf("%s%%" , 100 / @attributes.count )
#      when /(\d+)%/
#        table_width = absolute( ENV['COLUMNS'].to_i, $1.to_i )
#      when /(\d+)/
#        table_width = $1.to_i
#      end
#
#      #what about undefined values
#      widths = preseed_array( column_default_width, column_specific_widths, @attributes.count )
#
#      widths.collect do |w| 
#        if width.to_s =~ /(\d+)%/
#          column_width = absolute(ENV['COLUMNS'].to_i, w.to_i)
#        else
#          column_width = w.to_i
#        end
#      end
#    end
#
#    # preseeds an array base on a default and specific values
#    #
#    # @param [Arbitrary] default_value Abitrary value used to fill up empty indizes
#    # @param [Array] specific_values Specific value to be used in array
#    # @param [Integer] count Expected length of array
#    # @return [Array] preseeded array
#    def preseed_array(default_value, specific_values = [], count)
#      specific_value.clean_up + [default_value] * count
#    end

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
