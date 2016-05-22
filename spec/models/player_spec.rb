require 'spec_helper'

describe Player do
  describe 'validations' do
    it 'is invalid without a name' do
      player = Player.new(name: nil)
      expect(player.valid?).to be_falsy
    end
    
    it 'is invalid without short name' do
      player = Player.new(name: SecureRandom.hex(2))
      expect(player.valid?).to be_falsy
    end
    
    it 'is invalid without long name' do
      player = Player.new(name: SecureRandom.hex(50))
      expect(player.valid?).to be_falsy
    end
  end
end
