require_relative "../test_helper"


class EditingRecommendationTest < MiniTest::Test

  def test_user_left_recommendation_unchanged
    skip
    shell_output = ""
    expected_output = main_menu
    test_rec = 'A Song of Ice & Fire'
    IO.popen('./recommendr manage', 'r+') do |pipe|
      pipe.puts "1"
      expected_output << "What recommendation would you like to add?\n"
      pipe.puts test_rec
      expected_output << "\"#{test_rec}\" has been added\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "Which recommendation fails to meet your exacting standards 'Oh Great & Powerful One'?\n"
      expected_output << "1. #{test_rec}\n"
      pipe.puts test_rec
      expected_output << "\"#{test_rec}\" has been edited\n"
      expected_output << main_menu
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

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
