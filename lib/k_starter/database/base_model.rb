# frozen_string_literal: true

module KStarter
  module Database
    # Handle access to project data and configuration JSON files
    class BaseModel
      attr_reader :folder
      attr_reader :backup_folder
      attr_reader :filename
      attr_reader :data

      # Split Config and Data into two classes
      def initialize(**args)
        @folder = args[:folder] || '~/.config'
        @folder = File.expand_path(folder)
        @backup_folder = File.join(folder, 'klue_backup')
        @filename = File.join(@folder, args[:file])
      end
    end
  end
end
