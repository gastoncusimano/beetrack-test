class Car < ApplicationRecord
	has_many :locations, dependent: :destroy

	#Validations
	validates :licence_plate, presence: true, uniqueness: true
	validates :licence_plate, format: { with: /\A[A-Z]{2}-[0-9]{4}\z/ } # RegExp to check if the licence is format valid or not

	#Scopes
	scope :with_locations, -> { joins(:locations).distinct}

  def coordinates
    last_location = locations.order_by_sent_at
    [last_location.longitude.to_f, last_location.latitude.to_f]
  end
	
	def to_feature
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": coordinates
      },
      "properties": {
        "car_id": id,
        "info_window": ApplicationController.new.render_to_string(
          partial: "cars/infowindow",
          locals: { car: self }
        )
      }
    }
  end
end
