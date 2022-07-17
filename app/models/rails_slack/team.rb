module RailsSlack
  class Team < ApplicationRecord
    belongs_to :owner, polymorphic: true, optional: true
  end
end
