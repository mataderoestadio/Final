class Postulation < ApplicationRecord
  order('created_at DESC')
    belongs_to :user, dependent: :destroy
    belongs_to :job, dependent: :destroy 
  
    validates :kind , acceptance: {
      accept: %w[Postula],
    }
  
    def self.kinds
      %w[Postula]
    end
  end

