# frozen_string_literal: true

module KStarter
  module Starters
    # Generate command line for a new ruby gem project.
    class Nuxt < KStarter::Starters::Base
      def execute
        script
      end

      private

      def script
        <<-BASH

        cd #{project.root_path}
        npx nuxi init #{project.name}

        BASH
      end
    end
  end
end
