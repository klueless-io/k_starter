# frozen_string_literal: true

module KStarter
  module Commands
    # Submenu for forms
    class SelectNewProjectType < KStarter::Commands::Command
      def initialize(subcommand, **options)
        @subcommand = (subcommand || '').to_sym

        @options = options
        super()
      end

      def execute(input: $stdin, output: $stdout)
        command = nil
        case @subcommand
        when :menu
          command = select_new_project_type
        end
        command&.execute(input: input, output: output)
      end

      private

      def select_new_project_type
        prompt.warn('Forms for project settings')

        choices = [
          { name: 'Rails'                       , value: { type: :rails, variant: nil } },
          { name: 'Ruby library (GEM)'          , value: { type: :gem, variant: :library } },
          { name: 'Ruby Command line Ruby (GEM)', value: { type: :gem, variant: :cli } },
          { name: 'Svelte'                      , value: { type: :svelte, variant: nil } }
        ]

        prompt.warn('What type of project are you creating?')
        form = prompt.select('Select project type?', choices, per_page: 15, cycle: true)

        KStarter::Commands::NewProject.new(form_type: form[:type], form_variant: form[:variant])
      rescue KStarter::EscapePressed
        nil
      end
    end
  end
end
