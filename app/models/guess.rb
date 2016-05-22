class Guess
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :code, type: String
  field :correct, type: Integer
  field :misplaced, type: Integer
  
  belongs_to :game
  belongs_to :player
  
  validates :code, presence: true, unless: Proc.new { |guess| CodeManager.valid?(code) }
  
  before_create :record_feedback
  
  def calculate_correct
   (0...Settings::CODE_LENGTH).map{|i| code[i] == game.secret_code[i]}.count(true)
  end

  def calculate_misplaced
    answer_colors = grouped_colors(game.secret_code)
    guess_colors = grouped_colors(code)

    total = guess_colors.map do |color, qtd| 
      answer_colors[color].to_i > qtd ? qtd : answer_colors[color].to_i
    end

    total.sum - calculate_correct
  end
  
  private
  
  def record_feedback
    self.correct = calculate_correct
    self.misplaced = calculate_misplaced
  end
  
  def grouped_colors(code)
    code.split("").uniq.inject({}) do |hash, value|
      hash[value] = code.count(value)
      hash
    end
  end
end