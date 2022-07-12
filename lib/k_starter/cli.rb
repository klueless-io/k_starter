# frozen_string_literal: true

require 'thor'

module KStarter
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'k_starter version'
    def version
      require_relative 'version'
      puts "v#{KStarter::VERSION}"
    end
    map %w[--version -v] => :version

    #
    # config
    #
    # desc 'config KEYVALUE', 'Config description'
    # method_option :help, aliases: '-h',
    #                      type: :boolean,
    #                      desc: 'Display usage information'
    # def config(key, value)
    #   if options[:help]
    #     invoke :help, ['config']
    #   else
    #     KStarter::Commands::Configuration::Menu.new(key, value, options).execute
    #   end
    # end

    #
    # configuration
    #
    desc 'configuration SUBCOMMAND', 'Manage configuration'
    method_option :help, aliases: '-h',
                         type: :boolean,
                         desc: 'Display usage information'
    def configuration(subcommand = :menu)
      if options[:help]
        invoke :help, ['configuration']
      else
        KStarter::Commands::ConfigurationMenu.new(subcommand, options).execute
      end
    end

    #
    # project
    #
    desc 'project SUBCOMMAND', 'Create or edit project settings or generate new project'
    def project(subcommand = :menu)
      if options[:help]
        invoke :help, ['project']
      else
        system('ruby -v')
        KStarter::Commands::ProjectMenu.new(subcommand, options).execute
      end
    end
  end
end
