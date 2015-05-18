require_relative "../test_helper"


class EditingRecommendationTest < MiniTest::Test

  def test_editing_happy_path
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr manage', 'r+') do |pipe|
      expected_output = main_menu
      pipe.puts "2"
      expected_output << "Which recommendation fails to meet your exacting standards 'Oh Great & Powerful One'?\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_editing_sad_path
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr manage', 'r+') do |pipe|
      expected_output = main_menu
      pipe.puts "2"
      expected_output << "Which recommendation fails to meet your exacting standards 'Oh Great & Powerful One'?\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end
