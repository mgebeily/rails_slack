require_dependency "rails_slack/application_controller"

class RailsSlack::Base::ActionsController < RailsSlack::ApplicationController
  def create
    send(sanitize_action(slack_params[:action]))
  end

  protected

  def sanitize_action(action)
    action
  end

  def slack_params
    params.permit(:action)
  end
end
