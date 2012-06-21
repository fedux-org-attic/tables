#encoding: utf-8
When /^I view them as a "(.*?)"$/ do |view|
  @captured_output = capture_stdout do
    case view 
    when "horizontal_table"
      horizontal_table @factories
    end
  end
end

Then /^I see the following output:$/ do |string|
  @captured_output.should == string
end
