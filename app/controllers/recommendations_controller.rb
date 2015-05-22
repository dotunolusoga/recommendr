require 'highline/import'

class RecommendationsController

  def index
    if Recommendation.count > 0
      recommendation = Recommendation.all
      rec_string = ''
      recommendation.each_with_index do |recommendation, index|
        rec_string << "#{index + 1}. #{recommendation.title} by #{recommendation.author}\n\n"
        rec_string << ">>> #{recommendation.quip}\n\n"
      end
      say (rec_string)
    else
      say ("No recommendations found. Add a recommendation")
    end
  end

  def add(title, author, quip, mood)
    title_set = title.strip
    author_set = author.strip
    recommendation = Recommendation.new(title_set, author_set, quip, mood)
    if recommendation.save(title, author, quip, mood)
      "\n\"#{title}\" has been added\n\n"
    else
      recommendation.errors
    end
  end

  def add_prompt
    title = ask("What recommendation would you like to add?")
    while title.nil? or title.empty?
      puts "'#{title}' is not an acceptable book title"
      title = ask("What recommendation would you like to add?")
    end
    author = ask("Who is the author of this book?")
    while author.nil? or author.empty?
      puts "'#{author}' is not an acceptable book author"
      title = ask("Who is the author of this book?")
    end
    quip = ask("What quip goes with this recommendation?")
    while author.nil? or author.empty?
      puts "'#{quip}' is NOT a quip"
      title = ask("What quip goes with this recommendation?")
    end
    mood = ask("What mood should this address?(Sad/Happy)")
    while mood.nil? or mood.empty?
      puts "You CAN read? Right?"
      title = ask("What mood should this address?(Sad/Happy)")
    end
    response = add(title, author, quip, mood)
    say(response) unless response.nil?
    if /has\sbeen\sadded.$/.match(response)
      exit
    end
  end

  def sad_result
    res = ''
    recommendation = Recommendation.sad_rec.shuffle
    recommendation.each do |recommendation|
      res << "#{recommendation.title} by #{recommendation.author}\n\n"
      res << ">>> #{recommendation.quip}\n\n"
    end
    say(res)
  end

  def happy_result
    res = ''
    recommendation = Recommendation.happy_rec.shuffle
    recommendation.each do |recommendation|
      res << "#{recommendation.title} by #{recommendation.author}\n\n"
      res << ">>> #{recommendation.quip}\n\n"
    end
    say(res)
  end

  def neutral_result
    res = ''
    recommendation = Recommendation.neutral_rec.shuffle
    recommendation.each do |recommendation|
      res << "#{recommendation.title} by #{recommendation.author}\n\n"
      res << ">>> #{recommendation.quip}\n\n"
    end
    say(res)
  end

  def delete
    recommendations = Recommendation.all
    self.index
    delete_id = ask("Which recommendation fails to meet your exacting standards 'Oh Great & Powerful One'?\n\n")
    delete_id = delete_id.to_i - 1
    recommendation = recommendations[delete_id]
    if recommmendation.nil? or recommendation.empty? #or recommendation > recommendations.length
      "Invalid recommendation"
    else
      Recommendation.delete(recommendation.id)
      "#{recommendation.title} has been deleted"
      return
    end
  end

end
