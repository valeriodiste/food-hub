class Recipe < ApplicationRecord

    has_many :reviews, dependent: :destroy
    belongs_to :user

    # provare i vari modi di validazione
    # before_validation
    # after_validation
    # before_save ecc

    before_save :capitalize_title

    def self.all_typologies ; %w[First\ Course Main\ Course Side Desserts Drinks] ; end

    def capitalize_title
        self.title = self.title.split(/\s+/).map(&:downcase).
          map(&:capitalize).join(' ')
    end

    validates :title, :presence => true, format: {with: /\A[a-zA-Z\ -_.@]+\z/}
	validates :description, :presence => true
	validates :typology, :inclusion => {:in => Recipe.all_typologies}

end
