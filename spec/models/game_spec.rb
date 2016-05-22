require 'spec_helper'

describe Game do
  let(:game) { Game.new }
  
  describe 'validations' do
    it 'is invalid without a player' do
      game = Game.new(players: nil)
      expect(game.valid?).to be_falsy
    end
    
    it 'is invalid without a invalid player' do
      player = Player.new
      game = Game.new(players: [player])
      expect(game.valid?).to be_falsy
    end
  end
end
