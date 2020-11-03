require 'spec_helper'

RSpec.describe RefusalAdvice::Question do
  let(:data) do
    { id: 'yes-they-have-provided-information',
      label: {
        plain: 'Refusing a request on cost grounds…'
      },
      hint: 'Note that…',
      show_if: [
        { id: 'have-they-already-provided-information',
          operator: 'is',
          value: 'yes' },
        { id: 'section_12',
          operator: 'include',
          value: 'no' }
      ],
      options: [
        { label: 'Yes', value: 'yes' },
        { label: 'No', value: 'no' }
      ],
      suggestion: {
        action: 'reply',
        response_template: 'i-only-need-some-of-the-information'
      } }
  end

  let(:question) { described_class.new(data) }

  describe '#id' do
    subject { question.id }
    it { is_expected.to eq('yes-they-have-provided-information') }
  end

  describe '#label' do
    subject { question.label }

    it do
      is_expected.
        to eq(OpenStruct.new(plain: 'Refusing a request on cost grounds…'))
    end
  end

  describe '#hint' do
    subject { question.hint }
    it { is_expected.to eq('Note that…') }
  end

  describe '#show_if' do
    subject { question.show_if }

    it do
      expected = data[:show_if].map { |condition| OpenStruct.new(condition) }
      is_expected.to match_array(expected)
    end
  end

  describe '#options' do
    subject { question.options }

    it do
      expected = data[:options].map { |condition| OpenStruct.new(condition) }
      is_expected.to match_array(expected)
    end
  end

  describe '#suggestion' do
    subject { question.suggestion }

    it do
      data = { action: 'reply',
               response_template: 'i-only-need-some-of-the-information' }
      is_expected.to eq(OpenStruct.new(data))
    end
  end

  describe '#==' do
    subject { a == b }

    context 'with the same data' do
      let(:a) { described_class.new(id: 'bar') }
      let(:b) { described_class.new(id: 'bar') }
      it { is_expected.to eq(true) }
    end

    context 'with different data' do
      let(:a) { described_class.new(id: 'bar') }
      let(:b) { described_class.new(id: 'foo') }
      it { is_expected.to eq(false) }
    end
  end
end
