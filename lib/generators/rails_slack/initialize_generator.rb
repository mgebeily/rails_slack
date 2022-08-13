module RailsSlack
  class InitializeGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
  
    def create_initializer_file
      route "mount_slack_routes('/slack')"
  
      copy_file 'initializer.rb', 'config/initializers/rails_slack.rb'
      copy_file 'events_controller.rb', 'app/controllers/rails_slack/events_controller.rb'
      copy_file 'commands_controller.rb', 'app/controllers/rails_slack/commands_controller.rb'
      copy_file 'actions_controller.rb', 'app/controllers/rails_slack/actions_controller.rb'
      copy_file 'teams_controller.rb', 'app/controllers/rails_slack/teams_controller.rb'
  
      rake "rails_slack:install:migrations"
    end
  end
end
