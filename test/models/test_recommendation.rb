require_relative '../test_helper'

describe Recommendation do
  #Recommendation#all
  describe "#all" do
    describe "if there are no recommendations in the database" do
      it "should return an empty array" do
        assert_equal [], Recommendation.all
      end
    end
  end

    describe "if there are scenarios" do
      before do
        create_recommendation("Bob")
        create_recommendation("Sally")
        create_recommendation("Amanda")
      it "should return an array" do
        assert_equal Array, Recommendation.all.class
      end
      it "should return the recommendations in alphabetic order" do
        expected = ["Amanda", "Bob", "Sally"]
        actual = Recommendation.all.map{ |recommendation| recommendation.title }
        assert_equal expected, actual
       end
      end
    end


    describe "#count" do
      describe "if there are no recommendations in the database" do
        it "should return 0" do
          assert_equal 0, Recommendation.count
        end
      end

      describe "if there are scenarios" do
        before do
          create_recommendation("Bob")
          create_recommendation("Sally")
          create_recommendation("Amanda")
        end
        it "should return the correct count" do
          assert_equal 3, Recommendation.count
        end
      end
    end
  end
