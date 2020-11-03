require 'spec_helper'

RSpec.describe RefusalAdvice do
  let(:glob) { Rails.root + 'spec/fixtures/refusal_advice/*.yml' }

  describe '.load' do
    subject { described_class.load(glob) }
    let(:data) { RefusalAdvice::Data.from_yaml(glob) }
    it { is_expected.to eq(described_class.new(data)) }
  end

  describe '#questions' do
    subject { described_class.load(glob).questions(legislation) }

    context 'for the FOI legislation' do
      let(:legislation) { :foi }

      let(:foi_questions) do
        [ RefusalAdvice::Question.new(id: 'foo'),
          RefusalAdvice::Question.new(id: 'bar') ]
      end

      it { is_expected.to eq(foi_questions) }
    end

    context 'for the EIR legislation' do
      let(:legislation) { :eir }

      let(:eir_questions) do
        [ RefusalAdvice::Question.new(id: 'baz') ]
      end

      it { is_expected.to eq(eir_questions) }
    end
  end

  describe '#==' do
    subject { a == b }

    let(:data_a) { double }
    let(:data_b) { double }

    context 'with the same data' do
      let(:a) { described_class.new(data_a) }
      let(:b) { described_class.new(data_a) }
      it { is_expected.to eq(true) }
    end

    context 'with different data' do
      let(:a) { described_class.new(data_a) }
      let(:b) { described_class.new(data_b) }
      it { is_expected.to eq(false) }
    end
  end
end
