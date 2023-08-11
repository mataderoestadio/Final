class Postulation < ApplicationRecord
    belongs_to :user
    belongs_to :job 
  
    validates :kind , acceptance: {
      accept: %w[Postula],
    }
  
    def self.kinds
      %w[Postula]
    end
  end

