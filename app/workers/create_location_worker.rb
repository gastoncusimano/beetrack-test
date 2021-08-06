class CreateLocationWorker
	include Sidekiq::Worker
	include Sidekiq::Status::Worker # enables job status tracking
	sidekiq_options retry: false

	def perform(params)
		@vehicle = find_or_create_vehicle(params["vehicle_identifier"])
		create_location(@vehicle, params)
	end

	private

	def	create_location(vehicle, params)
		vehicle.locations.build(longitude: params["longitude"],
													latitude: params["latitude"],
													sent_at: params["sent_at"]
													)
		vehicle.save
	end

	def find_or_create_vehicle licence_plate
		Car.find_or_create_by!(licence_plate: licence_plate)
	end
end