class Guess
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :code, type: String
  
  embedded_in :game
  has_one :player
  
  validates :code, presence: true
  
  def count_colors(code)
    code.split("").uniq.inject({}) do |hash, value|
      hash[value] = code.count(value)
      hash
    end
  end

  def exact_matches
   (0..8).map{|i| code[i] == game.answer_code[i]}.count(true)
  end

  def near_matches(code)
    answer_colors = count_colors(game.answer_code)
    guess_colors = count_colors(code)

    total = count_colors(code).map do |color, qtd| 
      answer_colors[color] > qtd ? qtd : answer_colors[color]
    end

    total.sum - exact_matches
  end
  
  def solved?
  end
end