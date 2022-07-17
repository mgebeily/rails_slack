class Slack::CommandsController < RailsSlack::CommandsController
  def ping
    render json: { text: 'pong' }
  end
end
