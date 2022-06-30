# frozen_string_literal: true

module KStarter
  module Questions
    # Select a form with questions and load it up as a New form or
    # an Edit form by optionally providing data
    class AskQuestions
      class << self
        def for(form_type, form_variant = nil, **data)
          return KStarter::Questions::Rails.new(**data)       if form_type == :rails
          return KStarter::Questions::LibraryGem.new(**data)  if form_type == :gem && form_variant == :library
          return KStarter::Questions::CliGem.new(**data)      if form_type == :gem && form_variant == :cli
          return KStarter::Questions::Svelte.new(**data)      if form_type == :svelte

          raise "Unknown form type: #{form_type}"
        end
              end
    end
  end
end
