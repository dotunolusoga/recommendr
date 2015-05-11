require_relative "../test_helper"


class EditingRecommendationTest < MiniTest::Test

  def test_editing_happy_path
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr manage', 'r+') do |pipe|
      expected_output = <<EOS
1. Add a recommendation
2. Edit a recommendation
3. Delete a recommendation
4. List all recommendations
5. Exit
EOS
      pipe.puts "2"
      expected_output << "Which recommendation fails to meet your exacting standards 'Oh Great & Powerful One'?\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end
