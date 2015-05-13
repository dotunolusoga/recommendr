
class Recommendation

  attr_accessor :title

  def self.all
    Database.execute("select title from recommendations order by title ASC").map do |row|
      recommendation = Recommendation.new
      recommendation.title = row[0]
      recommendation
    end
  end

  def self.count
    Database.execute("select count(id) from recommendations")[0][0]
  end

end
