# frozen_string_literal: true

module KStarter
  module Commands
    # Submenu for new
    class EditProject < KStarter::Commands::Command
      def initialize(**options)
        @options = options
        super()
      end

      def execute(input: $stdin, output: $stdout)
        display_exiting_projects
        project = select_project

        # Is the if project even relevant at the moment?
        edit_project(project) if project
      end

      def edit_project(project)
        form_type = project.type.to_sym
        form_variant = project.variant&.to_sym

        questions = ask_questions(form_type, form_variant, **project.to_h)
        questions.ask_questions

        puts JSON.pretty_generate(questions.to_h)
        App.project.save_project(questions)
      rescue KStarter::EscapePressed
        prompt.warn 'Exiting without saving'
      end
    end
  end
end
