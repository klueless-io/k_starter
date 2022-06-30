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
# bundle gem --coc --test=rspec --mit handlebarsjs
# bundle gem --coc --test=rspec --mit k_starter

module KStarter
  module Starters
    # Generate command line for a new ruby gem project.
    class Gem < KStarter::Starters::Base
      def execute
        create_gem
        create_kbuilder

        project_open_in_vscode
      end

      private

      def create_gem
        if project_path_exist?
          return exiting            if ask_exit_if_project_exists

          project_path_delete       if ask_destroy_existing_project
        end

        system_in_root(build_create_gem_bash)
      end

      def build_create_gem_bash
        <<-BASH

        echo "Generating gem project #{project.name}..."
        echo "Ruby version:"
        ruby -v
        echo "Current folder: "
        pwd
        # create the gem
        #{build_bundle_gem}

        BASH
      end

      # rubocop:disable Metrics/AbcSize
      def build_bundle_gem
        # bundle gem --coc --exe --test=rspec --mit k_genesis

        bundle_gem = []
        bundle_gem << 'bundle gem'
        bundle_gem << '--coc' if project.coc
        bundle_gem << '--exe' if project.exe
        bundle_gem << '--mit' if project.mit
        bundle_gem << '--test=rspec' if project.rspec
        bundle_gem << project.name.to_s
        bundle_gem.join(' ')
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
