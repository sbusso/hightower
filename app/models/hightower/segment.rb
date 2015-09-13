module Hightower
  class Segment < ActiveRecord::Base
    has_many :personas
    has_many :unprocessed_personas, -> { unprocessed }, class_name: 'Hightower::Persona'
    has_many :unprocessed_users, source: :user, through: :unprocessed_personas
    has_many :users, through: :personas
      
    validates :name, presence: true

    def self.for(behaviour)
      where(nane: behaviour.name).take
    end

    def add_users(users)
      self.users << (Array(users) - self.users)
    end

    def mark_as_processed
      personas.update_all(processed: true)
    end
  end
end
