require 'ostruct'

class RefusalAdvice::Block
  def initialize(data)
    @data = data
  end

  def id
    value(:id)
  end

  def label
    object(:label)
  end

  def hint
    value(:hint)
  end

  def show_if
    collection(:show_if)
  end

  def options
    collection(:options)
  end

  def ==(other)
    data == other.data
  end

  protected

  attr_reader :data

  private

  def value(key)
    data[key]
  end

  def collection(key)
    Array(data[key]).map { |item| OpenStruct.new(item) }
  end

  def object(key)
    OpenStruct.new(data[key]) if data.key?(key)
  end
end
