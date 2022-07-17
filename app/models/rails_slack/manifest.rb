class RailsSlack::Manifest
  include Rails.application.routes.url_helpers

  def generate
    RailsSlack.configuration.manifest.deep_merge({
      features: {
        slash_commands: formatted_commands
      },
      settings: {
        interactivity: interactivity,
        event_subscriptions: {
          bot_events: RailsSlack.configuration.events,
          request_url: rails_slack_events_url,
        }
      },
      oauth_config: {
        scopes: {
          bot: RailsSlack.configuration.scopes
        },
        redirect_urls: [
          callback_rails_slack_teams_url
        ]
      }
    })
  end

  private

  def interactivity
    return { is_enabled: false } unless RailsSlack.configuration.actions_controller.present?

    {
      is_enabled: true,
      request_url: rails_slack_actions_url
    }
  end

  def formatted_commands
    RailsSlack.configuration.commands.map { |command| command.merge({ url: rails_slack_commands_url }) }
  end
end
