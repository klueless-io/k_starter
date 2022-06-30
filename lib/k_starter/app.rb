# frozen_string_literal: true

module KStarter
  # Handle the global access such as configuration, project data
  class App
    class << self
      def config
        @config ||= KStarter::Database::ConfigModel.new
      end

      def project
        @project ||= KStarter::Database::ProjectModel.new
      end
    end
  end
end
