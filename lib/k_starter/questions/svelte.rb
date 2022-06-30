# frozen_string_literal: true

module KStarter
  module Questions
    # Ask code generations for a new GEM.
    class Svelte < BaseQuestion
      def initialize(**args)
        args = { type: :svelte }.merge(args)
        super(**args)
      end

      def ask_questions
        ask_name
        ask_root_path
        ask_github_key
        ask_description
        story_questions
        klue_template_questions
      end

      def to_h
        super.merge(
          {
          }
        )
      end

      def to_dom
        KStarter::Schema::SvelteProject.new(to_h)
      end

      private

      def apply_attribute_defaults
        default_story_active
        default_klue_template_active
      end

      def question
        @question ||= prompt
      end

      def ask_name
        @name = question.ask('Name (Svelte Application)') do |q|
          q.default(name) unless name.nil?
          q.required(true, 'Svelte application name is required, and can only contain letters, numbers, and underscores.')
          q.validate(/\A\w+\Z/)
        end
      end
    end
  end
end
