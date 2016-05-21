require 'grape'
require 'mongoid'
require 'hashie-forbidden_attributes'

Mongoid.load! "config/mongoid.config"

META_DATA = {
  name: 'Mastermind',
  description: 'A Mastermind game API'
}

# Load files from the models and api folders
Dir["#{File.dirname(__FILE__)}/app/models/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/app/api/**/*.rb"].each { |f| require f }

# Grape API class. We inherit from it in our controllers.
module API
  class Root < Grape::API
    prefix :api

    format :json
    formatter :json, -> (object, _env) { object.to_json }
    content_type :json, 'application/vnd.api+json'

    helpers do
      def base_url
        "http://#{request.host}:#{request.port}/api/#{version}"
      end

      def invalid_media_type!
        error!('Unsupported media type', 415)
      end

      def json_api?
        request.content_type == 'application/vnd.api+json'
      end
    end

    before do
      invalid_media_type! unless json_api?
    end

    get :status do
      { status: 'ok' }
    end
  end
end

# Mounting the Grape application
Mastermind = Rack::Builder.new {

  map "/" do
    run API::Root
  end

}
