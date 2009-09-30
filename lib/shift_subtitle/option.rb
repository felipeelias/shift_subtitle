# testing options
# http://github.com/technicalpickles/jeweler/blob/52d3b1e04d0d646006f1f188ac4bba3709327599/test/test_options.rb
# options model
# http://github.com/technicalpickles/jeweler/blob/1cb83013d77c27c47e17da0202bacced6e468101/lib/jeweler/generator/options.rb
require 'optparse'

module ShiftSubtitle
  class Option
    OPERATIONS = %w(add sub)
    attr_accessor :options
  
    def initialize()
      @options = {
        :operation => :add,
        :time => 0
      }
    end
  
    def parser
      options[:input_file] = ARGV[-2]
      options[:output_file] = ARGV[-1]
    
      OptionParser.new do |opts|
        opts.banner = "Usage: shift [options] input_file output_file"
      
        opts.separator ""
        opts.separator "Some options"
      
        opts.on("-o", "--operation [OPERATION]", OPERATIONS, "Add or subtract time. Use 'add' or 'sub'") do |v|
          options[:operation] = v
        end

        opts.on("-t", "--time [TIME]", Float, "Time to shift the subtitle") do |v|
          options[:time] = v
        end
      end
    end
    
    def run!(args)
      opts = parser
      opts.parse!(args)
      options
    rescue => e
      puts e
      puts opts
      raise SystemExit
    end
  
  end
end
options = ShiftSubtitle::Option.new.run!(ARGV)

puts options.inspect