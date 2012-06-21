# encoding: utf-8
#Main module                                                                                                                                                  
module Tables
  #Helper methods for specs
  module TestingHelper

    # Captures output which is sent to stderr
    #
    # @yield Executes code with changed output 
    # @return [String] returns the captured output
    def capture_stderr(&block)
      previous_stderr, $stderr = $stderr, StringIO.new
      block.call
      return $stderr.string
    ensure
      $stderr = previous_stderr
    end

    # Captures output which is sent to stdout
    #
    # @yield Executes code with changed output 
    # @return [String] returns the captured output
    def capture_stdout(&block)
      previous_stdout, $stdout = $stdout, StringIO.new
      block.call
      return $stdout.string
    ensure
      $stdout = previous_stdout
    end
  end
end 
