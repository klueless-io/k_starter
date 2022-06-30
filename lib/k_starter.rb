# frozen_string_literal: true

require_relative 'k_starter/version'

module KStarter
  # raise KStarter::Error, 'Sample message'
  Error = Class.new(StandardError)

  # Your code goes here...
end

if ENV.fetch('KLUE_DEBUG', 'false').downcase == 'true'
  namespace = 'KStarter::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('k_starter/version') }
  version   = KStarter::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
