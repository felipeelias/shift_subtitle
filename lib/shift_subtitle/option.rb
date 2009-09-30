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