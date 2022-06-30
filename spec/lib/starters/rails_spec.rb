# frozen_string_literal: true

RSpec.describe KStarter::Starters::Gem do
  include_context :mock_inputs

  subject { instance }

  let(:instance) { described_class.new(project) }
  let(:project) { KStarter::Map.project(data_nuxt_project) }

  describe '#execute' do
    subject { instance.execute }

    # it { is_expected.to include('npx nuxi init my_first_nuxt_app') }
  end
end
