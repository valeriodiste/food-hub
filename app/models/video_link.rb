class VideoLink < ActiveType::Object

	attribute :url, :string

	validates :url, presence: true
	
  end