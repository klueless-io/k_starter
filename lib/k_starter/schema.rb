# frozen_string_literal: true

module Types
  include Dry.Types()
end

module KStarter
  # Schema for storing model data for projects and other configuration data
  module Schema
    # Configuration class for the project types
    class ProjectType < Dry::Struct
      attribute :type                             , Types::Coercible::Symbol
      attribute :variant                          , Types::Coercible::Symbol.optional.default(nil)
      attribute :path                             , Types::Strict::String
    end

    class Github < Dry::Struct
      attribute :user                             , Types::Strict::String
      attribute :organizations                    , Types::Array.of(Types::Coercible::String)
    end

    # User story node
    class Story < Dry::Struct
      attribute :active                           , Types::Strict::Bool
      attribute :actor                            , Types::Strict::String.optional.default(nil)
      attribute :problem                          , Types::Strict::String.optional.default(nil)
      attribute :solution                         , Types::Strict::String.optional.default(nil)
      attribute :user_story                       , Types::Strict::String.optional.default(nil)
    end

    # Klue template node
    class KlueTemplate < Dry::Struct
      attribute :active                           , Types::Strict::Bool
      attribute :name                             , Types::Strict::String.optional.default(nil)
    end

    # Base class for project data
    class BaseProject < Dry::Struct
      attribute :name                             , Types::Strict::String
      attribute :type                             , Types::Coercible::Symbol
      attribute :variant                          , Types::Coercible::Symbol.optional.default(nil)
      attribute :root_path                        , Types::Strict::String # .constructor { |path| File.expand_path(path) }
      attribute :description                      , Types::Strict::String.optional.default(nil)
      attribute :story                            , KStarter::Schema::Story
      attribute :klue_template                    , KStarter::Schema::KlueTemplate
      attribute :github_key                       , Types::Strict::String

      def expanded_project_path
        File.join(expanded_root_path, name)
      end

      def expanded_root_path
        File.expand_path(root_path)
      end

      def github_account_type
        github_key == App.config.github_user ? :user : :organization
      end

      def github_organization
        github_account_type == :organization ? github_key : nil
      end
    end

    class RailsProject < BaseProject
      attribute :include_action_text              , Types::Strict::Bool
      attribute :include_active_storage           , Types::Strict::Bool
      attribute :include_sample_models            , Types::Strict::Bool
      attribute :include_javascript_libraries     , Types::Strict::Bool
      attribute :include_devise                   , Types::Strict::Bool
      attribute :include_rspec                    , Types::Strict::Bool
      attribute :include_common_pages             , Types::Strict::Bool
      attribute :run_db_migrate                   , Types::Strict::Bool
    end

    class GemProject < BaseProject
      attribute :exe                             , Types::Strict::Bool
      attribute :coc                             , Types::Strict::Bool
      attribute :mit                             , Types::Strict::Bool
      attribute :rspec                           , Types::Strict::Bool
    end

    class SvelteProject < BaseProject
    end

    class NuxtProject < BaseProject
    end
  end
end
