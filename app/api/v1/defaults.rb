module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        format :json

        rescue_from Mongoid::Errors::DocumentNotFound do |e|
          error!({message: 'not_found', error: e.message}, 404)
        end

        rescue_from Mongoid::Errors::InvalidFind, Mongoid::Errors::Validations do |e|
          error!({message: 'validation_error', error: e.message}, 400)
        end

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error!({message: 'validation_error', error: e.message}, 400)
        end

        rescue_from Grape::Exceptions::InvalidMessageBody do |e|
          error!({message: 'invalid_message_body', error: e.message}, 400)
        end

        rescue_from Grape::Exceptions::Base do |e|
          error!({message: 'request_error', error: e.message}, 400)
        end

        rescue_from :all do |e|
          error!({message: "unexpected_error", error: e.message}, 500)
        end
      end
    end
  end
end
