# frozen_string_literal: true

RSpec.describe 'Schema' do
  include_context :mock_inputs

  subject { instance }

  let(:instance) { described_class.new(data) }

  describe KStarter::Schema::ProjectType do
    let(:data) { config_project_type }

    describe '#to_h' do
      subject { instance.to_h }

      it_behaves_like :expected_project_type
    end
  end

  describe KStarter::Schema::Github do
    let(:data) { config_github }

    describe '#to_h' do
      subject { instance.to_h }

      it_behaves_like :expected_github
    end
  end

  describe KStarter::Schema::Story do
    let(:data) { data_story }

    describe '#to_h' do
      subject { instance.to_h }

      it_behaves_like :expected_data_story
    end
  end

  describe KStarter::Schema::KlueTemplate do
    let(:data) { data_klue_template }

    describe '#to_h' do
      subject { instance.to_h }

      it_behaves_like :expected_data_klue_template
    end
  end

  describe KStarter::Schema::BaseProject do
    let(:data) { data_base_project }

    describe '#to_h' do
      subject { instance.to_h }

      it_behaves_like :expected_data_base_project
    end

    describe '#expanded_project_path' do
      subject { instance.expanded_project_path }

      it { is_expected.to start_with('/User').and end_with('/some_root/some_project') }
    end

    describe '#root_path' do
      subject { instance.root_path }

      it { is_expected.to start_with('~').and end_with('/some_root') }
    end

    describe '#expanded_root_path' do
      subject { instance.expanded_root_path }

      it { is_expected.to start_with('/User').and end_with('/some_root') }
    end

    describe '#github_account_type' do
      subject { instance.github_account_type }

      before do
        KStarter::App.config.data[:github] = config_github
      end

      it { is_expected.to eq(:user) }

      describe '#github_organization' do
        subject { instance.github_organization }

        it { is_expected.to be_nil }
      end

      context 'when github_key is an organization' do
        let(:data) { data_base_project.merge(github_key: 'some_organization') }

        it { is_expected.to eq(:organization) }

        describe '#github_organization' do
          subject { instance.github_organization }

          it { is_expected.to eq('some_organization') }
        end
      end
    end
  end

  describe KStarter::Schema::RailsProject do
    let(:data) { data_rails_project }

    describe '#to_h' do
      subject { instance.to_h }

      # fit { puts JSON.pretty_generate(subject) }
      it_behaves_like :expected_data_rails_project
    end
  end

  describe KStarter::Schema::GemProject do
    let(:data) { data_gem_library_project }

    describe '#to_h' do
      subject { instance.to_h }

      it_behaves_like :expected_data_gem_library_project
    end
  end

  describe KStarter::Schema::SvelteProject do
    let(:data) { data_svelte_project }

    describe '#to_h' do
      subject { instance.to_h }

      it_behaves_like :expected_data_svelte_project
    end
  end

  describe KStarter::Schema::NuxtProject do
    let(:data) { data_nuxt_project }

    describe '#to_h' do
      subject { instance.to_h }

      it_behaves_like :expected_data_nuxt_project
    end
  end
end
