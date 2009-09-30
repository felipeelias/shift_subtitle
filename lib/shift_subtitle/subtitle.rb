require "time"

class Time
  def print_time
    "#{self.strftime('%H:%M:%S')},#{self.usec / 1000}"
  end
end

module ShiftSubtitle
  class Subtitle
    attr_reader :subtitle_path, :output_path, :operation, :shift
    
    def initialize(subtitle_path, output_path, shift, operation = :+)
      @subtitle_path, @output_path, @shift, @operation = subtitle_path, output_path, shift, operation
    end
    
    def convert!
      input_file  = File.read(subtitle_path)
      output_file = File.new(output_path, "w")
      
      output_file << input_file.gsub(/^([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}) --> ([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3})\s$/) do
        time_start, time_end = Time.parse($1), Time.parse($2)
        time_start, time_end = time_start.send(operation, shift), time_end.send(operation, shift)
        "#{time_start.print_time} --> #{time_end.print_time}"
      end
      
      output_file.flush and output_file.close
    end      
  end  
end

shift_time = 1.100

input   = File.join(File.dirname(__FILE__), "subtitle.srt")
output  = File.join(File.dirname(__FILE__), "subtitle_output.srt")

ShiftSubtitle::Subtitle.new(input, output, shift_time, :-).convert!