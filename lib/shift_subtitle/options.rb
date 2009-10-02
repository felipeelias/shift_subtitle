require 'optparse'

module ShiftSubtitle
  class Options < Hash
    OPERATIONS = %w(add sub)
    attr_reader :opts
  
    def initialize(args)
      super()
      
      self[:input_file] = args[-2]
      self[:output_file] = args[-1]
      self[:operation] = :add
      self[:time] = 0
      
      @opts = OptionParser.new do |opts|
        opts.banner = "Usage: shift [OPTIONS] input_file output_file"
      
        opts.separator ""
        opts.separator "Some options"
      
        opts.on("-o", "--operation [OPERATION]", OPERATIONS, "Add or subtract time. Use 'add' or 'sub'") do |v|
          raise OptionParser::InvalidOption unless OPERATIONS.include? v
          self[:operation] = v.to_sym
        end

        opts.on("-t", "--time [TIME]", Float, "Time to shift the subtitle") do |v|
          raise OptionParser::InvalidOption if v.nil?
          self[:time] = v
        end
      end
      
      begin
        @opts.parse!(args)
      rescue OptionParser::InvalidOption => e
        raise e
      end
    end
     
  end
end