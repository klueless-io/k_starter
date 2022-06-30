# frozen_string_literal: true

RSpec.describe KStarter::Database::BaseModel do
  include_context :mock_inputs
  include_context :use_temp_folder

  subject { instance.name }

  let(:instance) { described_class.new(**args) }
  let(:args) { { file: 'some_file.json' } }

  let(:ruby_config) { { type: :ruby, path: '~/webapp' } }

  context 'initialize with default args' do
    describe '.folder' do
      subject { instance.folder }

      it { is_expected.to include('/.config') }
    end

    describe '.backup_folder' do
      subject { instance.backup_folder }

      it { is_expected.to include('/.config/klue_backup') }
    end

    describe '.filename' do
      subject { instance.filename }

      it { is_expected.to include('.config/some_file.json') }
    end
  end

  context 'initialize with custom args' do
    let(:args) { { folder: File.join(@temp_folder, 'custom_folder'), file: 'some_file.json' } }

    describe '.folder' do
      subject { instance.folder }

      it { is_expected.to include('/custom_folder') }
    end

    describe '.backup_folder' do
      subject { instance.backup_folder }

      it { is_expected.to include('/custom_folder/klue_backup') }
    end

    describe '.filename' do
      subject { instance.filename }

      it { is_expected.to include('/custom_folder/some_file.json') }
    end
  end
end
