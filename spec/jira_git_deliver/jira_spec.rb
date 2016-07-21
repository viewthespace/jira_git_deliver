describe ::JiraGitDeliver::Jira do

  subject {
    JiraGitDeliver::Jira.new(
      oauth_access_token: "6b3IhroJMCcX0rbEzRSgM7jgNZXNjk8B",
      oauth_secret: "8TbmDzHUwJEOV0txiS1dxc9x0OFU31XH",
      consumer_key: "354ddbf22946b9d25c69f6487ec52653",
      site: "https://viewthespace.atlassian.net"

      #TODO test using private key as string instead of file
    )
  }

  # just a simple test to make sure that connectivity works
  describe '#find_issue' do
    it 'finds an issue' do
      subject.find('TEST-1')
    end
  end

  describe '#deliver', vcr: { record: :once } do
    it 'delivers an issue given the transition name' do
      subject.deliver('TEST-1', "Done")
      #TODO expect issue to be delivered
    end
  end

  describe '#finished_issues' do
    it 'gets finished issues' do
      VCR.use_cassette('jira_spec', :record => :new_episodes) do
        finished = subject.finished_issues('project = TEST AND status = "In Progress"')
          .collect(&:key)
        expect(finished).to eq ['TEST-1']
      end
    end
  end

  # describe '#dump-transitions' do
  #   it 'dumps a list of transitions' do
  #     subject.dump_transitions('TEST-1')
  #   end
  # end

  describe '#transitions', vcr: { record: :once } do
    it 'gets the transitions' do
      expect(subject.transitions('TEST-1')).to eq({"To Do"=>"11", "In Progress"=>"21", "Done"=>"31"})
    end
  end
end
