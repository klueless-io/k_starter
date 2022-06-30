# frozen_string_literal: true

# source: https://stephenagrice.medium.com/making-a-command-line-ruby-gem-write-build-and-push-aec24c6c49eb

GEM_NAME = 'k_starter'

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'k_starter/version'

RSpec::Core::RakeTask.new(:spec)

require 'rake/extensiontask'

desc 'Compile all the extensions'
task build: :compile

Rake::ExtensionTask.new('k_starter') do |ext|
  ext.lib_dir = 'lib/k_starter'
end

desc 'Publish the gem to RubyGems.org'
task :publish do
  version = KStarter::VERSION
  system 'gem build'
  system "gem push #{GEM_NAME}-#{version}.gem"
end

desc 'Remove old *.gem files'
task :clean do
  system 'rm *.gem'
end

task default: %i[clobber compile spec]
