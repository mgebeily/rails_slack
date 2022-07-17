module RailsSlack
  class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    before_action :validate_request

    protected

    def slack_client
      @slack_client ||= Slack::Web::Client.new(token: current_team.token)
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
