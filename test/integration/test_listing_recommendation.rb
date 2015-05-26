require_relative "../test_helper"


class TestListingRecommendations < Minitest::Test

  def test_listing_no_recommendations
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr manage', 'r+') do |pipe|
      expected_output = main_menu
      pipe.puts "4"
      expected_output << "No recommendations found. Add a recommendation\n"
      expected_output << main_menu
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_listing_multiple_recommendations
    skip
    create_recommendation("A Clash of Kings by GRR Martin\n\n>>>\n\n")
    create_recommendation("Game Of Thrones by GRR Martin\n\n>>>\n\n")
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "4"
      expected_output << "1. A Clash of Kings by GRR Martin\n\n>>>\n\n"
      expected_output << " by\n\n>>>\n\n"
      expected_output << "2. Game Of Thrones by GRR Martin\n\n>>>\n\n"
      expected_output << " by\n\n>>>\n\n"
      expected_output << main_menu
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end
