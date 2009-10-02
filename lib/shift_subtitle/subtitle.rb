require 'time'

class Time
  def print_time
    "#{self.strftime('%H:%M:%S')},#{self.usec / 1000}"
  end
end

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
      
      puts @options.inspect
      
      output_file << input_file.gsub(/^([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}) --> ([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3})/) do
        time_start, time_end = Time.parse($1), Time.parse($2)
        time_start, time_end = time_start.send(operation, @options[:time]), time_end.send(operation, @options[:time])
        "#{time_start.print_time} --> #{time_end.print_time}"
      end
      
      output_file.flush and output_file.close
    end      
  end  
end