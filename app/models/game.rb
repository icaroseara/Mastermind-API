class Game
  include Mongoid::Document
  #include Mongoid::Enum
  include Mongoid::Timestamps
  
  TIME_LIMIT = 5
  NUM_PEGS = 8

  field :available, type: Boolean
  field :winner, type: String

  #enum :status, [:started, :pending, :finished]
  
  embeds_many :players
  embeds_many :guesses
  
  def answer_code
    CodeGenerator.new.code
  end
  
  def win? guess
    guess.exact_matches == NUM_PEGS
  end
  
  def winner
  end
  
  def instructions
  end
  
  def time_taken
  end
  
  def result
  end
end