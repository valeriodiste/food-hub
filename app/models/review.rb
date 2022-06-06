class Review < ApplicationRecord
    belongs_to :recipe
	belongs_to :user


    def valid_rating
        errors.add(:rating, 'must be between 1 and 5') if
            rating && rating < 1 && rating > 5
    end

    validates :rating, :presence => true
	validates :description, :presence => true
    validate :valid_rating
    validates :recipe, uniqueness: { scope: :user,
        message: "Non si può pubblicare più di una recensione per una stessa ricetta con lo stesso utente" }
end
