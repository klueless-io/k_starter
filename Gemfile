# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rake'
  gem 'rake-compiler', require: false
  gem 'rspec', '~> 3.0'
  gem 'rubocop'
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'simplecov', require: false
end

if ENV['KLUE_LOCAL_GEMS']&.to_s&.downcase == 'true'
  group :development, :test do
    puts 'Using Local GEMs'
    # gem 'handlebars-helpers'      , path: '../../kgems/handlebars-helpers'
    gem 'handlebarsjs'            , path: '../../kgems/handlebarsjs'
    gem 'k_builder'               , path: '../../kgems/k_builder'
    gem 'k_builder-dotnet'        , path: '../../kgems/k_builder-dotnet'
    gem 'k_builder-webpack5'      , path: '../../kgems/k_builder-webpack5'
    gem 'k_config'                , path: '../../kgems/k_config'
    gem 'k_decor'                 , path: '../../kgems/k_decor'
    gem 'k_director'              , path: '../../kgems/k_director'
    gem 'k_doc'                   , path: '../../kgems/k_doc'
    gem 'k_domain'                , path: '../../kgems/k_domain'
    gem 'k_ext-github'            , path: '../../kgems/k_ext-github'
    gem 'k_fileset'               , path: '../../kgems/k_fileset'
    gem 'k_log'                   , path: '../../kgems/k_log'
    gem 'k_manager'               , path: '../../kgems/k_manager'
    gem 'k_type'                  , path: '../../kgems/k_type'
    gem 'k_util'                  , path: '../../kgems/k_util'
    gem 'peeky'                   , path: '../../kgems/peeky'
  end
end
