require 'slack-ruby-client'

module RailsSlack
  class Team < ApplicationRecord
    belongs_to :owner, polymorphic: true, optional: true

    def slack_client
      @slack_client ||= ::Slack::Web::Client.new(token: token)
    end

    def send_message(channel, message, locals = {})
      response = ApplicationController.new.render_to_string(
        template: "rails_slack/messages/#{message}",
        # TODO: This is deprecated in Rails 7
        locals: locals.transform_keys { |x| x.starts_with?('@') ? x : "@#{x}".to_sym },
        formats: [:json]
      )

      slack_client.chat_postMessage(channel:, blocks: JSON.parse(response)['blocks'])
    end
  end
end
