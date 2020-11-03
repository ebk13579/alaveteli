require 'spec_helper'

require_dependency 'refusal_advice/data'

RSpec.describe RefusalAdvice::Data do
  let(:glob) { Rails.root + 'spec/fixtures/refusal_advice/data/*.yml' }

  let(:fixture_data) do
    [ { eir: [ { hello: 'world' } ] },
      { foi: [ { foo: 'bar' },
               { baz: 'xyz' } ] },
      { foi: [ { file: '2-foi' } ],
        eir: [ { file: '2-eir' } ] } ].map(&:deep_stringify_keys)
  end

  describe '.from_yaml' do
    subject { described_class.from_yaml(glob) }
    it { is_expected.to eq(described_class.new(fixture_data)) }
  end

  describe '#[]' do
    subject { described_class.new(fixture_data)[key] }

    context 'with a symbol key' do
      let(:key) { :eir }
      it { is_expected.to eq([{ hello: 'world' }, { file: '2-eir' }]) }
    end

    context 'with a string key' do
      let(:key) { 'eir' }
      it { is_expected.to eq([{ hello: 'world' }, { file: '2-eir' }]) }
    end
  end

  describe '#to_h' do
    subject { described_class.new(fixture_data).to_h }

    it 'merges the data in each globbed file into a hash' do
      expected = {
        foi: [
          { foo: 'bar' },
          { baz: 'xyz' },
          { file: '2-foi' }
        ],
        eir: [
          { hello: 'world' },
          { file: '2-eir' }
        ]
      }

      is_expected.to eq(expected)
    end
  end

  describe '#==' do
    subject { a == b }

    context 'with the same data' do
      let(:a) { described_class.new(foo: 'bar') }
      let(:b) { described_class.new(foo: 'bar') }
      it { is_expected.to eq(true) }
    end

    context 'with different data' do
      let(:a) { described_class.new(foo: 'bar') }
      let(:b) { described_class.new(bar: 'foo') }
      it { is_expected.to eq(false) }
    end
  end
end
