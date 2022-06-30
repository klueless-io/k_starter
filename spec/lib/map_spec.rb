# frozen_string_literal: true

RSpec.describe KStarter::Map do
  include_context :mock_inputs

  describe '#project' do
    subject { described_class.project(data) }

    context 'when the project type is gem' do
      let(:data) { data_gem_library_project }

      it { is_expected.to be_a(KStarter::Schema::GemProject) }
    end

    context 'when the project type is rails' do
      let(:data) { data_rails_project }

      it { is_expected.to be_a(KStarter::Schema::RailsProject) }
    end

    context 'when the project type is svelte' do
      let(:data) { data_svelte_project }

      it { is_expected.to be_a(KStarter::Schema::SvelteProject) }
    end

    context 'when the project type is nuxt' do
      let(:data) { data_nuxt_project }

      it { is_expected.to be_a(KStarter::Schema::NuxtProject) }
    end
  end

  describe '#starter' do
    subject { described_class.starter(project) }

    context 'when the project type is gem' do
      let(:project) { data_gem_library_project }

      it { is_expected.to be_a(KStarter::Starters::Gem) }
    end

    context 'when the project type is rails' do
      let(:project) { data_rails_project }

      it { is_expected.to be_a(KStarter::Starters::Rails) }
    end

    context 'when the project type is svelte' do
      let(:project) { data_svelte_project }

      it { is_expected.to be_a(KStarter::Starters::Svelte) }
    end

    context 'when the project type is nuxt' do
      let(:project) { data_nuxt_project }

      it { is_expected.to be_a(KStarter::Starters::Nuxt) }
    end
  end
end
