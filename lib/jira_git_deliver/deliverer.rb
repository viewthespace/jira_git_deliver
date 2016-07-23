module JiraGitDeliver
  class Deliverer
    def initialize(jira, git, dry_run = false)
      @jira = jira
      @git = git
      @dry_run = dry_run
    end

    # finds issues in delivered status (according to JQL query)
    # and checks the git log to see if any issues are tagged in commit messages
    # and transitions them to delivered status
    def deliver(jql, delivered_status_name)
      @jira.finished_issues(jql).map(&:key).each do |issue|
        if @git.contains?(issue)
          @jira.deliver(issue, delivered_status_name) unless @dry_run
          puts "delivered issue: #{issue}"
          #TODO project.comment(story, server_name) if server_name
        end
      end
    end
  end
end
