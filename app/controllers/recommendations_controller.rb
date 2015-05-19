require 'highline/import'

class RecommendationsController

  def index
    if Recommendation.count > 0
      recommendation = Recommendation.all
      rec_string = ''
      recommendation.each_with_index do |recommendation, index|
        rec_string << "#{index + 1}. #{recommendation.title} written by #{recommendation.author}\n"
      end
      rec_string
    else
      "No recommendations found. Add a recommendation"
    end
  end

  def add(title, author, quip, source, mood)
    title_set = title.strip
    author_set = author.strip
    recommendation = Recommendation.new(title_set, author_set, quip, source, mood)
    if recommendation.save
      "\"#{title}\" has been added\n"
    else
      recommendation.errors
    end
  end

  def add_details
    loop do
      book_title = ask("What recommendation would you like to add?")
      book_author = ask("Who is the author of this book?")
      rec_quip = ask("What quip goes with this recommendation?")
      rec_source = ask("And the source of this quip?")
      rec_mood = ask("What mood should this address?(Sad/Happy)")
      response = recommendation_controller.add(book_title, book_author, rec_quip, rec_source, rec_mood)
      say(response) unless response.nil?
      if /has\sbeen\sadded$/.match(response)
        break
      end
    end
  end

end
