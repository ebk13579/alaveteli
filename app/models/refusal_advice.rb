# A collection of Questions that help users challenge refusals.
class RefusalAdvice
  def self.default
    files = Rails.configuration.paths['config/refusal_advice'].existent
    new(RefusalAdvice::Data.from_yaml(files))
  end

  def self.load(glob)
    new(RefusalAdvice::Data.from_yaml(Dir.glob(glob)))
  end

  def initialize(data)
    @data = data
  end

  def questions(legislation)
    data[legislation.to_sym].map { |question| Question.new(question) }
  end

  def ==(other)
    data == other.data
  end

  protected

  attr_reader :data
end
