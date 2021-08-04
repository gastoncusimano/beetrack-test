class Car < ApplicationRecord
	has_many :locations, dependent: :destroy

	#Validations
	validates :licence_plate, presence: true, uniqueness: true
	validates :licence_plate, format: { with: /\A[A-Z]{2}-[0-9]{3}\z/ } # RegExp to check if the licence is format valid or not
end
