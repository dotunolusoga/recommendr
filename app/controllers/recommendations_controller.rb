class RecommendationsController

  def index
    if Recommendation.count > 0
      recommendation = Recommendation.all
      recommendation.each_with_index do |recommendation, index|
        say("#{index + 1}. #{recommendation.title}")
      end
    else
      say("No recommendations found. Add a recommendation")
    end
  end
  
end
