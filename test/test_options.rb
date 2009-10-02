require "test_helper"

class TestOptions < Test::Unit::TestCase
  def setup
    @files_args = ["shift_subtitle.srt", "shift_subtitle_output.srt"]
    @default_options = {
      :input_file => "shift_subtitle.srt",
      :output_file => "shift_subtitle_output.srt",
      :operation => :add,
      :time => 0
    }
  end
  
  def test_default_args
    @options = ShiftSubtitle::Options.new(@files_args)
    assert_equal(@default_options, @options)
  end
  
  def test_operation_args
    @options = ShiftSubtitle::Options.new(["-o", "add"] + @files_args)
    assert_equal(@default_options.merge({ :operation => :add }), @options.merge({ :operation => :add }))
    
    @options = ShiftSubtitle::Options.new(["-o", "sub"] + @files_args)
    assert_equal(@default_options.merge({ :operation => :sub }), @options.merge({ :operation => :sub }))
  end

  def test_time_args
    @options = ShiftSubtitle::Options.new(["-t", "1.200"] + @files_args)
    assert_equal(@default_options.merge({ :time => 1.200 }), @options.merge({ :time => 1.200 }))
  end
  
  def test_invalid_operation_args_values
    assert_raise OptionParser::InvalidOption do 
      ShiftSubtitle::Options.new(["-o", "x"] + @files_args)
    end
  end

  def test_invalid_time_args_values
    assert_raise OptionParser::InvalidOption do 
      ShiftSubtitle::Options.new(["-t", "bla"] + @files_args)
    end
  end
  
end