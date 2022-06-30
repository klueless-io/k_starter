# frozen_string_literal: true

require 'tty-prompt'

RSpec.describe KStarter::Questions::Rails do
  include_context :mock_inputs

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
        include_action_text: true,
        include_active_storage: true,
        include_sample_models: true,
        include_javascript_libraries: true,
        include_devise: true,
        include_rspec: true,
        include_common_pages: true,
        run_db_migrate: true
      )
    end
  end

  context 'when provided with arguments' do
    let(:data) { data_rails_project }

    describe '#to_h' do
      subject { instance.to_h }

      it { is_expected.to be_a(Hash) }
      it_behaves_like :expected_data_rails_project
    end

    describe '#to_dom' do
      subject { instance.to_dom }

      it { is_expected.to be_a(KStarter::Schema::RailsProject) }
      it_behaves_like :expected_data_rails_project
    end
  end
end
