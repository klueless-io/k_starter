# frozen_string_literal: true

RSpec.describe KStarter::AppGenerator do
  include_context :use_temp_folder

  let(:instance) { described_class.new([temp_folder], opts) }

  let(:opts) do
    {
      force: true,
      skip_bundle: true,
      skip_git: true,
      skip_hotwire: true,
      dummy_app: true
    }
  end

  subject { instance }

  context 'when running generator' do
    it { subject }
  end

  # fit {subject }
end
