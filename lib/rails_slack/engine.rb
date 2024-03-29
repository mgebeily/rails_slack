module RailsSlack
  class Engine < ::Rails::Engine
    isolate_namespace RailsSlack

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end

module ActionDispatch::Routing
  class Mapper
    def mount_slack_routes(path = '', options = { controllers: {} })
      controllers = options[:controllers]

      scope(path: path, as: 'rails_slack') do
        resources :teams, only: [], controller: options[:controllers][:teams] || 'rails_slack/teams' do
          collection do
            get :callback
          end
        end

        resources :commands, only: [:create], controller: options[:controllers][:commands] || 'rails_slack/commands'
        resources :actions, only: [:create], controller: options[:controllers][:actions] || 'rails_slack/actions'
        resources :events, only: [:create], controller: options[:controllers][:events] || 'rails_slack/events'
      end
    end
  end
end
