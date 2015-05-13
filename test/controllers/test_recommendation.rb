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

    end

  end


end
