# encoding: utf-8

#main module
module Tables

  #hide the nasty stuff
  #of building a table
  class TableDefinition
    def initialize(items = [])
      @items = items
    end
    
    def attributes
      first_item = @items.first
      instance_vars = first_item.instance_variables
      candidates = instance_vars.map{|variable| variable.to_s.gsub(/@/, '').to_sym}

      method_names = candidates.keep_if {|name| first_item.respond_to?(name) }
    end

  end

end
