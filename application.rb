require './config/setup.rb'

Mongoid.load! "config/mongoid.config"

META_DATA = {
  name: 'Mastermind',
  description: 'A Mastermind game API'
}

# Load files from the models and api folders
Dir["#{File.dirname(__FILE__)}/app/api/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/app/domains/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/app/models/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/app/*.rb"].each { |f| require f }

module API
  class Root < Grape::API
    include V1::Defaults
    
    prefix :api

    format :json
    formatter :json, -> (object, _env) { object.to_json }
    content_type :json, 'application/vnd.api+json'

    helpers do
      def base_url
        "http://#{request.host}:#{request.port}/api/#{version}"
      end

      def invalid_media_type!
        error!('unsupported_media_type', 415)
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
    
    mount API::V1::Games
  end
end

Mastermind = Rack::Builder.new {
  map "/" do
    run API::Root
  end
}
