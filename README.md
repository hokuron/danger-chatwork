# danger-chatwork

A [Danger](http://danger.systems/ruby/) plugin that notifies reports in Dangerfile to ChatWork.

## Installation

### Gemfile

    gem 'danger-chatwork'

### Global Gem

    gem install danger-chatwork

## Setup

You need set your ChatWork API token.

In Dangerfile

    chatwork.api_token = 'YOUR_CHATWORK_API_TOKEN'

Or set Environment variable `CHATWORK_API_TOKEN`,  
for example in Jenkinsfile

    pipeline {
      ...
      environment {
        CHATWORK_API_TOKEN = credentials('chw_access_token')
      }
      ...
    }

## Usage

In Dangerfile

    chatwork.notify(room_id: xxxxxxxx)

Or, arbitrary messages without reports

    chatwork.notify(room_id: xxxxxxxx, text: 'YOUR MEASSAGES')

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
