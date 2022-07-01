# frozen_string_literal: true

RSpec.describe KStarter::Starters::Svelte do
  include_context :mock_inputs

  subject { instance }

  let(:instance) { described_class.new(project) }
  let(:project) { KStarter::Map.project(data_svelte_project) }

  describe '#genesis_sveltekit' do
    subject { instance.send(:genesis_sveltekit) }

    it { is_expected.to include('npm create svelte my_first_svelte_app') }
  end

  describe '#genesis_vite' do
    subject { instance.send(:genesis_vite) }

    it { is_expected.to include('npm init vite my_first_svelte_app') }
  end

  # describe '#execute' do
  #   let(:args) { { code_open_delay: 5 } }

  #   let(:project_data) { data_gem_library_project }
  #   it do
  #     # will create the project
  #     # instance.execute
  #     # will ask a question about if you want to recreate a project
  #     # instance.execute
  #   end
  # end
end
