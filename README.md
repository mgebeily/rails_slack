# RailsSlack
A simple Rails plugin for quickly adding Slack bot functionality to your application.

Comes with support for Slack's OAuth.

## Usage

### Getting started
Before installing, I recommend committing anything outstanding just in case you want to revert any of the generated code.

For a full, out-of-the-box installation, run:

```bash
rails generate rails_slack:initialize
```
This will:

1. Add the necessary route helpers to your `routes.rb` file.
2. Add a `slack` namespace and 4 controllers to your controller folder.
3. Add a `rails_slack` initializer with some explicit defaults to your `config/initializers`
4. Install migrations for storing teams through OAuth.

### Viewing the app manifest.
Slack allows you to upload an app manifest in lieu of configuring an app through their UI. This gem provides a helper for generating this manifest from your code. Simply run:

```bash
rails rails_slack:print_manifest.
```

Note that for this to work correctly, you have to have `Rails.application.routes.default_url_options[:host]` set for your environment to generate absolute URLs accessible by slack. `ngrok` is invaluable for testing on local development environments!

### Adding functionality
After specifying events and commands in your `config/initializers/rails_slack` file and creating an app from the uploaded manifest (or configuring correctly through the Slack UI), you can handle any incoming events, commands, or actions through your controller actions.

Commands, events, and actions are all handled by controller methods corresponding to their names. For example, the default "/ping" command is handled in `slack/commands_controller.rb`:

```ruby
class RailsSlack::CommandsController < RailsSlack::Base::CommandsController
  def ping
    # Respond to the ping with a pong.
    render json: { text: 'pong' }
  end
end
```

Commands and events not specified in your initializer will render a 404. You can also call `slack_client` from these controllers to access an authenticated [ruby-slack-client](https://github.com/slack-ruby/slack-ruby-client) object for further interaction. You can also call `current_team` to get the `RailsSlack::Team` object corresponding to the Slack team from which the event was generated.

### Overriding Teams functionality
By default, `rails_slack` stores all teams in the `rails_slack_teams` table, under the `RailsSlack::Team` model.

The `teams_controller` handles logic around the OAuth flow, including `RailsSlack::Team` creation and after-create redirects.

By default, the `teams_controller` redirects to the root_url after creating a team. To override this, add a method `after_callback` to your `teams_controller` specifying the desired behavior:

```ruby
class RailsSlack::TeamsController < RailsSlack::Base::TeamsController
  def after_callback
    do_something
    redirect_to a_different_url
  end
end
```

Sometimes, it may be desirable to have another model "own" the `RailsSlack::Team`: for example, an existing `Organization` or `User` model corresponding to your own app-specific behavior. To facilitate this, `RailsSlack::Team` objects have an optional, polymorphic `owner` relation that allows you to specify such relations while still keeping the table relatively isolated. To easily set this, simply override the `owner` method on the `teams_controller`:

```ruby
class RailsSlack::TeamsController < RailsSlack::Base::TeamsController
  before_action :require_user

  def owner
    current_user
  end
end
```

You can then add this to your owner class to specify the relation:

```ruby
class User < ApplicationRecord
  has_one :team, class_name: RailsSlack::Team, inverse_of: 'owner'
end
```

To persist state through the registration process (and allow for things like associating a `RailsSlack::Team` with a user authed through your interface), simply pass `state` to the Slack OAuth URL. This can be accessed through the `state` helper.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rails_slack'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails_slack
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
