# frozen_string_literal: true

module KStarter
  module Questions
    # Ask code generations for a new GEM.
    class BaseGem < BaseQuestion
      attr_reader :exe            # has executable folder
      attr_reader :coc            # has code of conduct
      attr_reader :mit            # has MIT license
      attr_reader :rspec          # has rspec tests

      def initialize(**args)
        args = { type: :gem }.merge(args)
        super(**args)
      end

      def ask_questions
        ask_name
        ask_root_path
        ask_github_key
        ask_description
        story_questions
        klue_template_questions

        ask_exe
        ask_coc
        ask_mit
        ask_rspec
      end

      def to_h
        super.merge(
          {
            exe: exe,
            coc: coc,
            mit: mit,
            rspec: rspec
          }
        )
      end

      def to_dom
        KStarter::Schema::GemProject.new(to_h)
      end

      private

      def initialize_attributes(**args)
        super(**args)

        @exe = args[:exe]
        @coc = args[:coc]
        @mit = args[:mit]
        @rspec = args[:rspec]
      end

      def apply_attribute_defaults
        default_story_active
        default_klue_template_active

        default_exe
        default_coc
        default_mit
        default_rspec
      end

      def question
        @question ||= prompt
      end

      def ask_name
        @name = question.ask('Name (ruby GEM)') do |q|
          q.default(name) unless name.nil?
          q.required(true, 'GEM name is required, and can only contain letters, numbers, and underscores.')
          q.validate(/\A\w+\Z/)
        end
      end

      def ask_exe
        @exe = question.yes?('Has executable folder?', default: exe)
      end

      def default_exe
        @exe = false if @exe.nil?
      end

      def ask_coc
        @coc = question.yes?('Has code of conduct?', default: coc)
      end

      def default_coc
        @coc = true if @coc.nil?
      end

      def ask_mit
        @mit = question.yes?('Has MIT license?', default: mit)
      end

      def default_mit
        @mit = true if @mit.nil?
      end

      def ask_rspec
        @rspec = question.yes?('Has rspec tests?', default: rspec)
      end

      def default_rspec
        @rspec = true if @rspec.nil?
      end
    end

    # Ask code generations for a new Ruby GEM project.
    class LibraryGem < KStarter::Questions::BaseGem
      def initialize(**args)
        args = { variant: :library }.merge(args)
        super(**args)
      end
    end

    # Ask code generations for a new Ruby command line GEM project.
    class CliGem < KStarter::Questions::BaseGem
      def initialize(**args)
        args = { variant: :cli }.merge(args)
        super(**args)
      end

      def default_exe
        @exe = true if @exe.nil?
      end
    end
  end
end
