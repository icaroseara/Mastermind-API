class Game
  include Mongoid::Document
  include Mongoid::Timestamps
  include AASM
  
  field :aasm_state
  aasm do
    state :created, :initial => true
    state :started, :finished
    
    event :start do
      transitions :from => :created, :to => :started
    end
    
    event :finish do
      transitions :from => :started, :to => :finished
    end
  end
  
  field :winner, type: String
  field :secret_code, type: String
  field :started_at, type: DateTime
  field :finished_at, type: DateTime
  field :solved, type: Boolean, default: false

  has_and_belongs_to_many :players
  has_many :guesses
  
  validates :players, presence: true
  
  scope :available, -> { where(aasm_state: "created") }
  scope :ordered, -> { order('created_at DESC') }
  
  before_create :record_secret_code

  def win? guess
    guess.correct == Settings::CODE_LENGTH
  end

  def time_taken
    finished_at.present? && started_at.present? ? finished_at - started_at : 0
  end
  
  def time_limit
    started_at.present? ? started_at + Settings::TIME_LIMIT.minutes : 0
  end
  
  def past_guesses
    guesses.map{|guess| { code: guess.code, correct: guess.correct, misplaced: guess.misplaced, player: guess.player.name}}
  end
  
  def num_guesses player_id
    guesses.where(player_id: player_id).count
  end
  
  private
  def record_secret_code
    self.secret_code = CodeManager.generate_code
  end
end