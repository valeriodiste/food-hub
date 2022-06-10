require 'rails_helper'

RSpec.describe Review, type: :model do

    describe "Create a Review without a rating" do
        it "shouldn't be allowed" do
          review = Review.create(description: 'Very good!')
          expect(review).to_not be_valid
        end
    end

    describe "Create a Review without description" do
        it "shouldn't be allowed" do
          review = Review.create(rating: '1')
          expect(review).to_not be_valid
        end
    end

    describe "Create a Review with an incorrect rating" do
        it "shouldn't be allowed" do
          review = Review.create(rating: '6',
                            description: 'Very good!')
          expect(review).to_not be_valid
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