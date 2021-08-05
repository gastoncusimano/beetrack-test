class Api::V1::GpsController < ActionController::Base
  def create_location
		CreateLocation.perform_later(params)
	end
end
