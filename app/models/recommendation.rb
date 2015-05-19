
class Recommendation

  attr_accessor :title
  attr_reader :id, :errors, :author, :quip, :source, :mood

  def initialize(title = nil, author = nil)
    self.title = title
    self.author = author
    self.quip = quip
    self.source = source
    self.mood = mood
  end

  def ==(other)
    other.is_a?(Recommendation) && other.id == self.id
  end

  def self.all
    Database.execute("select * from recommendations order by title ASC").map do |row|
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
      @errors = "\"#{quip=()}\" is not a valid quip."
      false
    elsif source.nil? or source.empty? or /^\d+$/.match(source)
      @errors = "\"#{source}\" is not a valid source."
      false
    elsif mood.nil? or mood.empty? or /^\d+$/.match(mood)
      @errors = "\"#{mood}\" is not a valid mood."
      false
    else
      @errors = nil
      true
    end
  end

  def save
    return false unless valid?
    Database.execute("INSERT into recommendations (title, author, quip, source, mood) VALUES (?, ?, ?, ?, ?)", title, author, quip, source, mood)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  end

  private

  def self.populate_from_database(row)
    recommendation = Recommendation.new
    recommendation.title = row['title']
    recommendation.author = row['author']
    recommendation.quip = row['quip']
    recommendation.source = row['source']
    recommendation.mood = row['mood']
    recommendation.instance_variable_set(:@id, row['id'])
    recommendation
  end


end
