require_dependency "rails_slack/application_controller"

module RailsSlack
  class CommandsController < ApplicationController
    def create
      return head(:not_found) unless valid_commands.include?(params[:command])

      send(sanitize_command(params[:command]))
    end

    protected

    def ping
      render json: { text: pong }
    end

    def valid_commands
      RailsSlack.configuration.commands.map { |command| command[:command]  }
    end

    def sanitize_command(command)
      command.gsub(/^\//, '').underscore
    end

    def slack_params
      params.permit(:team_id)
    end
  end
end
