class Player
  include Mongoid::Document
  
  field :name, type: String
  
  has_and_belongs_to_many :games
  has_many :guesses
  
  validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 50 }
end