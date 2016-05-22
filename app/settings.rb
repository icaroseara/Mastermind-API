class Settings
  COLORS = %w(R B G Y O P C M).freeze
  CODE_LENGTH = 8
  CODE_REGEX = /\A[rgbypocm]{8}\z/i
  TURN_LIMIT = 20
  TIME_LIMIT = 5
end
