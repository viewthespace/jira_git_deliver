require 'pry'

module JiraGitDeliver
  class Deliverer
    def initialize(jira, git = nil, dry_run = false, generate_json_report = false)
      @jira = jira
      @git = git ||= JiraGitDeliver::Git.new
      @dry_run = dry_run
      @generate_json_report = generate_json_report
      @transitioned_issues = []
    end

    # finds issues in delivered status (using JQL query)
    # and checks the git log to see if any issues are tagged in commit messages
    # and transitions them to delivered status
    def deliver(jql, delivered_status_name)
      @jira.finished_issues(jql).map(&:key).each do |issue|
        # there's a bug here where the tip of the git log might contain changes that
        # haven't yet passed a build, to fix this should be able to specify the latest sha to search from
        if @git.contains?(issue)
          @jira.deliver(issue, delivered_status_name) unless @dry_run
          puts "delivered issue: #{issue}"
          #TODO project.comment(story, server_name) if server_name
          @transitioned_issues << issue
        end
      end
    end

    def changes_json
      @changed_issues = @transitioned_issues.map do |issue_number|
        issue = @jira.find_issue(issue_number)
        change = {}
        change[:summary] = issue.summary
        change[:number] = issue_number
        change[:type] = issue.fields['issuetype']['name']
        change[:type_id] = issue.fields['issuetype']['id']
        change
      end
      @changed_issues.to_json
    end

    def changes_json_to_file(filename = 'report.json')
      File.open(filename, 'w') do |f|
        f << @changed_issues.to_json
      end
    end
  end
end
