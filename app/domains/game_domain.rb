module Domains
  class GameDomain
  	class << self
      def create params
        player = Player.find_or_initialize_by(name: params[:player][:name])
        raise Errors::InvalidPlayerName.new unless player.valid?

        game = Game.create(players: [player])
        {game: game, player: player}
      end
      
      def join params
        game = Game.find(params[:id])
        player = Player.find_or_initialize_by(name: params[:player][:name])
        
        raise Errors::InvalidPlayerName.new unless player.valid?
        raise Errors::GameStarted.new if game.started?
        raise Errors::GameFinished.new if game.finished?
        raise Errors::PlayerAlreadyJoined.new if game.players.where(id: player.id).present?
        
        player.save
        game.players << player
        game.started_at = Time.now
        game.save!
        game.start!
        {game: game, player: player}
      end
      
      def guess params
        game = Game.find(params[:id])
        player = Player.find(params[:player][:id])
        
        raise Errors::GamePending.new if game.created?
        raise Errors::GameFinished.new if game.finished?
        raise Errors::InvalidPlayer.new unless game.players.find(player).present?
        raise Errors::InvalidCode.new unless CodeManager.valid?(params[:code])
        
        if Time.now > game.time_limit
          game.finish!
          raise Errors::GameTimeout.new
        end
        
        raise Errors::Turnlimit.new if game.guesses.where(player: player).count > Settings::TURN_LIMIT
        
        guess = Guess.create(code: params[:code], game: game, player: player)
        
        if game.win? guess
          game.finish!
          game.winner = guess.player.name
          game.finished_at = Time.now
          game.solved = true         
        end
        game.save!
        { game: game, guess: guess}
      end
    end
  end
end