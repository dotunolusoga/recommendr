
require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }
ENV["TEST"] = "true"


reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'

class Minitest::Test
  def setup
    Database.load_structure
    Database.execute("DELETE FROM recommendations;")
  end
end

def create_recommendation(title)
  Database.execute("INSERT into recommendations (title) VALUES (?)", title)
end

def main_menu
<<EOS
1. Add a recommendation
2. Edit a recommendation
3. Delete a recommendation
4. List all recommendations
5. Exit
EOS
end
