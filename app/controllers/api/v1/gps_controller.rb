class Api::V1::GpsController < ApplicationController

	def create_location
		job_id = CreateLocationWorker.perform_async(gps_params)
		if Sidekiq::Status::queued? job_id
			json_response "Creating Location - queued", false, :ok
		else
			json_response "Something went wrong", false, :service_unavailable
		end
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
