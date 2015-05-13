require 'highline/import'

class RecommendationsController

  def index
    if Recommendation.count > 0
      recommendation = Recommendation.all
      rec_string = ''
      recommendation.each_with_index do |recommendation, index|
        rec_string << "#{index + 1}. #{recommendation.title}\n"
      end
      rec_string
    else
      "No recommendations found. Add a recommendation"
    end
  end

end
