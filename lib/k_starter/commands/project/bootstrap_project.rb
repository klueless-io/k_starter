# frozen_string_literal: true

module KStarter
  module Commands
    # Submenu for new
    class BootstrapProject < KStarter::Commands::Command
      def initialize(**options)
        @options = options
        super()
      end

      def execute(input: $stdin, output: $stdout)
        display_exiting_projects
        project = select_project

        # Is the if project even relevant at the moment?
        bootstrap_project(project) if project
      end

      def bootstrap_project(project)
        puts JSON.pretty_generate(project.to_h)

        starter = KStarter::Map.starter(project)
        starter.execute
      end
    end
  end
end
