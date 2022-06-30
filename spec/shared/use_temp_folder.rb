# frozen_string_literal: true

shared_context :use_temp_folder do
  around do |example|
    Dir.mktmpdir('rspec-') do |folder|
      @temp_folder = folder
      example.run
    end
  end

  attr_reader :temp_folder
end
