# frozen_string_literal: true

module KStarter
  module Database
    # Handle access to project data files
    class ProjectModel < KStarter::Database::BaseModel
      DEFAULT_FILE_NAME = 'k_starter.projects.json'

      # def reset_data
      #   require 'fileutils'

      #   source_file = App.data.find_file

      #   return unless File.exist?(source_file)

      #   backup_folder = App.backup_folder
      #   time = Time.now.strftime('%Y%m%d%H%M%S')

      #   target_file = File.join(backup_folder, "#{time}_#{App::DATA_FILE}")

      #   FileUtils.mkdir_p backup_folder
      #   FileUtils.cp(source_file, target_file)
      #   File.delete(source_file)

      #   @data = nil
      # end

      def initialize(**args)
        args = { file: DEFAULT_FILE_NAME }.merge(args)
        super(**args)

        initialize_model
      end

      def project_list
        @project_list ||= begin
          projects = data[:projects]
          projects.map { |project| KStarter::Map.project(project) }
        end
      end

      def find_project(name, variant = nil)
        index = find_project_index(name, variant)

        return project_list[index] if index
      end

      def find_project_index(name, variant = nil)
        project_list.find_index { |p| p.name == name && (variant.nil? || p.variant == variant) }
      end

      def save_project(project, project_index = nil)
        project = project.to_h unless project.is_a?(Hash)

        index = project_index || find_project_index(project[:name])

        if index.nil?
          data[:projects] << project
        else
          data[:projects][index] = project
        end

        write
        clear_memoization
      end

      private

      def initialize_model
        if File.exist?(filename)
          read
          return
        end

        @data = { projects: [] }

        write
      end

      def clear_memoization
        @project_list = nil
      end

      def read
        @data = JSON.parse(File.read(filename), symbolize_names: true)
      end

      def write
        FileUtils.mkdir_p(File.dirname(filename))
        File.write(filename, JSON.pretty_generate(data))
      end
    end
  end
end
