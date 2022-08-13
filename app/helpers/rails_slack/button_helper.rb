module RailsSlack
  module ButtonHelper
    def render_login_with_slack_button

    end

    def login_with_slack_link(state: '')
      "https://slack.com/oauth/v2/authorize?client_id=#{RailsSlack.configuration.client_id}&scope=#{scope}&state=#{state}"
    end

    private

    def scope
      RailsSlack.configuration.scopes.join(',')
    end
  end
end