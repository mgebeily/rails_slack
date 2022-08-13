require 'slack-ruby-client'

module RailsSlack
  class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    before_action :validate_request

    protected

    def render_response(file = nil, response_type = 'ephemeral')
      @response_type = response_type
      render file, layout: 'rails_slack/text', formats: [:text]
    end

    def render_blocks(file = nil, response_type = 'ephemeral')
      @response_type = response_type
      render file, formats: [:json]
    end

    def render_text(text)
      render json: { text: text }, status: 200
    end

    def slack_client
      @slack_client ||= current_team.slack_client
    end

    def current_team
      @current_team ||= Team.find_by(team_id: slack_params[:team_id])
    end

    private

    def slack_request
      @slack_request ||= Slack::Events::Request.new(request, {
        signing_secret: RailsSlack.configuration.signing_secret
      })
    end

    def validate_request
      slack_request.verify!
    end
  end
end
