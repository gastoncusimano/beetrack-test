class Api::V1::GpsController < ApplicationController

	def create_location
		CreateLocationWorker.perform_async(gps_params)
		json_response "Creating Location", true, :ok
	end

	private

	def gps_params
		{
			longitude: params[:longitude],
			latitude: params[:latitude],
			sent_at: params[:sent_at],
			vehicle_identifier: params[:vehicle_identifier],
		}
	end
end
