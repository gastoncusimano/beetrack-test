Rails.application.routes.draw do
  # Api Routes
  namespace :api do
    namespace :v1 do
      #GPS
      controller :gps do
        post "/gps" => :create_location
      end
    end
  end
  # Routes
  get '/show', to: 'cars#show'
end
