require 'slack-ruby-client'

module RailsSlack
  class Team < ApplicationRecord
    belongs_to :owner, polymorphic: true, optional: true

    def slack_client
      @slack_client ||= ::Slack::Web::Client.new(token: token)
    end
  end
end
