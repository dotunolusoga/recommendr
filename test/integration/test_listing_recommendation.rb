require_relative "../test_helper"


class ListingRecommendationsTest < MiniTest::Test

  def test_manage_argument_given
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr manage', 'r+') do |pipe|
      expected_output = <<EOS
1. Add a recommendation
2. List all recommendations
3. Exit
EOS
      pipe.puts "2"
      expected_output << "No recommendations found. Add a recommendation.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end
