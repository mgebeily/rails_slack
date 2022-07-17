$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "rails_slack/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "rails_slack"
  spec.version     = RailsSlack::VERSION
  spec.authors     = ["Marc Gebeily"]
  spec.email       = ["m.gebeily@gmail.com"]
  spec.homepage    = "https://www.github.com/groomba-ai/rails_slack"
  spec.summary     = "Summary of RailsSlack."
  spec.description = "Description of RailsSlack."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 7.0.3", ">= 7.0.3.1"
  spec.add_dependency "slack-ruby-client"

  spec.add_development_dependency "pg"
  spec.add_development_dependency "rspec-rails"
end
