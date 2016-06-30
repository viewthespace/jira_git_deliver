require 'jira'

module JiraGitDeliver
  class Jira
    def initialize(oauth_access_token:, oauth_secret:, rsa_key: nil, consumer_key:, site:)
      options = {
        :private_key_file => "rsakey.pem",
#        :private_key => rsa_key,
        :context_path     => '',
        :consumer_key     => consumer_key,
        :site             => site
      }

      @client = ::JIRA::Client.new(options)
      @client.set_access_token(oauth_access_token, oauth_secret)
    end

    def find_issue(issue)
      @client.Issue.find(issue)
    end

    def deliver(issue, transition_name)
      transition_id = transitions(issue)[transition_name]
      transition_issue(issue, transition_name)
    end

    def dump_transitions(issue)
      issue = @client.Issue.find(issue)
      available_transitions = @client.Transition.all(:issue => issue)
      available_transitions.each { |ea| puts "#{ea.name} (id #{ea.id})" }
    end

    # see http://www.rubydoc.info/gems/jira-ruby/0.1.18/JIRA/Resource/Issue
    # for search options
    def finished_issues(query = nil)
      @client.Issue.jql(query)
    end

    def transitions(issue)
      fetch_transitions(issue).each_with_object({}) { |v,hash| hash[v.name] = v.id }
    end

    private

    def transition_issue(issue, transition_id)
      issue = @client.Issue.find(issue)
      transition = issue.transitions.build
      transition.save!("transition" => { "id" => transition_id })
    end

    def fetch_transitions(issue)
      # each issue might have different transitions, so we have to query for each issue
      # this is slow
      issue_obj = @client.Issue.find(issue)
      available_transitions = @client.Transition.all(:issue => issue_obj)
    end
  end
end
