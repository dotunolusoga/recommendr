require_relative "../test_helper"


class TestListingRecommendations < Minitest::Test

  def test_listing_no_recommendations
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr manage', 'r+') do |pipe|
      expected_output = main_menu
      pipe.puts "4"
      expected_output << "No recommendations found. Add a recommendation\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_listing_multiple_recommendations
    create_recommendation("A Clash of Kings")
    create_recommendation("Game Of Thrones")
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "4"
      expected_output << "1. A Clash of Kings\n"
      expected_output << "2. Game Of Thrones\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end
