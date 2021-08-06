
class CarsController < ApplicationController
	def show
		@cars = Car.with_locations
		@geojson = build_geojson
	end

	private

	def build_geojson
		{
			type: "FeatureCollection",
			features: @cars.map(&:to_feature)
		}
	end
end