require_dependency "rails_slack/application_controller"

class RailsSlack::Base::EventsController < RailsSlack::ApplicationController
  skip_before_action :validate_request, only: [:create]

  def create
    return render(plain: params[:challenge]) if params[:challenge].present?

    validate_request

    send(sanitize_event(slack_params[:event]))
  end

  protected

  def sanitize_event(event)
    event.gsub(/\./, '_').underscore
  end

  def slack_params
    params.permit(:event)
  end
end
