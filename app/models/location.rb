class Location < ApplicationRecord
	belongs_to :car

	# Validations
	validates :longitude, :latitude, :sent_at, presence: true
	validate :sent_at_cannot_be_in_the_future

	#Scopes
	scope :order_by_sent_at, -> { order("sent_at").last }

	def sent_at_cannot_be_in_the_future
		if sent_at > DateTime.now
			errors.add(:sent_at, "can't be in the future")
		end  
	end
end
