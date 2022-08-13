namespace :rails_slack do
  desc 'Print a Slack Manifest file of your app based on its configuration.'
  task print_manifest: :environment do
    puts JSON.pretty_generate(RailsSlack::Manifest.new.generate)
  end
end
