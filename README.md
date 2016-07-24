[![CircleCI](https://circleci.com/gh/viewthespace/jira_git_deliver.svg?style=svg)](https://circleci.com/gh/viewthespace/jira_git_deliver)
[![Code Climate](https://codeclimate.com/repos/5792a96bdece34007d00a71f/badges/66036927f73d6aad1e3d/gpa.svg)](https://codeclimate.com/repos/5792a96bdece34007d00a71f/feed)

# JiraGitDeliver

This gem is based heavily on the `tracker-git` gem

https://github.com/robb1e/tracker-git

## Installation

Add this line to your application's Gemfile:

    gem 'jira_git_deliver'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jira_git_deliver

## Usage

This gem includes a ruby script at `bin/jira_git_deliver` that transitions
the JIRA issues.

## Configuration

### JIRA API configuration

* TODO describe how to set up JIRA credentials

* generate consumer key

SecureRandom.hex(16)

* generate RSA keypair

openssl req -x509 -nodes -newkey rsa:1024 -sha1 -keyout rsakey.pem -out rsacert.pem

JIRA Administration -> Applications -> Application Links
enter name of application (it asks for a URL, just put any string)
click "Create new Link"
error dialog ("No response was received...") click Continue

Application Name: name of the Script
Application Type: "Generic Application"
do not enter consumer key here
edit the application (pencil icon)

select "Incoming Authentication"
enter the consumer key

click "Save"


run oauth script (rsakey.pem file expected in current dir)

browser will open (image here)

click ...

browser will show "Access Approved" message with a verification code
enter this code on the command line prompt
and return the access token and secret



* get OAuth access token and secret

### Gem configuration

The gem expects several environment variables for JIRA API client configuration.

JIRA_OAUTH_ACCESS_TOKEN

JIRA_OAUTH_SECRET

JIRA_CONSUMER_KEY

JIRA_PRIVATE_KEY The text of the RSA private key
JIRA_SITE The URL of the JIRA server

If the private key is not set, the gem defaults to a file called "rsakey.pem"

* TODO describe setting up query

JIRA_DELIVERED_STATUS=Done
JIRA_FINISHED_ISSUES_JQL=project = TEST AND status = 'In Progress'

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jira_git_deliver/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Setting up tests

* TODO talk about setting up JIRA for testing
