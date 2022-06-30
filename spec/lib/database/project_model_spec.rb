# frozen_string_literal: true

RSpec.describe KStarter::Database::ProjectModel do
  include_context :mock_inputs
  include_context :use_temp_folder

  subject { instance.name }

  let(:instance) { described_class.new(**args) }
  let(:args) { {} }

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

    describe '#project_list' do
      subject { instance.project_list }

      before { instance.data[:projects] = [data_rails_project, data_gem_library_project] }

      it { expect(subject.length).to eq(2) }
      it { expect(subject[0]).to be_a(KStarter::Schema::RailsProject) }
      it { expect(subject[1]).to be_a(KStarter::Schema::GemProject) }
    end

    describe '#find_project_index' do
      subject { instance.find_project_index(name, variant) }

      before { instance.data[:projects] = sample_projects }

      let(:sample_projects) { [data_rails_project, data_gem_library_project, data_gem_cli_project] }
      let(:name) { 'not_found' }
      let(:variant) { nil }

      context 'when project is not found' do
        it { is_expected.to be_nil }
      end

      context 'when project is found' do
        let(:name) { 'my_gem_library' }

        it { is_expected.to eq(1) }
      end

      context 'when project is found with variant' do
        let(:name) { 'my_gem_library' }
        let(:sample_projects) { [data_rails_project, data_gem_library_project, data_gem_library_project.merge(variant: :xxx)] }
        context 'when :library variant' do
          let(:variant) { :library }

          it { is_expected.to eq(1) }
        end

        context 'when :xxx variant' do
          let(:variant) { :xxx }

          it { is_expected.to eq(2) }
        end
      end
    end

    describe '#find_project' do
      subject { instance.find_project(name) }

      before { instance.data[:projects] = [data_rails_project, data_gem_library_project, data_gem_cli_project] }

      let(:name) { 'not_found' }

      context 'when project is not found' do
        it { is_expected.to be_nil }
      end

      context 'when project is found' do
        let(:name) { 'webapp' }

        it { is_expected.to be_a(KStarter::Schema::RailsProject) }
      end
    end

    describe '#save_project' do
      let(:project) { data_rails_project }

      context 'when saving a new project' do
        it 'adds the project to the list' do
          expect { instance.save_project(project) }.to change { instance.project_list.length }.by(1)
        end
      end

      context 'when saving an existing project' do
        before { instance.save_project(project) }

        it 'updates the project in the list' do
          expect do
            instance.save_project(data_rails_project.merge(description: 'an awesome webapp'))
          end
            .to change { instance.project_list.first.description }
            .from('this is a an awesome webapp')
            .to('an awesome webapp')
        end
      end

      context 'data file updates after setting a project' do
        it 'updates the data file' do
          old_json = JSON.parse(File.read(instance.filename))
          instance.save_project(data_rails_project)
          new_json = JSON.parse(File.read(instance.filename))
          expect(old_json).to_not eq(new_json)

          instance.save_project(data_rails_project.merge(description: 'an awesome webapp'))
          update_json = JSON.parse(File.read(instance.filename))
          expect(new_json).to_not eq(update_json)

          expect(old_json['projects']).to be_empty
          expect(new_json['projects'].length).to eq(1)
          expect(update_json['projects'].length).to eq(1)
        end
      end

      # context 'when saving a project with conflicting type' do
      #   let(:project) { data_gem_library_project }

      #   it 'raises an error' do
    end
  end
end
