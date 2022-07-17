module RailsSlack
  class Configuration
    attr_accessor :scopes, :commands, :events, :manifest, :client_id, :client_secret, :signing_secret

    def initialize
      self.scopes = ['commands']
      self.commands = [{ command: '/ping', description: 'Pings the bot.' }]
      self.events = []

      self.client_id = ENV['SLACK_CLIENT_ID']
      self.client_secret = ENV['SLACK_CLIENT_SECRET']
      self.signing_secret = ENV['SLACK_SIGNING_SECRET']

      self.manifest = {
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
  end
end
