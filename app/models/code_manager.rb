class CodeManager
  def self.valid? code
    (code =~ Settings::CODE_REGEX).present?
  end
  
  def self.generate_code
    (0...Settings::CODE_LENGTH).map { Settings::COLORS.sample }.join
  end
end