require 'spec_helper'

describe API::V1::Games do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  let(:url) { BASE_URL }

  before do
    header 'Content-Type', 'application/vnd.api+json'
  end

  describe 'POST /games' do
    context 'with valid attributes' do
    end

    context 'with invalid attributes' do
    end
  end
  
  describe 'GET /games/available' do
  end
  
  describe 'POST /games/:id/join' do
    context 'with valid attributes' do
    end
    
    context 'with invalid attributes' do
    end
  end
  
  describe 'POST /games/:id/guess' do
    context 'with valid attributes' do
    end
    
    context 'with invalid attributes' do
    end
  end
  
  describe 'GET /games/:id/guesses' do
  end
  
  describe 'GET /games/:id/status' do
  end
end
