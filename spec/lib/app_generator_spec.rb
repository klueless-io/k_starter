# frozen_string_literal: true

RSpec.describe KStarter::AppGenerator do
  include_context :use_temp_folder

  # let(:instance) { described_class.new([temp_folder], opts) }
  let(:folder) { File.expand_path('~/dev/kweb/xmen') }
  let(:instance) { described_class.new([folder], opts) }

  let(:opts) do
    {
      force: true,
      skip_bundle: true,
      skip_git: true,
      skip_hotwire: true,
      dummy_app: true
    }
  end

  subject { instance }

  context 'when running generator' do
    it {
      gem_path = Gem.loaded_specs["railties"].full_gem_path
      defaults_rails_templates = File.join(gem_path, 'lib/rails/generators/rails/app/templates')
      # railties/lib/rails/generators/rails/app/templates
      # /Users/davidcruwys/.asdf/installs/ruby/3.1.1/lib/ruby/gems/3.1.0/gems/railties-7.0.3.1/
      #          lib/rails/generators/rails/app/templates

      # app_path
      # "xmen"
      # destination_root
      # "/Users/davidcruwys/dev/kweb"
      # builder.source_paths
      # ["/Users/davidcruwys/.asdf/installs/ruby/3.1.1/lib/ruby/gems/3.1.0/gems/railties-7.0.3.1/lib/rails/generators/rails/app/templates"]

      subject }
  end

  # fit {subject }
end
