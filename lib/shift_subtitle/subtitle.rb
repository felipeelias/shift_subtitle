require 'time'

module ShiftSubtitle
  class Subtitle    
    def self.run!(args)
      @options = ShiftSubtitle::Options.new(args)
      
      input_file  = File.read(@options[:input_file])
      output_file = File.new(@options[:output_file], "w")
      
      operation = case @options[:operation]
        when :add then :+
        else :-
      end
      
      pattern = /^([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}) --> ([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3})/
      
      output_file << input_file.gsub(pattern) do
        time_start, time_end = Time.parse($1), Time.parse($2)
        time_start, time_end = time_start.send(operation, @options[:time]), time_end.send(operation, @options[:time])
        interval(time_start, time_end)
      end
      
      output_file.flush and output_file.close
    end
    
    private
    
      def self.format_time(time)
        usec = time.usec / 1000
        usec = sprintf("%.3d", usec)
        "#{time.strftime('%H:%M:%S')},#{usec}"
      end
    
      def self.interval(time_start, time_end)
        "#{format_time(time_start)} --> #{format_time(time_end)}"
      end
    
  end  
end