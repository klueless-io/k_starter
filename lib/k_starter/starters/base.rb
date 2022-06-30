# frozen_string_literal: true

module KStarter
  module Starters
    # Generate command line for a new ruby gem project.
    class Base
      include TtyHelpers

      attr_reader :project
      attr_reader :code_open_delay

      def initialize(project, **args)
        @project = project
        @code_open_delay = args[:code_open_delay] || 0
      end

      def system_in_root(script)
        Dir.chdir(project.expanded_root_path) do
          system script
        end
      end

      def system_in_project(script)
        Dir.chdir(project.expanded_project_path) do
          system script
        end
      end

      def project_path_exist?
        File.exist?(project.expanded_project_path)
      end

      def project_path_delete
        return unless project_path_exist?

        FileUtils.rm_rf(project.expanded_project_path)
      end

      def project_open_in_vscode
        sleep code_open_delay if code_open_delay.positive?

        Dir.chdir(project.expanded_project_path) do
          system('code .')
        end
      end

      def ask_destroy_existing_project
        question.yes?('Do you want to destroy the existing project folder')
      end

      def ask_exit_if_project_exists
        question.yes?('This project exists. Do you want to cancel new project creation?')
      end

      def exiting(message = 'Exiting')
        question.warn(message)
        nil
      end

      def create_kbuilder
        KManager::Cli::Commands::New.new.call(
          project_folder: project.expanded_project_path,
          builder_folder: File.join(project.expanded_project_path, '.builders'),
          description: project.description,
          user_story: project.story.user_story,
          repo_organization: project.github_organization,
          template: project.klue_template.name,
          log_level: nil,
          force: true
        )
      end

      private

      def question
        @question ||= prompt
      end
    end
  end
end
