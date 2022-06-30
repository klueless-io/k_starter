# frozen_string_literal: true

RSpec.describe KStarter::App do
  describe '.config' do
    let(:config) { described_class.config }

    context '.filename' do
      subject { config.filename }

      it { is_expected.not_to be_empty }
    end
  end

  describe '.project' do
    let(:project) { described_class.project }

    context '.filename' do
      subject { project.filename }

      it { is_expected.not_to be_empty }
    end
  end
end
