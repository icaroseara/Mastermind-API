class Player
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  
  embedded_in :game
  
  validates :name, presence: true
end