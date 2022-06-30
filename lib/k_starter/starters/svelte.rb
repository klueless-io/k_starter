# frozen_string_literal: true

# Examples
# bundle gem --coc --ci=github --exe --linter=rubocop --test=rspec --mit k_genesis
# bundle gem --coc --test=rspec --mit k_genesis
# bundle gem --coc --test=rspec --mit conventional_gitflow
# bundle gem --coc --test=rspec --mit k_director
# bundle gem --coc --test=rspec --mit k_config
# bundle gem --coc --test=rspec --mit funky
# bundle gem --coc --test=rspec --mit --linter=rubocop --ci-github cmdlet
# bundle gem --coc --test=rspec --mit cmdlet
# bundle gem --coc --test=rspec --mit drawio_dsl
# bundle gem --coc --test=rspec --mit tailwind_dsl
# bundle gem --coc --test=rspec --mit test-google-cloud-functions
# bundle gem --coc --test=rspec --mit test_google_cloud_functions
# bundle gem --coc --test=rspec --mit handlebarsjs
# bundle gem --coc --test=rspec --mit k_starter

module KStarter
  module Starters
    # Generate command line for a new ruby gem project.
    class Svelte
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def execute
        script
      end

      private

      def script
        <<-BASH

        cd #{data.root_path}
        npx degit sveltejs/template #{data.name}

        BASH
      end
    end
  end
end
