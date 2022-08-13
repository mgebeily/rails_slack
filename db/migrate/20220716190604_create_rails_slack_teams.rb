class CreateRailsSlackTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :rails_slack_teams do |t|
      t.belongs_to :owner, polymorphic: true

      t.string :team_id, index: true, null: false
      t.string :authed_user_id
      t.string :token
      t.string :name
      t.string :scope
      t.boolean :active
      t.json :settings, default: {}

      t.timestamps
    end
  end
end
