require 'command_line_reporter'

require 'tables/version'
require 'tables/base'
require 'tables/helper'
require 'tables/table_definition'
require 'tables/horizontal_table'
require 'tables/detail_table'

# main module
module Tables
  
  # Displays data as a horizontal table
  # 
  # @example
  # 
  def horizontal_table(data=[],options={})
    HorizontalTable.run(data,options)
  end


end
