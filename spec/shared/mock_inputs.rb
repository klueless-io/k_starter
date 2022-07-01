# frozen_string_literal: true

shared_context :mock_inputs do
  let(:config_project_type) do
    {
      type: :gem,
      variant: 'library',
      path: '~/dev/kgems'
    }
  end

  let(:config_github) do
    {
      user: 'klueless-io',
      organizations: %w[klueless-tut-js klueless-sites]
    }
  end

  let(:data_story) do
    {
      active: true,
      actor: 'Developer',
      problem: 'fix bugs quickly',
      solution: 'can be more productive',
      user_story: 'As a developer, I want to fix bugs quickly, so that I can be more productive.'
    }
  end

  let(:data_klue_template) do
    {
      active: true,
      name: 'gem'
    }
  end

  let(:data_base_project) do
    {
      name: 'some_project',
      type: :unknown,
      root_path: '~/dev/some_root',
      description: 'this is a an awesome some_project',
      github_key: 'klueless-io',
      story: data_story,
      klue_template: data_klue_template
    }
  end

  let(:data_rails_project) do
    {
      name: 'webapp',
      type: :rails,
      root_path: '~/dev/webapp',
      description: 'this is a an awesome webapp',
      github_key: 'klueless-io',
      story: data_story,
      klue_template: data_klue_template,
      include_action_text: true,
      include_active_storage: true,
      include_sample_models: true,
      include_javascript_libraries: true,
      include_devise: true,
      include_rspec: true,
      include_common_pages: true,
      run_db_migrate: true
    }
  end

  let(:data_gem_library_project) do
    {
      name: 'my_gem_library',
      type: :gem,
      variant: :library,
      root_path: '~/dev/kgems',
      description: 'this is a an awesome ruby gem',
      github_key: 'klueless-io',
      story: data_story,
      klue_template: data_klue_template,
      exe: true,
      coc: true,
      mit: true,
      rspec: true
    }
  end

  let(:data_gem_cli_project) do
    {
      name: 'my_gem_cli',
      type: :gem,
      variant: :cli,
      root_path: '~/dev/kgems',
      description: 'this is a an awesome ruby gem',
      github_key: 'klueless-io',
      story: data_story,
      klue_template: data_klue_template,
      exe: true,
      coc: true,
      mit: true,
      rspec: true
    }
  end

  let(:data_kbuilder_project) do
    {
      name: '.builder',
      type: :k_builder,
      root_path: '~/dev/some_path',
      description: 'this is a kbuilder addon to a project',
      github_key: 'klueless-io',
      story: data_story,
      klue_template: data_klue_template
    }
  end

  let(:data_svelte_project) do
    {
      name: 'my_first_svelte_app',
      type: :svelte,
      root_path: '~/dev/tut-js',
      description: 'this is my first svelte application',
      github_key: 'klueless-io',
      story: data_story,
      klue_template: data_klue_template
    }
  end

  let(:data_nuxt_project) do
    {
      name: 'my_first_nuxt_app',
      type: :nuxt,
      root_path: '~/dev/tut-js',
      description: 'this is my first nuxt application',
      github_key: 'klueless-io',
      story: data_story,
      klue_template: data_klue_template
    }
  end
end
