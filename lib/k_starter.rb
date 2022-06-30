# frozen_string_literal: true

require 'pry'

require 'json'
require 'dry-struct'
require 'tty-config'
require 'tty-prompt'
require 'tty-table'
require 'k_util'

require 'dry/cli'
require 'k_doc'
require 'k_manager'
require 'k_manager/cli/base_command'
require 'k_manager/cli/commands'
require 'k_manager/cli/new'

require 'rails/generators/rails/app/app_generator'

require_relative 'k_starter/version'
require_relative 'k_starter/tty_helpers'
require_relative 'k_starter/app_generator'
require_relative 'k_starter/schema'
require_relative 'k_starter/map'
require_relative 'k_starter/database/base_model'
require_relative 'k_starter/database/config_model'
require_relative 'k_starter/database/project_model'
require_relative 'k_starter/questions/base_question'
require_relative 'k_starter/questions/rails'
require_relative 'k_starter/questions/gem'
require_relative 'k_starter/questions/svelte'
require_relative 'k_starter/questions/ask_questions'
require_relative 'k_starter/cli'
require_relative 'k_starter/commands/command'
require_relative 'k_starter/commands/configuration/configuration_menu'
require_relative 'k_starter/commands/project/project_menu'
require_relative 'k_starter/commands/project/select_new_project_type'
require_relative 'k_starter/commands/project/new_project'
require_relative 'k_starter/commands/project/edit_project'
require_relative 'k_starter/commands/project/bootstrap_project'
require_relative 'k_starter/starters/base'
require_relative 'k_starter/starters/gem'
require_relative 'k_starter/starters/nuxt'
require_relative 'k_starter/starters/rails'
require_relative 'k_starter/starters/svelte'

module KStarter
  # raise KStarter::Error, 'Sample message'
  Error = Class.new(StandardError)

  EscapePressed = Class.new(StandardError)
end

if ENV.fetch('KLUE_DEBUG', 'false').downcase == 'true'
  namespace = 'KStarter::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('k_starter/version') }
  version   = KStarter::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
