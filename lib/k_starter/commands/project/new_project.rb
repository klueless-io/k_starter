# frozen_string_literal: true

module KStarter
  module Commands
    # Command Name goes here
    class NewProject < KStarter::Commands::Command
      attr_reader :form_type
      attr_reader :form_variant

      def initialize(form_type:, form_variant:)
        @form_type = form_type
        @form_variant = form_variant

        super()
      end

      def execute(input: $stdin, output: $stdout)
        questions = ask_questions(form_type, form_variant)
        questions.ask_questions

        puts JSON.pretty_generate(questions.to_h)
        App.project.save_project(questions)
      rescue KStarter::EscapePressed
        prompt.warn 'Exiting without saving'
      end
    end
  end
end
