require_relative '../test_helper'

class BasicUsageTest < MiniTest::Test

  def test_minimum_arguments_required
    skip
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr') do |pipe|
      expected_output << "Can we make a recommendation for you today?(y/n)\n"
      pipe.puts << 'n'
      expected_output << 'Really dude? You\'re actually not going to read a book? I\'m so done with you'
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_wrong_argument_given
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr blah') do |pipe|
      expected_output = "[Help] Run as: ./recommendr manage\n"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_manage_multiple_arguments_given
    shell_output = ""
    expected_output = ""
    IO.popen('./recommendr manage blah') do |pipe|
      expected_output = "[Help] Run as: ./recommendr manage\n"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_manage_argument_given_then_exit
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
      pipe.puts "5"
      expected_output << "You have successfully exited the management menu.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end


end
