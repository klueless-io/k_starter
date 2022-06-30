# frozen_string_literal: true

# see: bundle --help
# example: bundle gem --coc --test=rspec --mit k_project
# km2 new k_project -t ruby_gem \
#   --description "k_project is a command line GEM for building new ruby, rails and other language projects" \
#   --user-story "As a Developer, I want a simple path to creating new projects in different languages, so that I be productive quickly"

module KStarter
  module Questions
    # Ask code generations for a new projects.
    class BaseQuestion
      include TtyHelpers

      attr_reader :name                   # project name
      attr_reader :type                   # project type
      attr_reader :variant                # project variant
      attr_reader :root_path              # project root path
      attr_reader :sub_path               # project sub path, useful for folders under the root such as klueless projects
      attr_reader :github_key             # github user_name or organization name
      attr_reader :description            # project description
      attr_reader :story_active           # is story required?
      attr_reader :actor                  # who is the actor
      attr_reader :problem                # what problem do they have
      attr_reader :solution               # what is the intended solution
      attr_reader :user_story             # what is the primary user story
      attr_reader :klue_template_active   # is klue_template used?
      attr_reader :klue_template_name     # name of the klue template

      def initialize(**args)
        initialize_attributes(**args)
        apply_attribute_defaults
        clean_attributes
      end

      def default_questions; end

      def question
        @question ||= prompt
      end

      def ask_root_path
        project_type_config = App.config.get_project_type(type, variant)
        configured_path = project_type_config.nil? ? '~/unknown_project' : project_type_config[:path]

        @root_path = question.ask('Root project path') do |q|
          q.default(configured_path)
          q.required(true)
        end
      end

      def ask_sub_path
        project_type_config = App.config.get_project_type(type, variant)
        configured_path = project_type_config.nil? ? '~/unknown_project' : project_type_config[:sub_path]

        @sub_path = question.ask('Sub path within the project') do |q|
          q.default(configured_path)
          q.required(true)
        end
      end

      def ask_github_key
        choices = [App.config.github_user] + App.config.github_organizations
        @github_key = prompt.select('Select Github user or organization', choices, cycle: true, filter: true, default: @github_key)
      end

      def ask_description
        @description = question.ask('Description', default: @description)
      end

      def ask_story_active?
        @story_active = question.yes?('Is a user story required?', default: @story_active)
        show_story(actor: @actor, problem: @problem, solution: @solution)
        @story_active
      end

      def ask_actor
        @actor = prompt.ask('Who is the primary actor for this project?', default: @actor || 'Developer')
        # show_story(actor: @actor)
      end

      def ask_problem
        @problem = question.ask('What problem are you solving?', default: @problem)
        # show_story(actor: @actor, problem: @problem)
      end

      def ask_solution
        @solution = question.ask('What is the intended solution?', default: @solution)
        # show_story(actor: @actor, problem: @problem, solution: @solution)
      end

      def show_story(**args)
        prompt.warn("As a #{args[:actor] || 'ACTOR'}, I want to #{args[:problem] || 'SOLVE PROBLEM'} so that I can #{args[:solution] || 'HAVE BENEFIT'}")
      end

      def ask_user_story
        @user_story = question.ask('User Story', default: "As a #{actor}, I want to #{problem} so that I can #{solution}")
      end

      def story_questions
        return unless ask_story_active?

        ask_actor
        ask_problem
        ask_solution
        ask_user_story
      end

      # ask_user_story

      def ask_klue_template_active?
        @klue_template_active = question.yes?('Does this project use a Klue Templates?', default: @klue_template_active)
        @klue_template_active
      end

      def ask_klue_template_name
        prompt.warn('Location: ~/dev/kgems/k_templates/definitions/starter')
        @klue_template_name = prompt.ask('Klue starter template name', default: infer_klue_template_name(@klue_template_name)) do |q|
          q.required(true)
        end
      end

      def klue_template_questions
        return unless ask_klue_template_active?

        ask_klue_template_name
      end

      def infer_klue_template_name(klue_template_name)
        return klue_template_name unless klue_template_name.nil?

        case type
        when :rails, :svelte, :nuxt3
          return type.to_s
        when :gem
          # return variant == :library ? 'ruby_gem' : 'ruby_gem_cli'
          return 'ruby_gem'
        end
        nil
      end

      def default_story_active
        @story_active = true if @story_active.nil?
      end

      def default_klue_template_active
        @klue_template_active = true if @klue_template_active.nil?
      end

      def to_h
        {
          name: name,
          type: type,
          variant: variant,
          root_path: root_path,
          description: description,
          github_key: github_key,
          story: {
            active: story_active,
            actor: actor,
            problem: problem,
            solution: solution,
            user_story: user_story
          },
          klue_template: {
            active: klue_template_active,
            name: klue_template_name
          }
        }
      end

      private

      def initialize_attributes(**args)
        @name = args[:name]
        @type = args[:type]
        @variant = args[:variant]
        @root_path = args[:root_path]
        @sub_path = args[:sub_path]
        @github_key = args[:github_key]
        @description = args[:description]
        @story_active = args.dig(:story, :active)
        @actor = args.dig(:story, :actor)
        @problem = args.dig(:story, :problem)
        @solution = args.dig(:story, :solution)
        @user_story = args.dig(:story, :user_story)
        @klue_template_active = args.dig(:klue_template, :active)
        @klue_template_name = args.dig(:klue_template, :name)
      end

      def apply_attribute_defaults; end

      def clean_attributes
        @story_active = handle_boolean(@story_active)
        @klue_template_active = handle_boolean(@klue_template_active)
      end

      def handle_boolean(value)
        case value
        when true, 'true', 't', 'yes', 'y', '1'
          true
        else
          false
        end
      end
    end
  end
end
