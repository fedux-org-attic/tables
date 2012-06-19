# array class
class Array

  # Clean up array
  #
  # @return [Array] Remove nil or ''-items from self
  def clean_up
    self.delete_if { |item| item.nil? or item == '' }
  end 
end
