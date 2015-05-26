require_relative "../test_helper"

describe RecommendationsController do

  describe '.index' do
    let(:controller) {RecommendationsController.new}

    it 'should say no recommendations found when empty' do
      actual_output = controller.index
      expected_output = "No recommendations found. Add a recommendation"
      assert_equal expected_output, actual_output
    end

  end

  describe '.add' do
    let(:controller) {RecommendationsController.new}

    it "should add a recommendation to database" do
      controller.add('A Song of Ice and Fire')
      assert_equal 1, Recommendation.count
    end

    it "should not add a recommendation with all spaces" do
      rec_name = "     "
      res = controller.add(rec_name)
      assert_equal "\"\" is not a valid book title.", res
    end

    it "should only add recommendations that make sense" do
      rec_name = "777777"
      controller.add(rec_name)
      assert_equal 0, Recommendation.count
    end

  end

end
