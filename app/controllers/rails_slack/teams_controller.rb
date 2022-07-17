require_dependency "rails_slack/application_controller"

module RailsSlack
  class TeamsController < ApplicationController
    skip_before_action :validate_request

    def callback
      return head(:bad_request) unless params[:code].present?

      team = Team.find_by(team_id: result.team.id)

      if team.present?
        team.update(
          owner: owner,
          token: result.access_token,
          name: result.team.name,
          scope: result.scope,
          authed_user_id: result.authed_user.id
        )
      else
        Team.create!(
          team_id: result.team.id,
          owner: owner,
          token: result.access_token,
          name: result.team.name,
          scope: result.scope,
          authed_user_id: result.authed_user.id
        )  
      end

      after_callback
    end

    protected

    def after_callback
      redirect_to '/'
    end

    # Override this to be an ActiveRecord model
    def owner
      nil
    end

    def state
      result.state
    end

    private

    def result
      return @result if @result.present?

      client = Slack::Web::Client.new

      @result = client.oauth_v2_access({
        client_id: RailsSlack.configuration.client_id,
        client_secret: RailsSlack.configuration.client_secret,
        code: params[:code]
      })
    end
  end
end
