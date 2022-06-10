# spec/user_spec.rb

require 'rails_helper'

RSpec.describe User, :type => :model do

    describe "Create a User with an invalid email" do
        it "shouldn't be allowed" do
          user = User.create(email: 'test',
                       password: 'aaaaaaaa',
                       password_confirmation: 'aaaaaaaa')
          expect(user).to_not be_valid
        end
    end

    describe "Create a User without an email" do
        it "shouldn't be allowed" do
          user = User.create(password: 'aaaaaaaa',
                             password_confirmation: 'aaaaaaaa')
          expect(user).to_not be_valid
        end
    end

    describe "Create a User without a password" do
        it "shouldn't be allowed" do
          user = User.create(email: 'test@test.com', password_confirmation: 'aaaaaaaa')
          expect(user).to_not be_valid
        end
    end

    describe "Create a User with password and password confirmation with different values " do
        it "shouldn't be allowed" do
          user = User.create(email: 'test@test.com', password: 'aaaaaaaa', password_confirmation: 'bbbbbbbb')
          expect(user).to_not be_valid
        end
    end

    describe "Create a User with a password shorter than 8 characters" do
        it "shouldn't be allowed" do
          user = User.create(email: 'test@test.com', password: 'aaaaaa', password_confirmation: 'aaaaaa')
          expect(user).to_not be_valid
        end
    end

    describe "Create a User with a valid email, password and password confirmation" do
        it "should be allowed" do
          user = User.create(email: 'test@test.com', password: 'aaaaaaaa',  password_confirmation: 'aaaaaaaa')
          expect(user).to be_valid
        end
    end

    describe "Associations" do
        it "has many recipes" do
            assc = described_class.reflect_on_association(:recipes)
            expect(assc.macro).to eq :has_many
        end
    end

    describe "Associations" do
        it "has many reviews" do
            assc = described_class.reflect_on_association(:reviews)
            expect(assc.macro).to eq :has_many
        end
    end

end