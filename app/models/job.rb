class Job < ApplicationRecord
    has_many :postulations
    has_many :users, through: :postulations
end
