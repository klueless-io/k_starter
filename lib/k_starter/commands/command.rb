# frozen_string_literal: true

require 'forwardable'

module KStarter
  module Commands
    # Base command class
    class Command
      extend Forwardable
      include TtyHelpers

      def_delegators :command, :run

      attr_reader :escape_pressed

      # Execute this command
      #
      # @api public
      def execute(*)
        raise(
          NotImplementedError,
          "#{self.class}##{__method__} must be implemented"
        )
      end

      def ask_questions(form_type, form_variant = nil, **data)
        KStarter::Questions::AskQuestions.for(form_type, form_variant, **data)
      end

      def display_exiting_projects
        columns = %w[Name Type Path Description]
        rows = App.project.project_list.map do |project|
          [
            project.name,
            project.type,
            project.variant,
            project.root_path,
            project.description
          ]
        end

        table = TTY::Table.new(columns, rows)
        puts table.render(:unicode)
        prompt.warn('-' * 100)
      end

      def select_project
        choices = App.project.project_list.map(&:name)
        name = prompt.select('Select a project?', choices, cycle: true)
        App.project.find_project(name)
      end
    end
  end
end
