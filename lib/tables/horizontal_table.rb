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
    # @option options [Array] :attributes ([]) attributes which should be part of the table report 
    # @option options [Array] :header ([]) header for the attributes
    # @option options [Array] :table_options ({ border: true }) options for the table 
    # @option options [Array] :data_row_options ({}) options for the data rows
    # @option options [Array] :header_row_options ({ header: true } ) options for the header rows
    # @option options [Array] :column_options ([]) options for the columns 
    #
    # @see https://github.com/wbailey/command_line_reporter Documentation for table_options, row_options, column_options
    def initialize(output, options={})
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
        column_widths: [],
      }.merge options

      header = @options[:header]
      attributes = @options[:attributes]
      table_options = @options[:table_options]
      header_row_options = @options[:header_row_options]
      data_row_options = @options[:data_row_options]
      column_options = @options[:column_options]
      column_widths = @options[:column_widths]

      suppress_output

      table table_options do

        #header
        if header.count > 0 
          check_table_definition? header, attributes

          row header_row_options do
            header.each do |head|
              column_options[:width] =  column_widths.go_over if column_widths.count > 0
              column head, column_options
            end #headers
          end #row
        end #if header

        #data rows
        output.each do |out|
          row data_row_options do
            attributes.each do |attr|
              if out.respond_to?(attr)
                if column_widths.count > 0
                  #weiter -> loesung finden fuer problem mit zu kurzen titeln (array zu klein)
                  column_options[:width] =  calc_relative_column_width(column_widths.go_over) 
                else
                  column_options[:width] = table_options[:width]
                end

                column out.public_send(attr).delete_newline , column_options
              else
                raise UnknownDataAttribute, "Unknown attribute (#{attr}) supplied."
              end #if respond

            end # attributes
          end #row
        end # each data object
      end #table

      @output = capture_output
    end
  end
end
