# frozen_string_literal: true

RSpec.describe KStarter::Starters::Svelte do
  include_context :mock_inputs

  subject { instance }

  let(:instance) { described_class.new(project) }
  let(:project) { KStarter::Map.project(data_svelte_project) }

  describe '#execute' do
    subject { instance.execute }

    it { is_expected.to include('npx degit sveltejs/template my_first_svelte_app') }
  end
end
