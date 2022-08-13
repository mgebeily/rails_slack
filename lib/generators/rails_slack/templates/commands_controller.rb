class RailsSlack::CommandsController < RailsSlack::Base::CommandsController
  def ping
    render json: { text: 'pong' }
  end
end
