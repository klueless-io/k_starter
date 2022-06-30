# frozen_string_literal: true

RSpec.describe KStarter do
  it 'has a version number' do
    expect(KStarter::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise KStarter::Error, 'some message' }
      .to raise_error('some message')
  end
end
