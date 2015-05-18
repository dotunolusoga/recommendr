require_relative '../test_helper'

describe Recommendation do
  describe "#all" do
    describe "if there are no recommendations in the database" do
      it "should return an empty array" do
        assert_equal [], Recommendation.all
      end
    end

    describe "if there are scenarios" do
      before do
        create_recommendation("Bob")
        create_recommendation("Sally")
        create_recommendation("Amanda")
      end
      it "should return an array" do
        assert_equal Array, Recommendation.all.class
      end
      it "should return the recommendations in alphabetic order" do
        expected = ["Amanda", "Bob", "Sally"]
        actual = Recommendation.all.map{ |recommendation| recommendation.title }
        assert_equal expected, actual
       end
      it 'populates the returned recommendations id' do
        expected_ids = Database.execute("SELECT id FROM recommendations ORDER BY title ASC").map{ |row| row['id'] }
        actual_ids = Recommendation.all.map{ |recommendation| recommendation.id }
        assert_equal expected_ids, actual_ids
      end
    end
  end

  describe "#find" do
    let(:recommendation){ Recommendation.new("The Metamorphosis")}
    before do
      recommendation.save
    end
    describe "if there isn't a matching recommendation in the database" do
      it "should return nil" do
        assert_equal nil, Recommendation.find(14)
      end
    end
    describe "if there is a matching recommendation in the database" do
      it "should return the recommendation, populated with id and title" do
        actual = Recommendation.find(recommendation.id)
        assert_equal recommendation.id, actual.id
        assert_equal recommendation.title, actual.title
      end
    end
  end

  describe "equality" do
    describe "when the recommendation ids are not the same" do
      it "is true" do
        rec1 = Recommendation.new("foo")
        rec1.save
        rec2 = Recommendation.new("foo")
        rec2.save
        assert rec1 != rec2
      end
    end
    describe "when the recommendation ids are the same" do
      it "is true" do
        rec1 = Recommendation.new("foo")
        rec1.save
        rec2 = Recommendation.all.first
        assert_equal rec1, rec2
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

    describe '.initialize' do
      it 'sets the title attribute' do
        recommendation = Recommendation.new('foo')
        assert_equal 'foo', recommendation.title
      end
    end

    describe '.save' do
      describe "if the model is valid" do
        let(:recommendation) {Recommendation.new("A Song of Ice and Fire") }
        it "should return true" do
          assert recommendation.save
        end
        it "should save the model to the database" do
          recommendation.save
          assert_equal 1, Recommendation.count
          last_row = Database.execute("SELECT * FROM recommendations")[0]
          database_name = last_row['title']
          assert_equal "A Song of Ice and Fire", database_name
        end
        it "should populate the model with the id from the database" do
          recommendation.save
          last_row = Database.execute("SELECT * FROM recommendations")[0]
          database_id = last_row['id']
          assert_equal database_id, recommendation.id
        end
      end

      describe "if the model is invalid" do
        let(:recommendation) {Recommendation.new("")}
        it "should return false" do
          refute recommendation.save
        end
        it "should not save the model to the database" do
          recommendation.save
          assert_equal 0, Recommendation.count
        end
        it "should populate the error messages" do
          recommendation.save
          assert_equal "\"\" is not a valid book title.", recommendation.errors
        end
      end
    end

    describe '.valid?' do
      describe 'with valid data' do
        let(:recommendation) { Recommendation.new("Valar Moghulis") }
        it 'return true' do
          assert recommendation.valid?
        end
        it 'should set errors to nil' do
          recommendation.valid?
          assert recommendation.errors.nil?
        end
      end

      describe 'with no name' do
        let(:recommendation){ Recommendation.new(nil) }
        it 'returns false' do
          refute recommendation.valid?
        end
        it 'sets the error message' do
          recommendation.valid?
          assert_equal "\"\" is not a valid book title.", recommendation.errors
        end
      end

      describe 'with empty name' do
        let(:recommendation) {Recommendation.new("") }
        it 'returns false' do
          refute recommendation.valid?
        end
        it 'sets the error mesage' do
          recommendation.valid?
          assert_equal "\"\" is not a valid book title.", recommendation.errors
        end
      end

      describe 'with a title with no letter characters' do
        let(:recommendation) { Recommendation.new('777')}
        it 'returns false' do
          refute recommendation.valid?
        end
        it 'sets the error mesage' do
          recommendation.valid?
          assert_equal "\"777\" is not a valid book title.", recommendation.errors
        end
      end

      describe 'with a previously invalid name' do
        let(:recommendation) { Recommendation.new('555')}
        before do
          refute recommendation.valid?
          recommendation.title = 'Mockingbird'
          assert_equal 'Mockingbird', recommendation.title
        end
        it 'should return true' do
          assert recommendation.valid?
        end
        it 'sets the error mesage' do
          recommendation.valid?
          assert_nil recommendation.errors
        end
      end
    end
  end
