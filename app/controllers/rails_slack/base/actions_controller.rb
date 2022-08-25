require 'net/http'

require_dependency "rails_slack/application_controller"

class RailsSlack::Base::ActionsController < RailsSlack::ApplicationController
  def create
    slack_params[:actions].each do |action|
      # TODO: Make this parallelizable
      @action = sanitize_action(action[:action_id])
      send(@action, action)
    end

    head :ok
  end

  protected

  def respond(file = nil, response_type = 'ephemeral')
    @response_type = response_type
    content = render_to_string(file || @action, layout: 'rails_slack/text', formats: [:text])

    Net::HTTP.post(URI(slack_params[:response_url]), content, { "Content-Type" => 'application/json'})
  end

  def respond_with_blocks(action, file = nil, response_type = 'ephemeral')
    @response_type = response_type
    content = render_to_string(file || @action, formats: [:json])

    Net::HTTP.post(URI(slack_params[:response_url]), content, { "Content-Type" => 'application/json'})
  end

  def respond_with_text(text)
    Net::HTTP.post(URI(slack_params[:response_url]), { text: text }.to_json, { "Content-Type" => 'application/json'})
  end

  def sanitize_action(action_id)
    action_id.underscore
  end

  def current_team
    @current_team ||= Team.find_by(team_id: slack_params[:user][:team_id])
  end

  def slack_params
    @slack_params ||= JSON.parse(params[:payload]).with_indifferent_access
  end
end
