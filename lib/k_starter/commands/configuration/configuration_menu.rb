# frozen_string_literal: true

module KStarter
  module Commands
    # Submenu for configuration
    class ConfigurationMenu < KStarter::Commands::Command
      def initialize(subcommand, options)
        @subcommand = (subcommand || '').to_sym

        @options = options
        super()
      end

      def execute(input: $stdin, output: $stdout)
        command = nil
        case @subcommand
        when :menu
          menu
        when :open_config
          editor.open(App.config.filename)
          menu
        when :open_project
          editor.open(App.project.filename)
          menu
        end
        command&.execute(input: input, output: output) if command
      end

      private

      def menu
        choices = [
          { name: 'Open configuration JSON', value: :open_config },
          { name: 'Open project JSON', value: :open_project }
        ]

        subcommand = prompt.select('Select your subcommand?', choices, per_page: 15, cycle: true)

        command = KStarter::Commands::ConfigurationMenu.new(subcommand, {})
        command.execute(input: @input, output: @output)
      rescue KStarter::EscapePressed
        nil
      end
    end
  end
end
