# frozen_string_literal: true

require 'tty-prompt'

RSpec.describe KStarter::Questions::CliGem do
  let(:instance) { described_class.new(**data) }
  let(:data) { {} }

  subject { instance }

  describe '#ask_questions' do
    it 'should be a method' do
      expect(instance).to respond_to(:ask_questions)
    end

    # it 'asks the questions' do
    #   instance.ask_questions

    #   puts instance.to_h
    # end
  end

  context 'when no arguments provided' do
    it do
      is_expected.to have_attributes(
        name: nil,
        variant: :cli,
        exe: true,
        coc: true,
        mit: true,
        rspec: true
      )
    end
  end
end
