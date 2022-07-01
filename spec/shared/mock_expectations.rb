# frozen_string_literal: true

RSpec.shared_examples :expected_project_type do
  it 'has the correct attributes' do
    is_expected.to include(
      type: :gem,
      variant: :library,
      path: '~/dev/kgems'
    )
  end
end

RSpec.shared_examples :expected_github do
  it 'has the correct attributes' do
    is_expected.to include(
      user: 'klueless-io',
      organizations: %w[klueless-tut-js klueless-sites]
    )
  end
end

RSpec.shared_examples :expected_data_story do
  it 'has the correct attributes' do
    is_expected.to include(
      active: true,
      actor: 'Developer',
      problem: 'fix bugs quickly',
      solution: 'can be more productive',
      user_story: 'As a developer, I want to fix bugs quickly, so that I can be more productive.'
    )
  end
end

RSpec.shared_examples :expected_data_klue_template do
  it 'has the correct attributes' do
    is_expected.to include(
      active: true,
      name: 'gem'
    )
  end
end

RSpec.shared_examples :expected_data_base_project do
  it 'has the correct attributes' do
    is_expected.to include(
      name: 'some_project',
      type: :unknown,
      variant: nil,
      root_path: '~/dev/some_root',
      description: 'this is a an awesome some_project',
      github_key: 'klueless-io',
      story: include(
        active: true,
        actor: 'Developer',
        problem: 'fix bugs quickly',
        solution: 'can be more productive',
        user_story: 'As a developer, I want to fix bugs quickly, so that I can be more productive.'
      ),
      klue_template: include(
        active: true,
        name: 'gem'
      )
    )
  end
end

RSpec.shared_examples :expected_data_rails_project do
  it 'has the correct attributes' do
    is_expected.to include(
      name: 'webapp',
      type: :rails,
      variant: nil,
      root_path: '~/dev/webapp',
      description: 'this is a an awesome webapp',
      github_key: 'klueless-io',
      story: include(
        active: true,
        actor: 'Developer',
        problem: 'fix bugs quickly',
        solution: 'can be more productive',
        user_story: 'As a developer, I want to fix bugs quickly, so that I can be more productive.'
      ),
      klue_template: include(
        active: true,
        name: 'gem'
      ),
      include_action_text: true,
      include_active_storage: true,
      include_sample_models: true,
      include_javascript_libraries: true,
      include_devise: true,
      include_rspec: true,
      include_common_pages: true,
      run_db_migrate: true
    )
  end
end

RSpec.shared_examples :expected_data_gem_library_project do
  it 'has the correct attributes' do
    is_expected.to include(
      name: 'my_gem_library',
      type: :gem,
      variant: :library,
      root_path: '~/dev/kgems',
      description: 'this is a an awesome ruby gem',
      github_key: 'klueless-io',
      story: include(
        active: true,
        actor: 'Developer',
        problem: 'fix bugs quickly',
        solution: 'can be more productive',
        user_story: 'As a developer, I want to fix bugs quickly, so that I can be more productive.'
      ),
      klue_template: include(
        active: true,
        name: 'gem'
      ),
      exe: true,
      coc: true,
      mit: true,
      rspec: true
    )
  end
end

RSpec.shared_examples :expected_data_gem_cli_project do
  it 'has the correct attributes' do
    is_expected.to include(
      name: 'my_gem_cli',
      type: :gem,
      variant: :cli,
      root_path: '~/dev/kgems',
      description: 'this is a an awesome ruby gem',
      github_key: 'klueless-io',
      story: include(
        active: true,
        actor: 'Developer',
        problem: 'fix bugs quickly',
        solution: 'can be more productive',
        user_story: 'As a developer, I want to fix bugs quickly, so that I can be more productive.'
      ),
      klue_template: include(
        active: true,
        name: 'gem'
      ),
      exe: true,
      coc: true,
      mit: true,
      rspec: true
    )
  end
end

RSpec.shared_examples :expected_data_kbuilder_project do
  it 'has the correct attributes' do
    is_expected.to include(
      name: '.builder',
      type: :k_builder,
      variant: nil,
      root_path: '~/dev/some_path',
      description: 'this is a kbuilder addon to a project',
      github_key: 'klueless-io',
      story: include(
        active: true,
        actor: 'Developer',
        problem: 'fix bugs quickly',
        solution: 'can be more productive',
        user_story: 'As a developer, I want to fix bugs quickly, so that I can be more productive.'
      ),
      klue_template: include(
        active: true,
        name: 'gem'
      )
    )
  end
end

RSpec.shared_examples :expected_data_svelte_project do
  it 'has the correct attributes' do
    is_expected.to include(
      name: 'my_first_svelte_app',
      type: :svelte,
      variant: nil,
      root_path: '~/dev/tut-js',
      description: 'this is my first svelte application',
      github_key: 'klueless-io',
      story: include(
        active: true,
        actor: 'Developer',
        problem: 'fix bugs quickly',
        solution: 'can be more productive',
        user_story: 'As a developer, I want to fix bugs quickly, so that I can be more productive.'
      ),
      klue_template: include(
        active: true,
        name: 'gem'
      )
    )
  end
end

RSpec.shared_examples :expected_data_nuxt_project do
  it 'has the correct attributes' do
    is_expected.to include(
      name: 'my_first_nuxt_app',
      type: :nuxt,
      variant: nil,
      root_path: '~/dev/tut-js',
      description: 'this is my first nuxt application',
      github_key: 'klueless-io',
      story: include(
        active: true,
        actor: 'Developer',
        problem: 'fix bugs quickly',
        solution: 'can be more productive',
        user_story: 'As a developer, I want to fix bugs quickly, so that I can be more productive.'
      ),
      klue_template: include(
        active: true,
        name: 'gem'
      )
    )
  end
end
