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
      "\"#{title}\" has been added\n"
    else
      recommendation.errors
    end
  end

  def add_prompt
    title = ask("What recommendation would you like to add?")
    while title.nil? or title.empty?
      puts "'#{title}' is not a valid book title"
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
    recommendation = Recommendation.sad_rec
    recommendation.each do |recommendation|
      res << "#{recommendation.title} by #{recommendation.author}\n\n"
      res << ">>> #{recommendation.quip}\n\n"
    end
    say(res)
  end

  def happy_result
    res = ''
    recommendation = Recommendation.happy_rec
    recommendation.each do |recommendation|
      res << "#{recommendation.title} by #{recommendation.author}\n\n"
      res << ">>> #{recommendation.quip}\n\n"
    end
    say(res)
  end

  def neutral_result
    res = ''
    recommendation = Recommendation.neutral_rec
    recommendation.each do |recommendation|
      res << "#{recommendation.title} by #{recommendation.author}\n\n"
      res << ">>> #{recommendation.quip}\n\n"
    end
    say(res)
  end

  def edit_rec
    recommendations = Recommendation.all
    recommendation_controller = RecommendationsController.new
    say("Which recommendation fails to meet your exacting standards 'Oh Great & Powerful One'?\n\n")
    say(recommendation_controller.index)
    rec_edit = ask('')
    while rec_edit.to_i < 1 or rec_edit.empty? or rec_edit.nil?
      puts "'#{rec_edit}' is not a valid input"
      say("Which recommendation fails to meet your exacting standards 'Oh Great & Powerful One'?\n\n")
      say(recommendations_controller.index)
      rec_edit = ask('')
    end
    rec_edit = rec_edit.to_i - 1
    recommendation = recommendations[rec_edit]
    edit_options = ask("What do you want to edit: Title, Author, Quip or Mood?")
    if edit_options.downcase == 'title'
      recommendation.title = ask("What is the new Title?")
      while recommendation.title.empty?
        puts "'#{recommendation.title}' is not a valid input"
        recommendation.title = ask("What is the new Title?")
      end
    elsif edit_options.downcase == 'author'
      recommendation.author = ask("Who is the new Author?")
      while recommendation.author.empty?
        puts "'#{recommendation.author}' is not a valid input"
        recommendation.author = ask("Who is the new Author?")
      end
    elsif edit_options.downcase == 'quip'
      recommendation.quip = ask("What is the new Quip for this recommendation, remember to match the mood you're going for?")
      while recommendation.author.empty?
        puts "'#{recommendation.quip}' is not a valid input"
        recommendation.quip = ask("What is the new Quip for this recommendation, remember to match the mood you're going for?")
      end
    elsif edit_options.downcase == 'mood'
      recommendation.mood = ask("What Mood are you going for?")
      while recommendation.mood.empty?
        puts "'#{recommendation.mood}' is not a valid input"
        recommendation.mood = ask("What Mood are you going for?")
      end
    end
    if recommendaton.save
      say("'#{old_rec} has been updated")
      return
    else
      say(recommendation.errors)
    end
  end

  def delete_rec
    recommendations = Recommendation.all
    self.index
    delete_id = ask("Which recommendation fails to meet your exacting standards 'Oh Great & Powerful One'?\n\n")
    delete_id = delete_id.to_i - 1
    old_rec = "#{recommendations.title}"
    recommendation = recommendations[delete_id]
    Recommendation.delete(recommendation.id)
    say("#{old_rec} has been deleted")
  end

end
