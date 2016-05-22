require 'spec_helper'

describe API::Root do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  describe 'GET /status' do
    context 'media-type: application/json' do
      before do
        header 'Content-Type', 'application/json'
        get '/api/status'
      end

      it 'returns HTTP status 415' do
        expect(last_response.status).to eq 415
      end

      it 'returns Unsupported media type' do
        expect(JSON.parse(last_response.body)).to eq({"error"=>"unsupported_media_type"})
      end
    end
    
    context 'media-type: application/vnd.api+json' do
      it 'returns 200 and status ok' do
        header 'Content-Type', 'application/vnd.api+json'
        get '/api/status'
        expect(last_response.status).to eq 200
        expect(JSON.parse(last_response.body)).to eq({ 'status' => 'ok' })
      end
    end
  end
end
