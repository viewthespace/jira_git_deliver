describe JiraGitDeliver::Deliverer do
  describe '#deliver' do

    let(:jira) { instance_double('JiraGitDeliver::Jira') }
    let(:git) { instance_double('JiraGitDeliver::Git') }

    subject { JiraGitDeliver::Deliverer.new(jira, git) }

    it 'delivers issues found by git' do
      expect(jira).to receive(:finished_issues).with('test jql').and_return([OpenStruct.new(key: 'TEST-1')])
      expect(git).to receive(:contains?).with('TEST-1').and_return(true)
      expect(jira).to receive(:deliver).with('TEST-1', 'test')

      subject.deliver('test jql', 'test')
    end

    it 'does nothing if no issues are found in git' do
      expect(jira).to receive(:finished_issues).with('test jql').and_return([OpenStruct.new(key: 'TEST-1')])
      expect(git).to receive(:contains?).with('TEST-1').and_return(false)
      expect(jira).not_to receive(:deliver)

      subject.deliver('test jql', 'test')
    end

    it 'does nothing if no issues are found in JIRA' do
      expect(jira).to receive(:finished_issues).with('test jql').and_return([])
      expect(git).not_to receive(:contains?)

      subject.deliver('test jql', 'test')
    end

    it 'doesn\'t transition issues in dry run mode' do
      expect(jira).to receive(:finished_issues).with('test jql').and_return([OpenStruct.new(key: 'TEST-1')])
      expect(git).to receive(:contains?).with('TEST-1').and_return(true)
      expect(jira).not_to receive(:deliver)
      subject = JiraGitDeliver::Deliverer.new(jira, git, true) # dry_run = true

      subject.deliver('test jql', 'test')
    end
  end
end
