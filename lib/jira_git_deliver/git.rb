module JiraGitDeliver
  class Git
    def contains?(message)
      result = `git log --grep='#{message}'`
      result.length > 0
    end
  end
end
