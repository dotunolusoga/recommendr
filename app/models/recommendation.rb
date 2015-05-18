
class Recommendation

  attr_accessor :title
  attr_reader :id, :errors

  def initialize(title = nil)
    self.title = title
  end

  def ==(other)
    other.is_a?(Recommendation) && other.id == self.id
  end

  def self.all
    Database.execute("select title from recommendations order by title ASC").map do |row|
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
    else
      @errors = nil
      true
    end
  end

  def save
    return false unless valid?
    Database.execute("INSERT into recommendations (title) VALUES (?)", title)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  end

  private

  def self.populate_from_database(row)
    recommendation = Recommendation.new
    recommendation.title = row['title']
    recommendation.instance_variable_set(:@id, row['id'])
    recommendation
  end


end
