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
    class Svelte < KStarter::Starters::Base
      def execute
        create_app
        create_kbuilder

        project_open_in_vscode
      end

      private

      def create_app
        if project_path_exist?
          return exiting            if ask_exit_if_project_exists

          project_path_delete       if ask_destroy_existing_project
        end

        system_in_root(script)
        system_in_project('npm install')
      end

      def script
        <<-BASH

        echo "Generating gem project #{project.name}..."
        echo "Current folder: "
        pwd

        #{genesis_vite}

        BASH
      end

      # Alternate technique
      def genesis_sveltekit
        "npm create svelte #{project.name}"
      end

      # This is the current technique
      def genesis_vite
        "npm init vite #{project.name}"
      end

      # deprecated (use vite or sveltekit)
      def genesis_degit
        "npx degit sveltejs/template #{project.name}"
      end
    end
  end
end
