# frozen_string_literal: true

require 'octokit'

class GitHubHelper
  def self.setup_api_client(access_token = nil)
    access_token ||= ENV['GITHUB_ACCESS_TOKEN']
    github_api = Octokit::Client.new(access_token: access_token)
  end

  def self.get_full_repository_name(repo_name, github_username = nil)
    github_username ||= ENV['GITHUB_USER']
    repo_name ||= ENV['GITHUB_REPO_NAME']

    "#{github_username}/#{repo_name}"
  end

  def initialize(api_client, repository_name = nil)
    @github_api_client = api_client
    @repository_name = self.class.get_full_repository_name(repository_name || ENV['GITHUB_REPO_NAME'])
  end

  def set_repository(repository_name)
    @repository_name = self.class.get_full_repository_name(repository_name)
  end

  def create_repository(name, auto_init_repo = true)
    @github_api_client.create_repository(name, { auto_init: auto_init_repo })
  end

  def delete_repository(repository_name = nil)
    repository_name ||= @repository_name
    @github_api_client.delete_repository(repository_name)
  end

  def create_pull_request(branch_name, title, description = nil, branch_to_merge_into = 'master', is_draft = false)
    @github_api_client.create_pull_request(
      @repository_name, branch_to_merge_into,
      ref_prefix_branch(branch_name),
      title, description, draft: is_draft
    )
  end

  def create_branch(branch_name, branch_from = 'master')
    #     Find the revision you want to branch from.
    ref_results = @github_api_client.refs(@repository_name)
    source_ref = ref_results.detect { |ref| ref.ref == ref_prefix_branch(branch_from) }
    source_ref_sha = source_ref.object.sha
    @github_api_client.create_ref(@repository_name, ref_prefix_branch(branch_name), source_ref_sha)
  end

  def add_new_file(branch_name, path, commit_message, contents = nil, committer_data = nil)
    @github_api_client.create_contents(@repository_name, path, commit_message, contents,
                                       branch: branch_name, committer: committer_data)
  end

  def update_file(file_sha, branch_name, path, commit_message, contents = nil, committer_data = nil)
    @github_api_client.update_contents(@repository_name, path, commit_message, file_sha, contents,
                                       branch: branch_name, committer: committer_data)
  end

  def ref_prefix_branch(branch_name)
    ref_prefix = 'refs/heads'
    "#{ref_prefix}/#{branch_name}"
  end

  def user_info(name, email)
    { name: name, email: email }
  end

  def create_blob; end
end
