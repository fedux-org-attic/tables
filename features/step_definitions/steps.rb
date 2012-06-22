#encoding: utf-8
When /^I view them as a "(.*?)"$/ do |view|
  @options ||= {}

  @captured_output = capture_stdout do
    case view 
    when "horizontal_table"
      horizontal_table @factories, @options
    end
  end
end

Then /^I see the following output:$/ do |string|
  @captured_output.chomp.should == string
end

When /^I define the following options$/ do |table|
  options = {}

  table.rows.each do |row|
    options[row[0].to_sym] ||= {}
    options[row[0].to_sym][row[1].to_sym]= eval(row[2])
  end

  @options = options
end

