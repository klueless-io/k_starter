# frozen_string_literal: true

RSpec.describe KStarter::Database::ConfigModel do
  include_context :mock_inputs
  include_context :use_temp_folder

  subject { instance.name }

  let(:instance) { described_class.new(**args) }
  let(:args) { {} }

  let(:ruby_config) { { type: :ruby, path: '~/webapp' } }
  let(:gem_library_config) { { type: :gem, variant: :library, path: '~/libraries' } }
  let(:gem_cli_config) { { type: :gem, variant: :cli, path: '~/commands' } }

  context 'initialize with default args' do
    describe '.filename' do
      subject { instance.filename }

      it { is_expected.to include(described_class::DEFAULT_FILE_NAME) }
    end
  end

  context 'initialize with custom args' do
    let(:args) { { folder: File.join(@temp_folder, 'custom_folder') } }

    describe '.filename' do
      subject { instance.filename }

      it { is_expected.to include(File.join('custom_folder', described_class::DEFAULT_FILE_NAME)) }
    end

    describe '#set_project_type' do
      subject { instance.get_project_type(:ruby) }

      context 'before setting project type' do
        it { is_expected.to be_nil }
        it { expect(instance.data[:project_types]).to be_empty }
      end

      context 'after setting project type' do
        before { instance.set_project_type(some_config) }

        let(:some_config) { ruby_config }

        it { is_expected.to eq(ruby_config) }
        it { expect(instance.data[:project_types].length).to eq(1) }

        context 'with altered project type' do
          let(:some_config) { ruby_config.merge(path: '~/new_path') }

          it { is_expected.to eq(some_config) }
          it { expect(instance.data[:project_types].length).to eq(1) }

          context 'with another new project type' do
            subject { instance.get_project_type(:gem, :library) }

            before { instance.set_project_type(gem_library_config) }

            it { is_expected.to eq(gem_library_config) }
            it { expect(instance.data[:project_types].length).to eq(2) }
          end
        end
      end

      context 'config file updates after setting project type' do
        it 'updates the config file' do
          old_json = JSON.parse(File.read(instance.filename))
          instance.set_project_type(gem_library_config)
          new_json = JSON.parse(File.read(instance.filename))
          expect(old_json).to_not eq(new_json)
        end
      end
    end

    context 'github configuration' do
      before { instance.data[:github] = config_github }

      describe '#github_user' do
        subject { instance.github_user }

        it { is_expected.to eq(config_github[:user]) }
      end

      describe '#github_organizations' do
        subject { instance.github_organizations }

        it { is_expected.to eq(config_github[:organizations]) }
      end
    end

    describe '#get_project_type' do
      subject { instance.get_project_type(type, variant) }

      before { instance.data[:project_types] = [ruby_config, gem_library_config, gem_cli_config] }

      let(:type) { 'not_found' }
      let(:variant) { nil }

      context 'when type is not found' do
        it { is_expected.to be_nil }
      end

      context 'when type is valid' do
        let(:type) { :ruby }
        it { is_expected.to include(**ruby_config) }
      end

      context 'when type has variant' do
        let(:type) { :gem }
        context 'when variant is not found' do
          let(:variant) { :unknown }
          it { is_expected.to be_nil }
        end

        context 'when variant is valid' do
          let(:variant) { :library }
          it { is_expected.to include(**gem_library_config) }
        end
      end
    end

    describe '#project_variants' do
      subject { instance.project_variants(type) }

      before { instance.data[:project_types] = [ruby_config, gem_library_config, gem_cli_config] }

      context 'when no variants' do
        let(:type) { :ruby }
        it { is_expected.to be_empty }
      end

      context 'when type has variants' do
        let(:type) { :gem }
        it { is_expected.to eq(%i[library cli]) }
      end
    end
  end
end
