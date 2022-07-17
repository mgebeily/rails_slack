require "rails_slack/engine"
require "rails_slack/configuration"

module RailsSlack
  # Your code goes here...
  class << self
    def configuration
      @configuration ||= RailsSlack::Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
