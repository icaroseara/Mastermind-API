module API
  module V1
    class Games < Grape::API
      version 'v1', using: :path, vendor: 'mastermind-icaro-seara'
 
      resources :games do
        desc 'Returns available games'
        get "/available" do
          games = Game.available.ordered
          present :games, games, with: API::Entities::Game
        end
        
        desc 'Create a game'
        params do
          requires :player, type: Hash do
            requires :name, type: String
          end
        end
        post do
          begin
            game_domain = Domains::GameDomain.create(params)
            present :colors, Settings::COLORS
            present :code_length, Settings::CODE_LENGTH
            present :game_id, game_domain[:game].id.to_s
            present :player_id, game_domain[:player].id.to_s
          rescue  Errors::InvalidPlayerName
            error!({ message: 'invalid_player_name' }, 400)
          end
        end
        
        desc 'Join a game'
        params do
          requires :id, type: String
          requires :player, type: Hash do
            requires :name, type: String
          end
        end
        post ':id/join' do
          begin
            game_domain = Domains::GameDomain.join(params)
            present :colors, Settings::COLORS
            present :code_length, Settings::CODE_LENGTH
            present :game_id, game_domain[:game].id.to_s
            present :player_id, game_domain[:player].id.to_s
          rescue  Errors::InvalidPlayerName
            error!({ message: 'invalid_player_name' }, 400)
          rescue  Errors::GameStarted
            error!({ message: 'game_started' }, 400)
          rescue  Errors::GameFinished
            error!({ message: 'game_finished' }, 400)
          rescue  Errors::PlayerJoined
            error!({ message: 'player_joined' }, 400)
          end
        end
        
        desc 'Guess a game code'
        params do
          requires :id, type: String
          requires :code, type: String
          requires :player, type: Hash do
            requires :id, type: String
          end
        end
        post ':id/guess' do
          begin
            game_domain = Domains::GameDomain.guess(params)
            present :colors, Settings::COLORS
            present :code_length, Settings::CODE_LENGTH
            present :game_id, params[:id]
            present :player_id, params[:player][:id]
            present :correct, game_domain[:guess].correct
            present :misplaced, game_domain[:guess].misplaced
            present :code, params[:code]
            present :solved, game_domain[:game].solved?
            present :time_taken,  game_domain[:game].time_taken
            present :time_started,  game_domain[:game].started_at
            present :time_limit,  game_domain[:game].time_limit
            present :winner,  game_domain[:game].winner.to_s
            present :num_guesses,  game_domain[:game].num_guesses(params[:player][:id])
            present :past_guesses,  game_domain[:game].past_guesses
          rescue  Errors::GamePending
            error!({ message: 'game_pending' }, 400)
          rescue  Errors::GameFinished
            error!({ message: 'game_finished' }, 400)
          rescue  Errors::InvalidPlayer
            error!({ message: 'invalid_player' }, 400)
          rescue  Errors::InvalidCode
            error!({ message: 'invalid_code' }, 400)
          rescue Errors::GameTimeout
            error!({ message: 'game_timeout' }, 400)
          rescue Errors::GameTimeout
            error!({ message: 'game_timeout' }, 400)
          rescue Errors::Turnlimit
            error!({ message: 'turn_limit' }, 400)
          end
        end
        
        desc "List the game status"
        params do
          requires :id, type: String
        end
        get ':id/status' do
          game = Game.find(params[:id])
          present :game, game, with: API::Entities::GameStatus
        end
      end
    end
  end
end