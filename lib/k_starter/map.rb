# frozen_string_literal: true

require 'pry'
require 'date'
require 'thor'

module KStarter
  # Handle the global access such as configuration
  class Map
    class << self
      def project(project_hash)
        case project_hash[:type].to_sym
        when :gem
          KStarter::Schema::GemProject.new(project_hash)
        when :rails
          KStarter::Schema::RailsProject.new(project_hash)
        when :svelte
          KStarter::Schema::SvelteProject.new(project_hash)
        when :nuxt
          KStarter::Schema::NuxtProject.new(project_hash)
        else
          raise "Unknown project type: #{project_hash[:type]}"
        end
      rescue StandardError => e
        puts e.message
      end

      def starter(project_data)
        project = project_data.is_a?(Hash) ? project(project_data) : project_data

        raise "Unknown project type: #{project_data[:type]}" if project.nil?

        case project.type
        when :gem
          KStarter::Starters::Gem.new(project)
        when :rails
          KStarter::Starters::Rails.new(project)
        when :svelte
          KStarter::Starters::Svelte.new(project)
        when :nuxt
          KStarter::Starters::Nuxt.new(project)
        end
      end
    end
  end
end
