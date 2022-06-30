# frozen_string_literal: true

module KStarter
  module Commands
    # Submenu for project
    class ProjectMenu < KStarter::Commands::Command
      def initialize(subcommand, options)
        @subcommand = (subcommand || '').to_sym

        @options = options
        super()
      end

      def execute(input: $stdin, output: $stdout)
        command = nil

        loop do
          case @subcommand
          when :new
            command = KStarter::Commands::SelectNewProjectType.new(:menu)
          when :edit
            command = KStarter::Commands::EditProject.new
          when :bootstrap
            command = KStarter::Commands::BootstrapProject.new
          end
          command&.execute(input: input, output: output) if command
          break if menu.nil?
        end
      end

      private

      def menu
        display_exiting_projects

        choices = [
          { name: 'New project settings', value: :new },
          { name: 'Edit project settings', value: :edit },
          { name: 'Bootstrap a project', value: :bootstrap }
        ]

        subcommand = prompt.select('Select your subcommand?', choices, per_page: 15, cycle: true)

        command = KStarter::Commands::ProjectMenu.new(subcommand, {})
        command.execute(input: @input, output: @output)
      rescue KStarter::EscapePressed
        nil
      end
    end
  end
end
