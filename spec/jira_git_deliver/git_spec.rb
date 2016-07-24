describe JiraGitDeliver::Git do

  let(:message) { "[Fixes #TEST-1]" }
  let(:query) { "git log --grep='#{message}'" }
  let(:result) { "Some git message" }
  let(:git) { JiraGitDeliver::Git.new }

  describe '#contains?' do
    it 'finds the message in the git log using system call' do
      expect(git).to receive(:`).with(query) { result }
      expect(git.contains?(message)).to eq(true)
    end
  end
end
