require 'rails_helper'

RSpec.describe Review, type: :model do

    User.all.each do |user|
        user.destroy
    end

    Recipe.all.each do |recipe|
        recipe.destroy
    end
  
    fixtures :all

    describe "Create a Review without a rating" do
        it "shouldn't be allowed" do
          review = Review.create(user_id: User.first.id,
                        recipe_id: Recipe.first.id,
                        description: 'Very good!')
          expect(review).to_not be_valid
        end
    end

    describe "Create a Review without description" do
        it "shouldn't be allowed" do
          review = Review.create(user_id: User.first.id,
                        recipe_id: Recipe.first.id,
                        rating: '1')
          expect(review).to_not be_valid
        end
    end

    describe "Create a Review with an incorrect rating" do
        it "shouldn't be allowed" do
          review = Review.create(user_id: User.first.id,
                        recipe_id: Recipe.first.id,
                        rating: '6',
                        description: 'Very good!')
          expect(review).to_not be_valid
        end
    end

    describe "Create a Review with valid data" do
        it "should be allowed" do
          review = Review.create(user_id: User.first.id,
                            recipe_id: Recipe.first.id,
                            rating: '5',
                            description: 'Very good!')
          expect(review).to be_valid
        end
    end

    describe "Associations" do
        it "belongs to user" do
            assc = described_class.reflect_on_association(:user)
            expect(assc.macro).to eq :belongs_to
        end
    end

    describe "Associations" do
        it "belongs to recipe" do
            assc = described_class.reflect_on_association(:recipe)
            expect(assc.macro).to eq :belongs_to
        end
    end

end