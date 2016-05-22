require 'spec_helper'

describe CodeManager do
  let(:valid_code) { "RRBPPCBC" }
  let(:invalid_code) { "XYZXYZXY" }
  
  describe '.valid?' do
    it "returns true with valid code" do
      expect(CodeManager.valid?(valid_code)).to be_truthy
    end
    
    it "returns false with invalid code" do
      expect(CodeManager.valid?(invalid_code)).to be_falsy
    end
  end
  
  describe '.generate_code' do
    it "returns a valid code" do
      expect(CodeManager.valid?(CodeManager.generate_code)).to be_truthy
    end 
  end
end
