require 'spec_helper'

describe RefusalAdviceHelper do
  include RefusalAdviceHelper

  describe '#refusal_advice_questions' do
    subject { refusal_advice_questions(questions) }

    let(:questions) do
      [ double(label: { plain: 'abc' }).as_null_object,
        double(label: { plain: '123' }).as_null_object,
        double(label: { plain: 'xyz' }).as_null_object ]
    end

    it { is_expected.to match(/abc/) }
    it { is_expected.to match(/123/) }
    it { is_expected.to match(/xyz/) }
  end

  describe '#refusal_advice_question' do
    subject { refusal_advice_question(question) }
    let(:question) { double(label: { plain: 'xyz' }).as_null_object }
    it { is_expected.to match(/xyz/) }
  end

  describe '#refusal_advice_radio' do
    subject { refusal_advice_radio(question, option) }

    let(:question) { double(id: 'confirm-or-deny') }
    let(:option) { double(value: 'yes', label: 'Yes') }

    it { is_expected.to match(/radio/) }
    it { is_expected.to match(/name="confirm-or-deny_yes"/) }
    it { is_expected.to match(/id="confirm-or-deny_yes"/) }
    it { is_expected.to match(/value="confirm-or-deny"/) }
    it { is_expected.to match(/for="confirm-or-deny_yes"/) }
    it { is_expected.to match(/Yes/) }
  end

  describe '#refusal_advice_checkbox' do
    subject { refusal_advice_checkbox(question, option) }

    let(:question) { double(id: 'refusal-reasons') }
    let(:option) { double(value: 'section-1', label: 'Section 1') }

    it { is_expected.to match(/checkbox/) }
    it { is_expected.to match(/name="refusal-reasons_section-1"/) }
    it { is_expected.to match(/id="refusal-reasons_section-1"/) }
    it { is_expected.to match(/value="refusal-reasons"/) }
    it { is_expected.to match(/for="refusal-reasons_section-1"/) }
    it { is_expected.to match(/Section 1/) }
  end
end
