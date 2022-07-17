RailsSlack.configure do |config|
  config.scopes = ['commands']
  config.commands = [{ command: '/ping', description: 'Pings the bot.' }]
  config.events = []

  config.client_id = ENV['SLACK_CLIENT_ID']
  config.client_secret = ENV['SLACK_CLIENT_SECRET']
  config.signing_secret = ENV['SLACK_SIGNING_SECRET']

  config.manifest = {
    display_information: {
      name: Rails.application.class.module_parent.to_s.underscore.humanize
    },
    features: {
      bot_user: {
        display_name: Rails.application.class.module_parent.to_s.underscore.humanize + ' bot'
      }
    }
  }
end
