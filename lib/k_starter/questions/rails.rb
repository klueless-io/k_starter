# frozen_string_literal: true

module KStarter
  module Questions
    # Ask code generations for a new GEM.
    class Rails < BaseQuestion
      attr_reader :include_action_text
      attr_reader :include_active_storage
      attr_reader :include_sample_models
      attr_reader :include_javascript_libraries
      attr_reader :include_devise
      attr_reader :include_rspec
      attr_reader :include_common_pages
      attr_reader :run_db_migrate

      def initialize(**args)
        args = { type: 'rails' }.merge(args)
        super(**args)
      end

      def ask_questions
        ask_name
        ask_root_path
        ask_github_key
        ask_description
        story_questions
        klue_template_questions

        ask_include_action_text
        ask_include_active_storage
        ask_include_sample_models
        ask_include_javascript_libraries
        ask_include_devise
        ask_include_rspec
        ask_include_common_pages
        ask_run_db_migrate
      end

      def to_h
        super.merge(
          {
            include_action_text: include_action_text,
            include_active_storage: include_active_storage,
            include_sample_models: include_sample_models,
            include_javascript_libraries: include_javascript_libraries,
            include_devise: include_devise,
            include_rspec: include_rspec,
            include_common_pages: include_common_pages,
            run_db_migrate: run_db_migrate
          }
        )
      end

      def to_dom
        KStarter::Schema::RailsProject.new(to_h)
      end

      private

      def initialize_attributes(**args)
        super(**args)

        @include_action_text = args[:include_action_text]
        @include_active_storage = args[:include_active_storage]
        @include_sample_models = args[:include_sample_models]
        @include_javascript_libraries = args[:include_javascript_libraries]
        @include_devise = args[:include_devise]
        @include_rspec = args[:include_rspec]
        @include_common_pages = args[:include_common_pages]
        @run_db_migrate = args[:run_db_migrate]
      end

      def apply_attribute_defaults
        default_story_active
        default_klue_template_active

        default_include_action_text
        default_include_active_storage
        default_include_sample_models
        default_include_javascript_libraries
        default_include_devise
        default_include_rspec
        default_include_common_pages
        default_run_db_migrate
      end

      def ask_name
        @name = question.ask('Name (rails application)') do |q|
          q.default(name) unless name.nil?
          q.required(true, 'Rails application name is required, and can only contain letters, numbers, and underscores.')
          q.validate(/\A\w+\Z/)
        end
      end

      def ask_include_action_text
        @include_action_text = question.yes?('Include Action Text', default: include_action_text)
      end

      def ask_include_active_storage
        @include_active_storage = question.yes?('Include Active Storage', default: include_active_storage)
      end

      def ask_include_sample_models
        @include_sample_models = question.yes?('Include Sample Models', default: include_sample_models)
      end

      def ask_include_javascript_libraries
        @include_javascript_libraries = question.yes?('Include Javascript Libraries', default: include_javascript_libraries)
      end

      def ask_include_devise
        @include_devise = question.yes?('Include Devise', default: include_devise)
      end

      def ask_include_rspec
        @include_rspec = question.yes?('Include Rspec', default: include_rspec)
      end

      def ask_include_common_pages
        @include_common_pages = question.yes?('Include Common Pages', default: include_common_pages)
      end

      def ask_run_db_migrate
        @run_db_migrate = question.yes?('DB Migrate', default: run_db_migrate)
      end

      # defaults

      def default_include_action_text
        @include_action_text = true if @include_action_text.nil?
      end

      def default_include_active_storage
        @include_active_storage = true if @include_active_storage.nil?
      end

      def default_include_sample_models
        @include_sample_models = true if @include_sample_models.nil?
      end

      def default_include_javascript_libraries
        @include_javascript_libraries = true if @include_javascript_libraries.nil?
      end

      def default_include_devise
        @include_devise = true if @include_devise.nil?
      end

      def default_include_rspec
        @include_rspec = true if @include_rspec.nil?
      end

      def default_include_common_pages
        @include_common_pages = true if @include_common_pages.nil?
      end

      def default_run_db_migrate
        @run_db_migrate = true if @run_db_migrate.nil?
      end
    end
  end
end
