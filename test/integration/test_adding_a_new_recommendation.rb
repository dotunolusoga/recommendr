require_relative "../test_helper"

### Adding a recommendation

#Usage example:
#{}```
#> ./recommendr manage
#1. Add a recommendation
#2. List all recommendations
#3. Exit
#{}```
#> 1

#What is the book title?

#> To the Hilt

#Who is the author?

#> Dick Francis

#```
#"To The Hilt by Dick Francis" has been added to recommendations
#1. Add a recommendation
#2. List all recommendations
#3. Exit
#```
#Acceptance Criteria:

#* The program prints out confirmation that the new recommendation has been added
#* The new recommendation is added to the database
#* After the addition the user is taken back to the main manage menu

class AddingANewRecommendationTest < MiniTest::Test

  def test_adding_a_single_recommendation
    shell_output = ""
    expected_output = ""
    test_rec = "A Song of Ice and Fire"
    IO.popen('./recommendr manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "1"
      expected_output << "What recommendation would you like to add?\n"
      pipe.puts test_rec
      expected_output << "Who is the author of this book?\n"
      pipe.puts "George R. R. Martin"
      expected_output << "What quip goes with this recommendation?\n"
      pipe.puts "I am the god of tits and wine"
      expected_output << "What mood should this address?(Sad/Happy)\n"
      pipe.puts "Happy"
      expected_output << "\"#{test_rec}\" has been added\n"
      expected_output << main_menu
      pipe.puts "5"
      expected_output << "You have successfully exited the management menu.\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

end
