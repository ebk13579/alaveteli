require 'yaml'

# Parses refusal advice from data files and flattens into a single data
# structure.
class RefusalAdvice::Store
  def self.from_yaml(files)
    yamls = files.map { |file| YAML.load(File.read(file)) }
    new(yamls)
  end

  def initialize(data)
    @data = data
  end

  def [](key)
    to_h[key.to_sym]
  end

  def to_h
    @to_h ||= data.inject({}) do |memo, set|
      set.each do |key, values|
        memo[key] ||= []
        memo[key] = memo[key] | values
      end

      memo
    end.deep_symbolize_keys
  end

  def ==(other)
    data == other.data
  end

  protected

  attr_reader :data
end
