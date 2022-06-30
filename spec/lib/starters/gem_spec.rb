# frozen_string_literal: true

RSpec.describe KStarter::Starters::Gem do
  include_context :use_temp_folder # :temp_folder
  include_context :mock_inputs

  subject { instance }

  let(:args) { {} }
  let(:instance) { described_class.new(project, **args) }
  let(:project_data) { data_gem_library_project.merge(root_path: File.join(temp_folder)) }
  let(:project) { KStarter::Map.project(project_data) }

  describe '#build_create_gem_bash' do
    subject { instance.send(:build_create_gem_bash) }

    it { is_expected.to include('bundle gem --coc --exe --mit --test=rspec my_gem_library') }
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
