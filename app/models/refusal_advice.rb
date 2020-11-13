# A collection of Questions that help users challenge refusals.
class RefusalAdvice
  def self.default
    files = Rails.configuration.paths['config/refusal_advice'].existent
    new(Store.from_yaml(files))
  end

  def self.load(glob)
    new(Store.from_yaml(Dir.glob(glob)))
  end

  def initialize(data)
    @data = data
  end

  def questions(legislation)
    data[legislation.to_sym].
      select { |block| block[:question] }.
      map { |question| Question.new(question[:question]) }
  end

  def suggestions(legislation)
    data[legislation.to_sym].
      select { |block| block[:suggestion] }.
      map { |question| Suggestion.new(question[:suggestion]) }
  end

  def ==(other)
    data == other.data
  end

  protected

  attr_reader :data
end
