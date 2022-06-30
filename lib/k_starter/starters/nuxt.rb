# frozen_string_literal: true

module KStarter
  module Starters
    # Generate command line for a new ruby gem project.
    class Nuxt
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def execute
        script
      end

      private

      def script
        <<-BASH

        cd #{data.root_path}
        npx nuxi init #{data.name}

        BASH
      end
    end
  end
end
