# frozen_string_literal: true

# rm -rf kweb01-devise && rails new kweb01-devise -m ~/dev/kgems/k_templates/templates/ruby/rails_app/r7_hotwire.rb

module KStarter
  module Starters
    # Generate command line for a new ruby gem project.
    class Rails < KStarter::Starters::Base
      def execute
        create_rails
        create_kbuilder

        project_open_in_vscode
      end

      private

      def create_rails
        if project_path_exist?
          return exiting            if ask_exit_if_project_exists

          project_path_delete       if ask_destroy_existing_project
        end

        system_in_root(build_create_rails_bash)
      end

      def build_create_rails_bash
        <<-BASH

        echo "Generating rails project #{project.name}..."
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
        bundle_gem << 'rails new kweb01-devise -m ~/dev/kgems/k_templates/templates/ruby/rails_app/r7_hotwire.rb'
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
