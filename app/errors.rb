module Errors
	class InvalidPlayerName < StandardError;	end
  class GameStarted < StandardError;	end
  class GameFinished < StandardError;	end
  class PlayerJoined < StandardError;	end
  class InvalidCode < StandardError;	end
  class GamePending < StandardError;	end
  class InvalidPlayer < StandardError;	end
  class GameTimeout < StandardError;	end
  class Turnlimit < StandardError;	end
end
