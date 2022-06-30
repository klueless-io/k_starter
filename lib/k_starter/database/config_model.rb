# frozen_string_literal: true

module KStarter
  module Database
    # Handle access to configuration data files
    class ConfigModel < KStarter::Database::BaseModel
      DEFAULT_FILE_NAME = 'k_starter.config.json'

      def initialize(**args)
        args = { file: DEFAULT_FILE_NAME }.merge(args)
        super(**args)

        initialize_model
      end

      # rubocop:disable Naming/AccessorMethodName
      def set_project_type(project_type)
        project_type = project_type.to_h unless project_type.is_a?(Hash)

        index = project_type_index(project_type[:type], project_type[:variant])

        if index.nil?
          data[:project_types] << project_type
        else
          data[:project_types][index] = project_type
        end

        write
      end
      # rubocop:enable Naming/AccessorMethodName

      def get_project_type(type, variant = nil)
        index = project_type_index(type, variant)

        return nil if index.nil?

        @data[:project_types][index]
      end

      def project_variants(type)
        type = as_sym(type)

        # project variants without nil or empty
        data[:project_types]
          .select { |t| t[:type]&.to_sym == type }
          .map { |t| t[:variant]&.to_sym }
          .compact
      end

      def github_user
        data[:github][:user]
      end

      def github_organizations
        data[:github][:organizations]
      end

      private

      def initialize_model
        if File.exist?(filename)
          read
          return
        end

        @data = {
          github: {
            user: 'not_set',
            organizations: []
          },
          project_types: []
        }

        write
      end

      def read
        @data = JSON.parse(File.read(filename), symbolize_names: true)
      end

      def write
        FileUtils.mkdir_p(File.dirname(filename))
        File.write(filename, JSON.pretty_generate(data))
      end

      def project_type_index(type, variant = nil)
        type = as_sym(type)
        variant = as_sym(variant)

        @data[:project_types].find_index { |t| t[:type]&.to_sym == type && (variant.nil? || t[:variant]&.to_sym == variant) }
      end

      def as_sym(value)
        value.to_sym if value.is_a?(String)
        value
      end
    end
  end
end
