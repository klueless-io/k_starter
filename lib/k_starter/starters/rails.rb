# frozen_string_literal: true

module KStarter
  module Starters
    # Generate command line for a new ruby gem project.
    class Rails
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def execute
        # script
      end

      private

      # def script
      #   <<-BASH

      #   cd #{data.root_path}
      #   npx degit sveltejs/template #{data.name}

      #   BASH
      # end
    end
  end
end
