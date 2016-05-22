module API
  module Entities
    class Game < Grape::Entity
      expose :id do |game|
        game.id.to_s
      end
    end
    
    class GameStatus < Grape::Entity
      expose :id do |game|
        game.id.to_s
      end
      expose :winner, documentation: { type: "String", desc: "Game winner." }
      expose :started_at, documentation: { type: "Datetime", desc: "Time game stated." }
      expose :time_limit, documentation: { type: "Datetime", desc: "Time limit." }
      expose :time_taken, documentation: { type: "Datetime", desc: "Time taken in this game." }
      expose :solved, documentation: { type: "Boolean", desc: "Game was solved." }
    end
  end
end