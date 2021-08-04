class Location < ApplicationRecord
	belongs_to :car

	# Validations
	validates :longitude, :latitude, :sent_at, presence: true
end
