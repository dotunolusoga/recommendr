
class Recommendation

  attr_accessor :id, :title, :author, :quip, :mood
  attr_reader :errors

  def initialize(title, author, quip, mood)
    self.title = title
    self.author = author
    self.quip = quip
    self.mood = mood
  end

  def ==(other)
    other.is_a?(Recommendation) && other.id == self.id
  end

  def self.all
    Database.execute("select * from recommendations").map do |row|
      populate_from_database(row)
    end
  end

  def self.count
    Database.execute("select count(id) from recommendations")[0][0]
  end

  def self.find(id)
    row = Database.execute("SELECT * FROM recommendations where id = ?", id).first
    if row.nil?
      nil
    else
      populate_from_database(row)
    end
  end

  def valid?
    if title.nil? or title.empty? or /^\d+$/.match(title)
      @errors = "\"#{title}\" is not a valid book title."
      false
    elsif author.nil? or author.empty? or /^\d+$/.match(author)
      @errors = "\"#{author}\" is not a valid book author."
      false
    elsif quip.nil? or quip.empty? or /^\d+$/.match(quip)
      @errors = "\"#{quip}\" is not a valid quip."
      false
    elsif mood.nil? or mood.empty? or /^\d+$/.match(mood)
      @errors = "\"#{mood}\" is not a valid mood."
      false
    else
      @errors = nil
      true
    end
  end

  def save(*args)
    return false unless valid?
    Database.execute("INSERT into recommendations (title, author, quip, mood) VALUES (?, ?, ?, ?)", title, author, quip, mood)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  end

  def self.populate_from_database(row)
    recommendation = Recommendation.new(row['title'], row['author'], row['quip'], row['mood'])
    recommendation.title = row['title']
    recommendation.author = row['author']
    recommendation.quip = row['quip']
    recommendation.mood = row['mood']
    recommendation.instance_variable_set(:@id, row['id'])
    recommendation
  end

  def self.sad_rec
    Database.execute("SELECT * FROM recommendations WHERE mood LIKE 'sa%' ORDER BY RANDOM() LIMIT 1").map do |row|
      populate_from_database(row)
    end
  end

  def self.happy_rec
    Database.execute("SELECT * FROM recommendations WHERE mood LIKE 'ha%' ORDER BY RANDOM() LIMIT 1").map do |row|
      populate_from_database(row)
    end
  end

  def self.neutral_rec
    Database.execute("SELECT * FROM recommendations WHERE mood LIKE 'so%' ORDER BY RANDOM() LIMIT 1").map do |row|
      populate_from_database(row)
    end
  end

  def self.delete(id)
    Database.execute("DELETE FROM recommendations WHERE id=?", id)
  end


end
