# frozen_string_literal: true

RSpec.describe KStarter::Starters::Base do
  include_context :use_temp_folder # :temp_folder
  include_context :mock_inputs

  subject { instance }

  let(:instance) { described_class.new(project, **args) }
  let(:project_data) { data_gem_library_project.merge(root_path: File.join(temp_folder)) }
  let(:project) { KStarter::Map.project(project_data) }
  let(:args) { {} }

  describe '#ask_destroy_existing_project' do
    it 'should be a method' do
      expect(instance).to respond_to(:ask_destroy_existing_project)
    end

    # it { puts instance.ask_destroy_existing_project }
  end

  describe '#code_open_delay' do
    subject { instance.code_open_delay }

    it { is_expected.to eq(0) }

    context 'when code_open_delay argument provided' do
      let(:args) { { code_open_delay: 5 } }

      it { is_expected.to eq(5) }
    end
  end

  describe '#project_path_exist' do
    subject { instance.project_path_exist? }

    it { is_expected.to be_falsey }

    context 'when project path exists' do
      before { FileUtils.mkdir_p(instance.project.expanded_project_path) }

      it { is_expected.to be_truthy }
    end
  end

  describe '#project_path_delete' do
    subject { instance.project_path_exist? }

    before { FileUtils.mkdir_p(instance.project.expanded_project_path) }

    it { is_expected.to be_truthy }

    context 'after delete' do
      before { instance.project_path_delete }

      it { is_expected.to be_falsey }
    end
  end
end
