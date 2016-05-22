class CodeGenerator
  COLORS = %w(R B G Y O P C M).freeze
  CODE_LENGTH = 8
  CODE_REGEX = /\A[rgbypocm]{8}\z/i
  
  def initialize(code=generate_code)
    @code = code
  end
  
  def valid?
    (@code =~ CODE_REGEX).present?
  end
  
  def code
    @code
  end
  
  private
  
  def generate_code
    (0...CODE_LENGTH).map { COLORS.sample }.join
  end
end