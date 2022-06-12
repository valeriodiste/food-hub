require 'rails_helper'

RSpec.describe Recipe, type: :model do

    User.all.each do |user|
      user.destroy
    end

    fixtures :users

    describe "Create a Recipe without a title" do
        it "shouldn't be allowed" do
          recipe = Recipe.create(user_id: User.first.id,
                        description: 'Prepared in 1 hour',
                        typology: 'Main Course')
          expect(recipe).to_not be_valid
        end
    end

    describe "Create a Recipe without Typology" do
        it "shouldn't be allowed" do
          recipe = Recipe.create(user_id: User.first.id,
                        title: 'Pizza',
                        description: 'Prepared in 1 hour')
          expect(recipe).to_not be_valid
        end
    end

    describe "Create a Recipe without a description" do
        it "shouldn't be allowed" do
          recipe = Recipe.create(user_id: User.first.id,
                        title: 'Pizza',
                        typology: 'Main Course')
          expect(recipe).to_not be_valid
        end
    end

    describe "Create a Recipe with a wrong typology" do
        it "shouldn't be allowed" do
          recipe = Recipe.create(user_id: User.first.id,
                            title: 'Pizza',
                            typology: 'Undefined',
                            description: 'Prepared in 1 hour')
          expect(recipe).to_not be_valid
        end
    end

    describe "Create a Recipe with a title that doesn't respect the format" do
        it "shouldn't be allowed" do
          recipe = Recipe.create(user_id: User.first.id,
                            title: '1234 @ ?!',
                            typology: 'Main Course',
                            description: 'Prepared in 1 hour')
          expect(recipe).to_not be_valid
        end
    end

    describe "Create a Recipe with valid data" do
      it "should be allowed" do
        recipe = Recipe.create(user_id: User.first.id,
                          title: 'Pizza',
                          description: 'Prepared in 1 hour',
                          typology: 'Main Course')
        expect(recipe).to be_valid
      end
    end

    describe "Associations" do
        it "has many reviews" do
            assc = described_class.reflect_on_association(:reviews)
            expect(assc.macro).to eq :has_many
        end
    end

    describe "Associations" do
        it "belongs to user" do
            assc = described_class.reflect_on_association(:user)
            expect(assc.macro).to eq :belongs_to
        end
    end

end
